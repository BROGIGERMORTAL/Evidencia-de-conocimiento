import tkinter as tk
from tkinter import ttk, messagebox

class SecureSysApp:
    def __init__(self, root):
        self.root = root
        self.root.title("SecureSys - Sistema de Seguridad")
        self.root.geometry("900x600")

        # ==== MENÚ PRINCIPAL ====
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)

        # Menús de los módulos
        modulo_clientes = tk.Menu(menubar, tearoff=0)
        modulo_vigilancia = tk.Menu(menubar, tearoff=0)
        modulo_dispositivos = tk.Menu(menubar, tearoff=0)
        modulo_incidentes = tk.Menu(menubar, tearoff=0)

        menubar.add_cascade(label="Clientes/Instalaciones", menu=modulo_clientes)
        menubar.add_cascade(label="Operaciones Vigilancia", menu=modulo_vigilancia)
        menubar.add_cascade(label="Dispositivos", menu=modulo_dispositivos)
        menubar.add_cascade(label="Incidentes/Reportes", menu=modulo_incidentes)

        # Opciones dentro de cada módulo
        modulo_clientes.add_command(label="Gestionar Clientes", command=lambda: self.show_message("Clientes"))
        modulo_clientes.add_command(label="Gestionar Instalaciones", command=lambda: self.show_message("Instalaciones"))

        modulo_vigilancia.add_command(label="Asignar Turnos", command=lambda: self.show_message("Turnos"))
        modulo_vigilancia.add_command(label="Programar Rondas", command=lambda: self.show_message("Rondas"))

        modulo_dispositivos.add_command(label="Configurar Dispositivos", command=lambda: self.show_message("Dispositivos"))

        modulo_incidentes.add_command(label="Registrar Incidente", command=lambda: self.show_message("Incidentes"))
        modulo_incidentes.add_command(label="Generar Reporte", command=lambda: self.show_message("Reportes"))

        # ==== PANELES PRINCIPALES ====
        self.sidebar = tk.Frame(self.root, bg="#2c3e50", width=200)
        self.sidebar.pack(fill="y", side="left")

        self.content = tk.Frame(self.root, bg="#ecf0f1")
        self.content.pack(fill="both", expand=True, side="right")

        # ==== BOTONES CRUD ====
        tk.Label(self.sidebar, text="Operaciones CRUD", bg="#2c3e50", fg="white", font=("Arial", 12, "bold")).pack(pady=10)

        btn_crear = tk.Button(self.sidebar, text="➕ Crear", width=20, command=lambda: self.show_message("Crear"))
        btn_leer = tk.Button(self.sidebar, text="📖 Leer", width=20, command=lambda: self.show_message("Leer"))
        btn_actualizar = tk.Button(self.sidebar, text="✏️ Actualizar", width=20, command=lambda: self.show_message("Actualizar"))
        btn_eliminar = tk.Button(self.sidebar, text="❌ Eliminar", width=20, command=lambda: self.show_message("Eliminar"))

        btn_crear.pack(pady=5)
        btn_leer.pack(pady=5)
        btn_actualizar.pack(pady=5)
        btn_eliminar.pack(pady=5)

        # ==== OTRAS OPCIONES ====
        tk.Label(self.sidebar, text="Otras opciones", bg="#2c3e50", fg="white", font=("Arial", 12, "bold")).pack(pady=20)

        btn_reportes = tk.Button(self.sidebar, text="📊 Reportes", width=20, command=lambda: self.show_message("Reportes"))
        btn_config = tk.Button(self.sidebar, text="⚙️ Configuración", width=20, command=lambda: self.show_message("Configuración"))

        btn_reportes.pack(pady=5)
        btn_config.pack(pady=5)

        # ==== ÁREA CENTRAL ====
        self.text_area = tk.Label(self.content, text="Bienvenido a SecureSys", bg="#ecf0f1", font=("Arial", 16))
        self.text_area.pack(expand=True)

    def show_message(self, opcion):
        messagebox.showinfo("Opción seleccionada", f"Has seleccionado: {opcion}")
        self.text_area.config(text=f"Vista actual: {opcion}")

# ==== EJECUCIÓN ====
if __name__ == "__main__":
    root = tk.Tk()
    app = SecureSysApp(root)
    root.mainloop()
