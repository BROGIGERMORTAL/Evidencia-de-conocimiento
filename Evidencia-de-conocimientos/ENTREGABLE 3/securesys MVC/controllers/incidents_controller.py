from models.db import get_connection
from mysql.connector import Error

def create_incidente(instalacion_id, fecha_hora, zona, tipo, descripcion, personal_involucrado, respuesta_implementada, tiempo_reaccion):
    conn = get_connection()
    try:
        cursor = conn.cursor()
        sql = """INSERT INTO incidentes_seguridad (instalacion_id, fecha_hora, zona, tipo, descripcion, personal_involucrado, respuesta_implementada, tiempo_reaccion)
                 VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
        cursor.execute(sql, (instalacion_id, fecha_hora, zona, tipo, descripcion, personal_involucrado, respuesta_implementada, tiempo_reaccion))
        conn.commit()
        return cursor.lastrowid
    finally:
        cursor.close()
        conn.close()

def read_incidentes(limit=100):
    conn = get_connection()
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT incidente_id,fecha_hora,instalacion_id,zona,tipo,descripcion,personal_involucrado,respuesta_implementada,tiempo_reaccion FROM incidentes_seguridad ORDER BY fecha_hora DESC LIMIT %s", (limit,))
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()

def update_incidente(incidente_id, **fields):
    if not fields:
        return False
    allowed = ['instalacion_id','fecha_hora','zona','tipo','descripcion','personal_involucrado','respuesta_implementada','tiempo_reaccion']
    set_clauses = []
    params = []
    for k,v in fields.items():
        if k in allowed:
            set_clauses.append(f"{k}=%s")
            params.append(v)
    params.append(incidente_id)
    sql = f"UPDATE incidentes_seguridad SET {', '.join(set_clauses)} WHERE incidente_id=%s"
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute(sql, tuple(params))
        conn.commit()
        return cursor.rowcount
    finally:
        cursor.close()
        conn.close()

def delete_incidente(incidente_id):
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM incidentes_seguridad WHERE incidente_id=%s", (incidente_id,))
        conn.commit()
        return cursor.rowcount
    finally:
        cursor.close()
        conn.close()
