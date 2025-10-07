import mysql.connector
from mysql.connector import pooling
import os

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "127.0.0.1"),
    "user": os.getenv("DB_USER", "root"),
    "password": os.getenv("DB_PASSWORD", ""),
    "database": os.getenv("DB_NAME", "securesys"),
    "port": int(os.getenv("DB_PORT", 3306))
}

pool = None

def init_pool(pool_name="securesys_pool", pool_size=5):
    global pool
    if pool is None:
        pool = pooling.MySQLConnectionPool(pool_name=pool_name, pool_size=pool_size, **DB_CONFIG)
    return pool

def get_connection():
    global pool
    if pool is None:
        init_pool()
    return pool.get_connection()
