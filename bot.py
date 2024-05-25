import json
import logging
import random
from typing import Final

import mysql.connector
from telegram import Update, BotCommand, KeyboardButton, ReplyKeyboardMarkup, \
    ReplyKeyboardRemove, InlineKeyboardMarkup, InlineKeyboardButton
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes, Application, ConversationHandler, \
    MessageHandler, filters, CallbackQueryHandler

TOKEN: Final = "6968150664:AAE1bXxljBYm5-bZHArAX3k_fAJf1ZtNwtE"

TIMEOUT: Final = 20

ROW: Final = 5

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logging.getLogger("httpx").setLevel(logging.WARNING)

logger = logging.getLogger(__name__)

with open('data/respuestas.json', encoding='utf-8') as file:
    respuestas = json.load(file)

with open('data/comandos.json', encoding='utf-8') as file:
    comandos = json.load(file)

SEARCH_CHOSE, SEARCH_NORMAL, SEARCH_ADVANCED, SEARCH_TRUCK, SEARCH_MODEL, SEARCH_PART, SEARCH_DETAILS, \
    SEARCH_QUERY, DISPLAY_RESULTS, SHOW_DETAILS = range(10)


def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            port="3307",
            user="root",
            passwd="",
            database="refacciones_bot")
        return connection
    except mysql.connector.Error as err:
        logger.error(f"Error al conectar a la base de datos: {err}")
        return None


async def post_init(application: Application) -> None:
    for language in comandos:
        bot_commands = [BotCommand(cmd['command'], cmd['description']) for cmd in comandos[language]]
        #print(bot_commands)
        #print(language)
        await application.bot.set_my_commands(bot_commands, scope=None, language_code=language)


async def init_search(update: Update, context: ContextTypes.DEFAULT_TYPE):
    type_search = ReplyKeyboardMarkup([
        [KeyboardButton('Normal')], [KeyboardButton('Avanzado')]
    ], input_field_placeholder='Elige una tipo de busqueda')
    await update.message.reply_text(
        f'¿Que tipo de busqueda vas a realizar?', reply_markup=type_search
    )
    context.user_data["search_state"] = SEARCH_CHOSE
    return SEARCH_CHOSE


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    uuid = update.effective_user.id

    connection = get_db_connection()
    if connection:
        try:
            query = """SELECT * FROM usuarios WHERE uid_telegram = %s"""
            cursor = connection.cursor()
            cursor.execute(query, (uuid,))
            result = cursor.fetchall()
            if len(result) == 0:
                query = """INSERT INTO usuarios (uid_telegram) VALUES (%s)"""
                cursor.execute(query, (uuid,))
                connection.commit()
                await update.message.reply_text(
                    f'Hola bienvenido, ¿En qué puedo ayudarte {update.effective_user.first_name}?')
            else:
                await update.message.reply_text(random.choice(respuestas["bienvenidas"]))
        except mysql.connector.Error as err:
            logger.error(f"Error al ejecutar la consulta en la base de datos: {err}")
        finally:
            connection.close()

    await update.message.reply_text(f'Hola bienvenido, ¿En qué puedo ayudarte {update.effective_user.first_name}?')


#Funcion
async def chose_search(update: Update, context: ContextTypes.DEFAULT_TYPE):
    logger.info("El usuario esta seleccionando un tipo de busqueda")
    if update.message.text == "Normal":
        await update.message.reply_text(
            "Dime qué deseas buscar o si tienes el *número de parte* proporcionamelo para hacer una búsqueda en mi "
            "catálogo:",
            parse_mode='MarkdownV2', reply_markup=ReplyKeyboardRemove()
        )
        return SEARCH_NORMAL

    elif update.message.text == "Avanzado":
        await update.message.reply_text(
            "Bienvenido al modo Avanzado. En este modo te voy a solicitar datos para filtrar mejor los datos y "
            "proporcionarte lo que buscas.",
            reply_markup=ReplyKeyboardRemove()
        )

        connection = get_db_connection()
        if connection:
            try:
                query = "SELECT marca_id, nombre FROM marcas"
                cursor = connection.cursor()
                cursor.execute(query)
                results = cursor.fetchall()
                connection.close()
                marcas_data = dict()
                for marca_id, nombre in results:
                    marcas_data[str(marca_id)] = nombre
                truck_buttons = [[InlineKeyboardButton(nombre, callback_data=f"{marca_id}")] for marca_id, nombre in
                                 results]
                reply_markup = InlineKeyboardMarkup(truck_buttons)
                context.user_data["marcas"] = marcas_data
                await update.message.reply_text('Selecciona la marca de tu camión:', reply_markup=reply_markup)

                return SEARCH_TRUCK

            except mysql.connector.Error as err:
                logger.error(f"Error al ejecutar la consulta en la base de datos: {err}")
                await update.message.reply_text("Ocurrió un error al realizar la consulta. Inténtalo más tarde.")
                return ConversationHandler.END

        else:
            await update.message.reply_text("Ocurrió un error al conectar a la base de datos. Inténtalo más tarde.")
            return ConversationHandler.END

    else:
        await update.message.reply_text('Opción no reconocida. Cancelando la búsqueda.',
                                        reply_markup=ReplyKeyboardRemove())
        return ConversationHandler.END


