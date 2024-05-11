import logging, json, random
from typing import Final

import mysql.connector
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes, Application, ConversationHandler

TOKEN: Final = "6968150664:AAH4DuDUsdZoBgnF-kRD8ctSizMW_gMq5q8"

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

with open('data/respuestas.json', encoding='utf-8') as file:
    respuestas = json.load(file)

with open('data/comandos.json', encoding='utf-8') as file:
    comandos = json.load(file)


async def post_init(application: Application) -> None:
    commands = list()
    for comando in comandos['commands']:
        print(comando)
        commands.append((comando['command'], comando['description']))
    await application.bot.set_my_commands(commands)


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    uuid = update.effective_user.id
    print(uuid)
    try:
        connection = mysql.connector.connect(
            host="localhost",
            port="3307",
            user="root",
            passwd="",
            database="refacciones_bot")
        query = """SELECT * FROM usuarios WHERE uid_telegram = %s"""
        cursor = connection.cursor()
        cursor.execute(query, (uuid,))
        resultado = cursor.fetchall()
        if len(resultado) == 0:
            query = """INSERT INTO usuarios (uid_telegram) VALUES (%s)"""
            cursor.execute(query, (uuid,))
            connection.commit()
        else:
            print("Usuario ya existe")
        connection.close()
    except mysql.connector.Error as err:
        print(f"Error al conectar a la basee de datos: {err}")

    await update.message.reply_text(f'Hola bienvenido, ¿En que puedo ayudarte {update.effective_user.first_name}?')


async def search(update: Update, context: ContextTypes) -> None:
    await update.message.reply_text('Hola bienvenido')
    busqueda = context.args
    if len(busqueda) == 0:
        respuesta = random.choice(respuestas['sin_resultados'])
        await update.message.reply_text(respuesta)
    else:

        await update.message.reply_text(busqueda)


async def promotion(update: Update, context: ContextTypes) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


async def config(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


async def help(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    message = (f'Hola En que puedo ayudarte {update.effective_user.first_name} /n '
               f'si requieres revisar un comando en espeficico solo escribe el commando que quieres revisar')

    await update.message.reply_text(message)


search_handler = ConversationHandler(
    entry_points=[CommandHandler('buscar', search)],
    states=[]
)


def main() -> None:
    app = ApplicationBuilder().token(TOKEN).post_init(post_init).build()
    app.add_handler(CommandHandler("iniciar", start))
    app.add_handler(CommandHandler("buscar", search))
    app.add_handler(search_handler)
    # app.add_handler(CommandHandler("promociones", promotion))
    app.add_handler(CommandHandler("configurar", config))
    app.add_handler(CommandHandler("ayuda", help))
    app.run_polling()


if __name__ == '__main__':
    main()
