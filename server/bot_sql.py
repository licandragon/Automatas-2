import sys
import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(
        host="localhost",
        port="3307",
        user="root",
        passwd="",
        database="refacciones_bot"
    )
except mysql.connector.Error as err:
    print(f"Error al conectar a la basee de datos: {err}")
    sys.exit()

print("Conectado a la base de datos")
cursor = connection.cursor()

cursor.close()
