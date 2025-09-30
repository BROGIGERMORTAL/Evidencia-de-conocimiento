# SecureSys - Sistema de Gestión de Seguridad Integral

## 📌 Descripción
Interfaz gráfica completa para un sistema de gestión de seguridad integral (SecureSys) que permite administrar clientes, instalaciones, personal de seguridad e incidentes. Esta versión incluye la interfaz gráfica totalmente funcional con conexión a base de datos MySQL.

## ✨ Características

### Módulos Principales
- **Clientes:** Gestión completa de clientes con CRUD  
- **Instalaciones:** Administración de instalaciones de seguridad  
- **Personal de Seguridad:** Registro y control de personal  
- **Incidentes:** Reporte y seguimiento de incidentes de seguridad  

### Funcionalidades CRUD
- ➕ **Crear:** Registro de nuevos elementos  
- 📖 **Leer:** Visualización de datos en tablas  
- ✏️ **Actualizar:** Modificación de registros existentes  
- ❌ **Eliminar:** Borrado seguro de registros  

### Interfaz de Usuario
- Barra lateral con accesos rápidos a todos los módulos  
- Menú superior organizado en 4 categorías principales  
- Área central dinámica que cambia según la selección  
- Diseño consistente en todos los módulos  
- Mensajes de error y confirmación para mejor experiencia  

## 🗄️ Estructura de la Base de Datos
**Tablas principales:**
- `clientes`: Información de clientes  
- `instalaciones`: Detalles de instalaciones de seguridad  
- `personal_seguridad`: Registro de personal de seguridad  
- `incidentes`: Reportes de incidentes de seguridad  

## ⚙️ Arquitectura del Proyecto
SecureSys/
├── main.py # Archivo principal de la aplicación
├── backend/
│ ├── db.py # Conexión y configuración de base de datos
│ ├── clients_dao.py # Acceso a datos de clientes
│ ├── installations_dao.py # Acceso a datos de instalaciones
│ ├── personal_dao.py # Acceso a datos de personal
│ └── incidents_dao.py # Acceso a datos de incidentes
└── requirements.txt # Dependencias del proyecto

## 🛠️ Requisitos Previos
- Python 3.6 o superior  
- pip (gestor de paquetes de Python)  
- Servidor MySQL/MariaDB  
- Variables de entorno configuradas para la conexión a base de datos  

## 📦 Dependencias
- `tkinter` (interfaz gráfica - incluido en Python)  
- `mysql-connector-python` (conexión a MySQL)  
- `openxlx`(Exportar exels)
- `python-dotenv` (opcional, para variables de entorno)  

## 📥 Instalación
1. Clona o descarga el proyecto en tu equipo  
2. Abre una terminal en la carpeta del proyecto  
3. Instala las dependencias