async def search(update: Update, context: ContextTypes.DEFAULT_TYPE):
    logger.info(f'El usuario {update.effective_user.id} a comenzado una busqueda normal')
    search_term = update.message.text.lower()
    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor()
            query = """
                   SELECT 
                        r.refaccion_id,
                        r.nombre AS refaccion_nombre,
                        r.numero_parte AS 'numero_parte',
                        r.precio,
                        r.imagen,
                        GROUP_CONCAT(m.nombre,' ',ca.modelo, '(', ca.año,')') AS camiones_compatibles
                    FROM
                        refacciones r
                        JOIN provedores p ON r.provedor_id = p.proveedor_id
                        JOIN categorias c ON r.categoria_id = c.categoria_id
                        LEFT JOIN camiones_refacciones cr ON r.refaccion_id = cr.refaccion_id
                        LEFT JOIN camiones ca ON cr.camion_id = ca.camion_id
                        LEFT JOIN marcas m ON ca.marca_id = m.marca_id
                   WHERE 
                       r.nombre LIKE %s OR r.numero_parte = %s
                    GROUP BY r.refaccion_id;
               """
            cursor.execute(query, ('%' + search_term + '%', search_term))
            results = cursor.fetchall()
            connection.close()

            if results:
                #Se mustra una mensaje con una lista de los resultados y con un InlineKeyboardMarkup se maneja la
                # paginacion en caso de ser mas de 5 elementos y el usuario va a seleccionar el que elemento quiere ver sus detalles
                context.user_data['search_results'] = results
                context.user_data['current_page'] = 0
                context.user_data["msg_id"] = None
                await display_results(update, context)
                return DISPLAY_RESULTS
            else:
                await update.message.reply_text(random.choice(respuestas["sin_resultados"]))
        except mysql.connector.Error as err:
            logger.error(f"Error al ejecutar la consulta en la base de datos: {err}")
            await update.message.reply_text("Ocurrió un error al realizar la consulta. Inténtalo más tarde.")
    else:
        await update.message.reply_text("Ocurrió un error al conectar a la base de datos. Inténtalo más tarde.")
    return ConversationHandler.END


#Modo de Busqueda Avanzada permite tener un mejor control sobre la busqueda tratando de garantizar que existran
# resuktados
async def search_advanced(update: Update, context: ContextTypes.DEFAULT_TYPE):
    search_state = context.user_data["search_state"]
    if search_state == SEARCH_MODEL:
        data = update.message.text.split()
        context.user_data["modelo"] = data[0]
        if len(data) == 2:
            context.user_data["año"] = data[1]
        else:
            context.user_data["año"] = None
        print(context.user_data["año"])
        print(context.user_data["modelo"])
        await update.message.reply_text("¿Que refaccion estas buscando?")
        context.user_data["search_state"] = SEARCH_PART
        return SEARCH_PART
    elif search_state == SEARCH_PART:
        context.user_data["parte"] = update.message.text
        await context.bot.send_message(chat_id=update.effective_chat.id, text=
        f'Estas buscando *{update.message.text}*, estas buscando con alguna caracteristica'
        f' en especifico? \nEscribe No, saltarte esta opcion', parse_mode='MarkdownV2')
        context.user_data["search_state"] = SEARCH_DETAILS
        return SEARCH_DETAILS
    elif search_state == SEARCH_DETAILS:
        if update.message.text.lower() == "no":
            context.user_data["detalles"] = None
        else:
            context.user_data["detalles"] = update.message.text.split(' ')
        print(context.user_data)
        return SEARCH_QUERY
    return ConversationHandler.END


