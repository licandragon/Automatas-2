import logging, json, random
from typing import Final
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes, Application

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
        commands.append((comando['command'], comando['description']))
    await application.bot.set_my_commands(commands)


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(f'Hola bienvenido, ¿En que puedo ayudarte {update.effective_user.first_name}?')


async def search(update: Update, context: ContextTypes) -> None:
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
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


def main():
    app = ApplicationBuilder().token(TOKEN).post_init(post_init).build()
    app.add_handler(CommandHandler("iniciar", start))
    app.add_handler(CommandHandler("buscar", search))
    app.add_handler(CommandHandler("promociones", promotion))
    app.add_handler(CommandHandler("configurar", config))
    app.add_handler(CommandHandler("ayuda", help))
    app.run_polling()


if __name__ == '__main__':
    main()
