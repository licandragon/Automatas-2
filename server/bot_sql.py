import mysql.connector
from mysql.connector import Error

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="",
    database="bot"
)
cursor = connection.cursor()