#Se selecciona que marca de camion va a requerir la refaccion
async def chose_truck(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()
    marca_id = query.data
    button_text = query.message
    marcas = context.user_data['marcas']
    print(marcas)
    context.user_data['marca_id'] = marca_id
    await query.edit_message_text(text=f"Marca seleccionada: {marcas[marca_id]}\nAhora, proporciona el *modelo* y *año "
                                       f"\(opcional\)*\.", parse_mode='MarkdownV2')
    context.user_data["search_state"] = SEARCH_MODEL
    return SEARCH_MODEL


#Aqui se contruye el query de la busqueda
async def search_query(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print("Si entro en la funcion")
    marca_id = context.user_data.get('marca_id')
    modelo = context.user_data.get('modelo')
    año = context.user_data.get('año')
    parte = context.user_data.get('parte')
    detalles = context.user_data.get('detalles')
    query = """
                  SELECT
                        r.refaccion_id,
                        r.nombre AS refaccion_nombre,
                        r.numero_parte AS 'numero_parte',
                        r.precio,
                        r.imagen,
                        GROUP_CONCAT(m.nombre,' ',ca.modelo, '(', ca.año,')') AS camiones_compatibles
                    FROM
                        refacciones r
                        JOIN categorias c ON r.categoria_id = c.categoria_id
                        LEFT JOIN camiones_refacciones cr ON r.refaccion_id = cr.refaccion_id
                        LEFT JOIN camiones ca ON cr.camion_id = ca.camion_id
                        LEFT JOIN marcas m ON ca.marca_id = m.marca_id
                        WHERE r.activo = true
               """
    conditions = []
    params = []

    if marca_id:
        conditions.append("m.marca_id = %s")
        params.append(marca_id)

    if modelo:
        conditions.append("ca.modelo LIKE %s")
        params.append('%' + modelo + '%')

    if año:
        conditions.append("ca.año = %s")
        params.append(año)

    if parte:
        conditions.append("(r.nombre LIKE %s OR r.numero_parte = %s)")
        params.append('%' + parte + '%')
        params.append(parte)

    if detalles:
        for detalle in detalles:
            conditions.append("(r.descripcion LIKE %s OR JSON_CONTAINS(r.especificaciones, %s))")
            params.append('%' + detalle + '%')
            params.append(json.dumps(detalle))

    if conditions:
        query += " AND " + " AND ".join(conditions)

    query += " GROUP BY r.refaccion_id"
    print(f'Este es el query: {query}')
    print(f'Estos son los parametros: {params}')
    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.execute(query, tuple(params))
            results = cursor.fetchall()
            connection.close()

            if results:
                context.user_data['search_results'] = results
                print(results)
                context.user_data['current_page'] = 0
                context.user_data["msg_id"] = None
                await display_results(update, context)
                return DISPLAY_RESULTS
            else:
                await update.message.reply_text(random.choice(respuestas["sin_resultados"]))
        except mysql.connector.Error as err:
            logger.error(f"Error al ejecutar la consulta en la base de datos: {err}")
            await update.message.reply_text("Ocurrió un error al realizar la consulta. Inténtalo más tarde.")
    else:
        await update.message.reply_text("Ocurrió un error al conectar a la base de datos. Inténtalo más tarde.")

    return ConversationHandler.END


async def display_results(update: Update, context: ContextTypes.DEFAULT_TYPE):
    results = context.user_data['search_results']
    page = context.user_data['current_page']

    start_index = page * ROW
    end_index = start_index + ROW
    page_results = results[start_index:end_index]

    response = f'<i>Resultados de la búsqueda:</i>\n'
    n = 0
    for i, result in enumerate(page_results, start=start_index + 1):
        response += f"[<b>{i}</b>]. <b>{result[1]}</b>(Número de parte: {result[2]}, Precio: ${result[3]}\)\n"
        n += 1

    buttons = []
    for i in range(n):
        buttons.append(InlineKeyboardButton(f'{i + 1}', callback_data=f'detail_{i}'))
    controls = []
    if start_index > 0:
        controls.append(InlineKeyboardButton('◀️', callback_data='previous'))
    controls.append(InlineKeyboardButton('❌', callback_data='cancel'))
    if end_index < len(results):
        controls.append(InlineKeyboardButton('▶️', callback_data='next'))

    reply_markup = InlineKeyboardMarkup([buttons, controls])
    if context.user_data["msg_id"] is None:
        await update.message.reply_text(response, reply_markup=reply_markup, parse_mode='html')
    else:
        await update.callback_query.edit_message_text(text=response, reply_markup=reply_markup, parse_mode='html')


async def handle_callback_query(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()

    if query.data == 'previous':
        context.user_data['current_page'] -= 1
        context.user_data["msg_id"] = query.message.message_id
        await display_results(update, context)
    elif query.data == 'next':
        context.user_data['current_page'] += 1
        context.user_data["msg_id"] = query.message.message_id
        await display_results(update, context)
    elif query.data == 'cancel':
        await query.delete_message()
        return ConversationHandler.END
    elif query.data.startswith('detail_'):
        index = int(query.data.split('_')[1])
        print(index)
        result = context.user_data['search_results'][index]
        print(result)
        response = (f"Detalles del resultado:\n"
                    f"Nombre: {result[1]}\n"
                    f"Número de parte: {result[2]}\n"
                    f"Precio: ${result[3]}\n"
                    f"Camiones compatibles: {result[5]}\n")
        await query.delete_message()
        await context.bot.send_photo(chat_id=update.effective_chat.id, photo=result[4], caption=response)
        return ConversationHandler.END


async def promotion(update: Update, context: ContextTypes) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


async def config(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


async def help(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    print(await context.bot.get_my_commands())
    message = (f'Hola En que puedo ayudarte {update.effective_user.first_name} '
               f'si requieres revisar un comando en espeficico solo escribe el commando que quieres revisar')
    await update.message.reply_text(message)


async def cancel(update: Update, context: ContextTypes.DEFAULT_TYPE) -> int:
    user = update.message.from_user
    logger.info(f'El usuario {user.first_name} ha cancelado la conversacion')
    await update.message.reply_text(f'Se ha cancelado exitosamente la operacion')
    context.user_data.clear()
    return ConversationHandler.END


async def timeout(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print("se ejecuto timeout")
    await update.message.reply_text(random.choice(respuestas["inactivity_messages"]),
                                    reply_markup=ReplyKeyboardRemove())
    context.user_data.clear()
    return ConversationHandler.END


def main() -> None:
    app = ApplicationBuilder().token(TOKEN).post_init(post_init).build()
    app.add_handler(CommandHandler(['iniciar', 'start'], start))
    search_handler = ConversationHandler(
        entry_points=[CommandHandler(['buscar', 'search'], init_search)],
        states={
            SEARCH_CHOSE: [MessageHandler(filters.TEXT & ~filters.COMMAND, chose_search)],
            SEARCH_NORMAL: [MessageHandler(filters.TEXT & ~filters.COMMAND, search)],
            SEARCH_ADVANCED: [MessageHandler(filters.TEXT & ~filters.COMMAND, search_advanced)],
            SEARCH_TRUCK: [CallbackQueryHandler(chose_truck)],
            SEARCH_MODEL: [MessageHandler(filters.TEXT & ~filters.COMMAND, search_advanced)],
            SEARCH_PART: [MessageHandler(filters.TEXT & ~filters.COMMAND, search_advanced)],
            SEARCH_DETAILS: [MessageHandler(filters.TEXT & ~filters.COMMAND, search_advanced)],
            SEARCH_QUERY: [MessageHandler(filters.TEXT & ~filters.COMMAND, search_query)],
            SHOW_DETAILS: [CallbackQueryHandler(display_results, pattern='^back$')],
            DISPLAY_RESULTS: [CallbackQueryHandler(handle_callback_query)],
            ConversationHandler.TIMEOUT: [MessageHandler(filters.TEXT | filters.COMMAND, timeout)],
        },
        fallbacks=[CommandHandler('cancel', cancel)],
        per_message=False,
        per_user=True,
        # Se establece el tiempo de inactividad si es superado finaliza la conversacion
        conversation_timeout=TIMEOUT
    )

    app.add_handler(search_handler)
    #app.add_handler(CommandHandler("promociones", promotion))
    app.add_handler(CommandHandler(["configuracion", 'setting'], config))
    app.add_handler(CommandHandler(["ayuda", 'help'], help))

    app.run_polling(allowed_updates=Update.ALL_TYPES, poll_interval=0.1)


if __name__ == '__main__':
    main()
