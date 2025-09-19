SecureSys - Sistema de Gestión de Seguridad Integral
📌 Descripción
Interfaz gráfica completa para un sistema de gestión de seguridad integral (SecureSys) que permite administrar clientes, instalaciones, personal de seguridad, e incidentes. Esta versión incluye la interfaz gráfica totalmente funcional con conexión a base de datos MySQL.

✨ Características
Módulos Principales:
Clientes: Gestión completa de clientes con CRUD
Instalaciones: Administración de instalaciones de seguridad
Personal de Seguridad: Registro y control de personal
Incidentes: Reporte y seguimiento de incidentes de seguridad
Funcionalidades CRUD:
➕ Crear: Registro de nuevos elementos
📖 Leer: Visualización de datos en tablas
✏️ Actualizar: Modificación de registros existentes
❌ Eliminar: Borrado seguro de registros
Interfaz de Usuario:
Barra lateral con accesos rápidos a todos los módulos
Menú superior organizado en 4 categorías principales
Área central dinámica que cambia según la selección
Diseño consistente en todos los módulos
Mensajes de error y confirmación para mejor experiencia
🗄️ Estructura de la Base de Datos
Tablas principales:
clientes: Información de clientes
instalaciones: Detalles de instalaciones de seguridad
personal_seguridad: Registro de personal de seguridad
incidentes: Reportes de incidentes de seguridad
⚙️ Arquitectura del Proyecto
SecureSys/
├── main.py                 # Archivo principal de la aplicación
├── backend/
│   ├── db.py              # Conexión y configuración de base de datos
│   ├── clients_dao.py     # Acceso a datos de clientes
│   ├── installations_dao.py # Acceso a datos de instalaciones
│   ├── personal_dao.py    # Acceso a datos de personal
│   └── incidents_dao.py   # Acceso a datos de incidentes
└── requirements.txt       # Dependencias del proyecto
🛠️ Requisitos Previos
Python 3.6 o superior
pip (gestor de paquetes de Python)
Servidor MySQL/MariaDB
Variables de entorno configuradas para la conexión a base de datos
📦 Dependencias
tkinter (interfaz gráfica - incluido en Python)
mysql-connector-python (conexión a MySQL)
python-dotenv (opcional, para variables de entorno)
📥 Instalación
Clona o descarga el proyecto en tu equipo
Abre una terminal en la carpeta del proyecto
Instala las dependencias:
bash


1
pip install -r requirements.txt
Configura las variables de entorno para la conexión a la base de datos:
bash


1
2
3
4
5
6
# Archivo .env
DB_HOST=localhost
DB_USER=tu_usuario
DB_PASSWORD=tu_contraseña
DB_NAME=securesys
DB_PORT=3306
Ejecuta el archivo principal:
bash


1
python main.py
🎯 Uso
Inicia la aplicación ejecutando python main.py
Utiliza la barra lateral o el menú superior para navegar entre módulos
En cada módulo, completa los formularios y utiliza los botones CRUD
Los datos se cargan automáticamente al abrir cada módulo
Selecciona un registro de la tabla para editarlo o eliminarlo
🔧 Funcionalidades Implementadas
✅ Conexión a base de datos MySQL
✅ Operaciones CRUD completas para todos los módulos
✅ Validaciones de datos en formularios
✅ Manejo de errores y mensajes al usuario
✅ Interfaz gráfica consistente y responsive
✅ Selección y edición de registros desde tablas
⚠️ Notas Importantes
Asegúrate de tener el servidor MySQL ejecutándose antes de iniciar la aplicación
Las tablas de la base de datos deben estar creadas previamente
Los permisos de usuario de base de datos deben incluir SELECT, INSERT, UPDATE y DELETE
Algunos campos requieren formatos específicos (fechas, números, etc.)
📊 Módulos Detallados
Clientes
Registro de clientes con tipo, razón social y datos fiscales
Información de contacto y nivel de riesgo
Historial de servicios
Instalaciones
Vinculación con clientes
Direcciones y coordenadas GPS
Niveles de seguridad personalizados
Personal de Seguridad
Datos personales completos
Especializaciones y certificaciones
Licencias y formación
Incidentes
Registro de eventos de seguridad
Tiempos de respuesta y resolución
Personal involucrado y zonas afectadas
🔐 Seguridad
Conexión segura a base de datos mediante pool de conexiones
Manejo de excepciones para prevenir fallos
Validación de datos antes de operaciones críticas
🚀 Próximas Mejoras
Implementación de autenticación de usuarios
Generación de reportes y estadísticas
Exportación de datos a formatos PDF/Excel
Sistema de notificaciones y alertas
Dashboard con métricas de seguridad
📞 Soporte
Para problemas técnicos o consultas, revisa los mensajes de error en la consola o contacta al equipo de desarrollo.

