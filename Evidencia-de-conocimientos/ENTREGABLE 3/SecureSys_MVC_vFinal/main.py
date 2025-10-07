import tkinter as tk
from tkinter import ttk
from views.clientes_view import ClientesView
from views.instalaciones_view import InstalacionesView
from views.personal_view import PersonalView
from views.incidentes_view import IncidentesView

class SecureSysApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title('SecureSys - Sistema de Gestión de Seguridad')
        self.geometry('1000x650')
        self.configure(bg='#ecf0f1')

        menubar = tk.Menu(self)
        self.config(menu=menubar)
        mod_clientes = tk.Menu(menubar, tearoff=0)
        mod_incidentes = tk.Menu(menubar, tearoff=0)
        mod_instalaciones = tk.Menu(menubar, tearoff=0)
        mod_personal = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label='Clientes', menu=mod_clientes)
        menubar.add_cascade(label='Incidentes', menu=mod_incidentes)
        menubar.add_cascade(label='Instalaciones', menu=mod_instalaciones)
        menubar.add_cascade(label='Personal Seguridad', menu=mod_personal)
        mod_clientes.add_command(label='Administrar Clientes', command=self.show_clientes_view)
        mod_incidentes.add_command(label='Administrar Incidentes', command=self.show_incidentes_view)
        mod_instalaciones.add_command(label='Administrar Instalaciones', command=self.show_instalaciones_view)
        mod_personal.add_command(label='Administrar Personal', command=self.show_personal_view)

        # sidebar
        self.sidebar = tk.Frame(self, bg='#2c3e50', width=220)
        self.sidebar.pack(fill='y', side='left')
        lbl = tk.Label(self.sidebar, text='Operaciones', bg='#2c3e50', fg='white', font=('Arial',12,'bold'))
        lbl.pack(pady=10)
        ttk.Button(self.sidebar, text='Clientes', width=20, command=self.show_clientes_view).pack(pady=5)
        ttk.Button(self.sidebar, text='Incidentes', width=20, command=self.show_incidentes_view).pack(pady=5)
        ttk.Button(self.sidebar, text='Instalaciones', width=20, command=self.show_instalaciones_view).pack(pady=5)
        ttk.Button(self.sidebar, text='Personal', width=20, command=self.show_personal_view).pack(pady=5)

        self.content = tk.Frame(self, bg='#ecf0f1'); self.content.pack(fill='both', expand=True, side='right')
        self.show_welcome()

    def clear_content(self):
        for widget in self.content.winfo_children(): widget.destroy()

    def show_welcome(self):
        self.clear_content(); tk.Label(self.content, text='Bienvenido a SecureSys', font=('Arial',18,'bold'), bg='#ecf0f1').pack(pady=30)
        tk.Label(self.content, text='Selecciona un módulo desde el menú o la barra lateral.', font=('Arial',12), bg='#ecf0f1').pack(pady=10)

    def show_clientes_view(self):
        self.clear_content(); ClientesView(self.content)
    def show_incidentes_view(self):
        self.clear_content(); IncidentesView(self.content)
    def show_instalaciones_view(self):
        self.clear_content(); InstalacionesView(self.content)
    def show_personal_view(self):
        self.clear_content(); PersonalView(self.content)

if __name__ == '__main__':
    app = SecureSysApp(); app.mainloop()
