from models.incidentes_model import create_incidente, read_incidentes, update_incidente, delete_incidente

def create_inc(data):
    # minimal validation
    if not data.get('instalacion_id') or not data.get('fecha_hora'):
        raise ValueError('instalacion_id y fecha_hora requeridos')
    return create_incidente(data.get('instalacion_id'), data.get('fecha_hora'), data.get('zona'), data.get('tipo'), data.get('descripcion'), data.get('personal_involucrado'), data.get('respuesta_implementada'), data.get('tiempo_reaccion'))

def read_inc(limit=200):
    return read_incidentes(limit)

def update_inc(incidente_id, **fields):
    return update_incidente(incidente_id, **fields)

def delete_inc(incidente_id):
    return delete_incidente(incidente_id)
