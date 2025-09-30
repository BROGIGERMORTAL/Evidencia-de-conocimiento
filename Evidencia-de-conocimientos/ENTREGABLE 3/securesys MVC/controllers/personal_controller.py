from models.db import get_connection

def create_personal(nombres, apellidos, documento_identidad, telefono, formacion, evaliuacion_periodica):
    conn = get_connection()
    try:
        cursor = conn.cursor()
        sql = """INSERT INTO personal_seguridad 
                 (nombres, apellidos, documento_identidad, telefono, formacion, evaluacion_periodica)
                 VALUES (%s, %s, %s, %s, %s, %s)"""
        cursor.execute(sql, (nombres, apellidos, documento_identidad, telefono, formacion, evaliuacion_periodica))
        conn.commit()
        return cursor.lastrowid
    finally:
        cursor.close()
        conn.close()

def read_personal(limit=100):
    conn = get_connection()
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""SELECT empleado_id, nombres, apellidos, documento_identidad, telefono, formacion, evaluacion_periodica
                          FROM personal_seguridad
                          ORDER BY empleado_id DESC
                          LIMIT %s""", (limit,))
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()

def update_personal(personal_id, **fields):
    if not fields:
        return False
    allowed = ['nombres', 'apellidos', 'documento_identidad', 'telefono', 'formacion', 'evaluacion_periodica']
    set_clauses = []
    params = []
    for k, v in fields.items():
        if k in allowed:
            set_clauses.append(f"{k}=%s")
            params.append(v)
    params.append(personal_id)
    sql = f"UPDATE personal_seguridad SET {', '.join(set_clauses)} WHERE empleado_id=%s"
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute(sql, tuple(params))
        conn.commit()
        return cursor.rowcount
    finally:
        cursor.close()
        conn.close()

def delete_personal(personal_id):
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM personal_seguridad WHERE empleado_id=%s", (personal_id,))
        conn.commit()
        return cursor.rowcount
    finally:
        cursor.close()
        conn.close()
