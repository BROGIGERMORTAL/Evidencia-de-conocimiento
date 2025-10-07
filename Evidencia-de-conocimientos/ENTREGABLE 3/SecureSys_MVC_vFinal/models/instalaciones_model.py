from models.db import get_connection

def create_instalacion(cliente_id, tipo, direccion, coordenadas, nivel_seguridad):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""
        INSERT INTO instalaciones (cliente_id, tipo, direccion, coordenadas, nivel_seguridad)
        VALUES (%s, %s, %s, %s, %s)
    """, (cliente_id, tipo, direccion, coordenadas, nivel_seguridad))
    conn.commit()
    new_id = cur.lastrowid
    cur.close()
    conn.close()
    return new_id

def read_instalaciones(limit=200):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    cur.execute("""
        SELECT instalacion_id, cliente_id, tipo, direccion, coordenadas, nivel_seguridad
        FROM instalaciones
        ORDER BY instalacion_id DESC
        LIMIT %s
    """, (limit,))
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows

def update_instalacion(instalacion_id, **kwargs):
    if not kwargs:
        return 0
    fields = ", ".join([f"{k}=%s" for k in kwargs])
    values = list(kwargs.values())
    values.append(instalacion_id)

    conn = get_connection()
    cur = conn.cursor()
    cur.execute(f"""
        UPDATE instalaciones
        SET {fields}
        WHERE instalacion_id=%s
    """, values)
    conn.commit()
    cnt = cur.rowcount
    cur.close()
    conn.close()
    return cnt

def delete_instalacion(instalacion_id):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM instalaciones WHERE instalacion_id=%s", (instalacion_id,))
    conn.commit()
    cnt = cur.rowcount
    cur.close()
    conn.close()
    return cnt
