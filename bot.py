import json
import logging
import random
from typing import Final

import mysql.connector
from telegram import Update, BotCommand, KeyboardButton, ReplyKeyboardMarkup, \
    ReplyKeyboardRemove, InlineKeyboardMarkup, InlineKeyboardButton
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes, Application, ConversationHandler, \
    MessageHandler, filters, CallbackQueryHandler

TOKEN: Final = "6968150664:AAH4DuDUsdZoBgnF-kRD8ctSizMW_gMq5q8"

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

SEARCH_CHOSE, SEARCH_NORMAL, SEARCH_ADVANCED, SEARCH_TRUCK, SEARCH_MODEL, SEARCH_YEAR, SEARCH_PART, SEARCH_DETAILS, \
    SEARCH_CONFIRM, DISPLAY_RESULTS, SHOW_DETAILS = range(11)


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
        print(bot_commands)
        print(language)
        await application.bot.set_my_commands(bot_commands, scope=None, language_code=language)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    uuid = update.effective_user.id
    commands = await context.bot.get_my_commands()

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
        except mysql.connector.Error as err:
            logger.error(f"Error al ejecutar la consulta en la base de datos: {err}")
        finally:
            connection.close()

    await update.message.reply_text(f'Hola bienvenido, ¿En qué puedo ayudarte {update.effective_user.first_name}?')


async def chose_search(update: Update, context: ContextTypes.DEFAULT_TYPE):
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
    search_state = context.user_data["search_state"]
    await update.message.reply_text('Estas en el modo normal', reply_markup=ReplyKeyboardRemove())

    return ConversationHandler.END


#SELECT r.refaccion_id, r.nombre AS nombre_refaccion, r.numero_parte, p.nombre ASnombre_proveedor, c.nombre AS
# nombre_categoria,r.descripcion, r.especificaciones,r.imagen, r.activo,r.stock, r.precio FROM refacciones r INNER JOIN
# provedoores p ON r.proveedor_id = p.proveedor_id INNER JOIN categorias c ON r.categoria_id = c.categoria_id where ;""

async def search_advanced(update: Update, context: ContextTypes.DEFAULT_TYPE):
    search_state = context.user_data["search_state"]
    await context.bot.send_message(chat_id=update.message.chat_id, text='Estas en el modo avanzado',
                                   reply_markup=ReplyKeyboardRemove())

    if search_state == SEARCH_TRUCK:
        data = update.message.text.split()
        context.user_data["modelo"] = data[0]
        if data[1]:
            context.user_data["modelo"] = data[1]
        else:
            context.user_data["modelo"] = None
        print(context.user_data["año"])
        print(context.user_data["modelo"])
        await update.message.reply_text("¿Qué pieza estas buscando?")
        context.user_data["search_state"] = SEARCH_PART
        return SEARCH_PART
    if search_state == SEARCH_PART:
        return
    if search_state == SEARCH_DETAILS:
        return
    return ConversationHandler.END


async def chose_truck(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()
    marca_id = query.data
    button_text = query.message
    marcas = context.user_data['marcas']
    print(marcas)
    context.user_data['marca_id'] = marca_id
    await query.edit_message_text(text=f"Marca seleccionada: {marcas[marca_id]}\nAhora, proporciona el *modelo* y *año "
                                       f"\(opcional\)*.", parse_mode='MarkdownV2', )
    context.user_data["search_state"] = SEARCH_TRUCK
    return SEARCH_ADVANCED


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


#search_handler = ConversationHandler(entry_points=[CommandHandler('buscar', search)],states=[
# SEARCH_TRUCK =
# ],
# fallbacks=[CommandHandler("cancel",cancel])


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
            SEARCH_MODEL: [MessageHandler(filters.TEXT & ~filters.COMMAND, search)],
            SEARCH_YEAR: [MessageHandler(filters.TEXT & ~filters.COMMAND, search)],
            SEARCH_DETAILS: [MessageHandler(filters.TEXT & ~filters.COMMAND, search)],
        },
        fallbacks=[CommandHandler('cancel', cancel)]
    )

    app.add_handler(search_handler)
    #app.add_handler(CommandHandler("promociones", promotion))
    app.add_handler(CommandHandler(["configuracion", 'setting'], config))
    app.add_handler(CommandHandler(["ayuda", 'help'], help))
    app.run_polling(allowed_updates=Update.ALL_TYPES, poll_interval=0.1)



if __name__ == '__main__':
    main()
