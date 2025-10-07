from models.clientes_model import create_cliente, read_clientes, update_cliente, delete_cliente

def create_client(data):
    # basic validation
    if not data.get('documento_fiscal'):
        raise ValueError('Documento fiscal requerido')
    return create_cliente(data.get('tipo'), data.get('razon_social'), data.get('documento_fiscal'), data.get('direccion'), data.get('telefono'), data.get('contacto_emergencia'), data.get('nivel_riesgo'))

def read_clients(limit=200):
    return read_clientes(limit)

def update_client(cliente_id, **fields):
    return update_cliente(cliente_id, **fields)

def delete_client(cliente_id):
    return delete_cliente(cliente_id)
