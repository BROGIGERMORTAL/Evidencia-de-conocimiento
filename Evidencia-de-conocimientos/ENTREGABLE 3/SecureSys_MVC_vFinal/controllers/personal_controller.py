from models.personal_model import create_personal, read_personal, update_personal, delete_personal

def create_staff(data):
    if not data.get('documento_identidad'):
        raise ValueError('documento_identidad requerido')
    return create_personal(data.get('nombres'), data.get('apellidos'), data.get('documento_identidad'), data.get('telefono'), data.get('formacion'), data.get('evaluacion_periodica'))

def read_staff(limit=200):
    return read_personal(limit)

def update_staff(personal_id, **fields):
    return update_personal(personal_id, **fields)

def delete_staff(personal_id):
    return delete_personal(personal_id)
