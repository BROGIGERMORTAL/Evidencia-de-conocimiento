from models.db import get_connection

def create_cliente(tipo, razon_social, documento_fiscal, direccion, telefono, contacto_emergencia, nivel_riesgo):
    conn = get_connection()
    try:
        cursor = conn.cursor()
        sql = """INSERT INTO clientes (tipo, razon_social, documento_fiscal, direccion, telefono, contacto_emergencia, nivel_riesgo, fecha_inicio, contrato_vigente)
                 VALUES (%s,%s,%s,%s,%s,%s,%s,CURDATE(),1)"""
        cursor.execute(sql, (tipo, razon_social, documento_fiscal, direccion, telefono, contacto_emergencia, nivel_riesgo))
        conn.commit()
        return cursor.lastrowid
    finally:
        cursor.close()
        conn.close()

def read_clientes(limit=100):
    conn = get_connection()
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT cliente_id,tipo,razon_social,documento_fiscal,direccion,telefono,contacto_emergencia,nivel_riesgo,fecha_inicio,contrato_vigente FROM clientes ORDER BY cliente_id DESC LIMIT %s", (limit,))
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()

def update_cliente(cliente_id, **fields):
    if not fields:
        return False
    allowed = ['tipo','razon_social','documento_fiscal','direccion','telefono','contacto_emergencia','nivel_riesgo','contrato_vigente']
    set_clauses = []
    params = []
    for k,v in fields.items():
        if k in allowed:
            set_clauses.append(f"{k}=%s")
            params.append(v)
    params.append(cliente_id)
    sql = f"UPDATE clientes SET {', '.join(set_clauses)} WHERE cliente_id=%s"
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute(sql, tuple(params))
        conn.commit()
        return cursor.rowcount
    finally:
        cursor.close()
        conn.close()

def delete_cliente(cliente_id):
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM clientes WHERE cliente_id=%s", (cliente_id,))
        conn.commit()
        return cursor.rowcount
    finally:
        cursor.close()
        conn.close()
