import os
import mysql.connector
from mysql.connector import Error

def get_connection():
    host = os.environ.get('DB_HOST', 'localhost')
    user = os.environ.get('DB_USER', 'root')
    password = os.environ.get('DB_PASSWORD', '')
    database = os.environ.get('DB_NAME', 'SecureSys')
    try:
        conn = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            autocommit=False
        )
        return conn
    except Error as e:
        raise Exception(f'Error al conectar a la base de datos: {e}')
