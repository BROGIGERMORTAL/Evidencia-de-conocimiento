from models.instalaciones_model import create_instalacion, read_instalaciones, update_instalacion, delete_instalacion

def create_install(data):
    if not data.get('cliente_id'):
        raise ValueError('cliente_id requerido')
    return create_instalacion(data.get('cliente_id'), data.get('tipo'), data.get('direccion'), data.get('coordenadas'), data.get('nivel_seguridad'))

def read_install(limit=200):
    return read_instalaciones(limit)

def update_install(instalacion_id, **fields):
    return update_instalacion(instalacion_id, **fields)

def delete_install(instalacion_id):
    return delete_instalacion(instalacion_id)
