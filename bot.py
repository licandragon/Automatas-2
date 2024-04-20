import logging
from typing import Final
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

TOKEN: Final = "6968150664:AAH4DuDUsdZoBgnF-kRD8ctSizMW_gMq5q8"

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(f'Hola bienvenido, ¿En que puedo ayudarte {update.effective_user.first_name}?')


async def search(update: Update, context: ContextTypes) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


async def promotion(update: Update, context: ContextTypes) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


async def config(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


async def help(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(f'Hola {update.effective_user.first_name}')


if __name__ == '__main__':
    app = ApplicationBuilder().token(TOKEN).build()
    app.add_handler(CommandHandler("Iniciar", start))
    app.add_handler(CommandHandler("Search", search))
    app.add_handler(CommandHandler("Promociones", promotion))
    app.add_handler(CommandHandler("Configurar", config))
    app.add_handler(CommandHandler("Ayuda", help))
    app.run_polling()
