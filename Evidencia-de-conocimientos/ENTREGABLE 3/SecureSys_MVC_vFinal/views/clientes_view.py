import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from datetime import datetime
import openpyxl
from reportlab.lib.pagesizes import A4, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from controllers.clientes_controller import create_client, read_clients, update_client, delete_client

class ClientesView(tk.Frame):
    def __init__(self, parent):
        super().__init__(parent, bg='#ecf0f1')
        self.pack(fill='both', expand=True)
        header = tk.Label(self, text='Gestión de Clientes', font=('Arial', 16, 'bold'), bg='#ecf0f1')
        header.pack(pady=10)

        form = ttk.LabelFrame(self, text='Crear / Actualizar Cliente')
        form.pack(fill='x', padx=10, pady=10)
        entries = {}
        fields = [('tipo','Tipo'),('razon_social','Razón Social'),('documento_fiscal','Documento Fiscal'),('direccion','Dirección'),('telefono','Teléfono'),('contacto_emergencia','Contacto Emergencia'),('nivel_riesgo','Nivel Riesgo')]
        for i,(k,label) in enumerate(fields):
            ttk.Label(form, text=label).grid(row=i, column=0, sticky='w', padx=5, pady=3)
            ent = ttk.Entry(form, width=50)
            ent.grid(row=i, column=1, padx=5, pady=3)
            entries[k]=ent

        btn_frame = tk.Frame(form)
        btn_frame.grid(row=len(fields), column=0, columnspan=2, pady=8)
        ttk.Button(btn_frame, text='Crear Cliente', command=lambda: self.create_cliente(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Actualizar Cliente', command=lambda: self.update_cliente(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Eliminar Cliente', command=self.delete_cliente).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Refrescar Lista', command=self.load_clientes).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar Excel', command=self.export_clientes_excel).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar PDF', command=self.export_clientes_pdf).pack(side='left', padx=5)

        table_frame = ttk.LabelFrame(self, text='Clientes - Lista')
        table_frame.pack(fill='both', expand=True, padx=10, pady=10)
        cols = ('cliente_id','tipo','razon_social','documento_fiscal','telefono','nivel_riesgo','fecha_inicio')
        self.tree = ttk.Treeview(table_frame, columns=cols, show='headings')
        for c in cols:
            self.tree.heading(c, text=c)
            self.tree.column(c, width=120)
        self.tree.pack(fill='both', expand=True)
        self.tree.bind('<<TreeviewSelect>>', lambda e: self.on_select(e, entries))
        self.selected_id = None
        self.load_clientes()

    def create_cliente(self, entries):
        try:
            data = {k: entries[k].get().strip() for k in entries}
            nid = create_client(data)
            messagebox.showinfo('Éxito', f'Cliente creado con ID {nid}')
            self.load_clientes()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo crear cliente: {e}')

    def load_clientes(self):
        try:
            rows = read_clients(200)
            self.tree.delete(*self.tree.get_children())
            for r in rows:
                self.tree.insert('', 'end', values=(r['cliente_id'], r['tipo'], r['razon_social'], r['documento_fiscal'], r.get('telefono',''), r.get('nivel_riesgo',''), r.get('fecha_inicio','')))
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo cargar clientes: {e}')

    def on_select(self, event, entries):
        try:
            sel = self.tree.selection()
            if not sel: return
            vals = self.tree.item(sel[0], 'values')
            entries['tipo'].delete(0,'end'); entries['tipo'].insert(0, vals[1])
            entries['razon_social'].delete(0,'end'); entries['razon_social'].insert(0, vals[2])
            entries['documento_fiscal'].delete(0,'end'); entries['documento_fiscal'].insert(0, vals[3])
            entries['direccion'].delete(0,'end')
            entries['telefono'].delete(0,'end'); entries['telefono'].insert(0, vals[4])
            entries['contacto_emergencia'].delete(0,'end')
            entries['nivel_riesgo'].delete(0,'end'); entries['nivel_riesgo'].insert(0, vals[5])
            self.selected_id = vals[0]
        except Exception as e:
            print('on_select', e)

    def update_cliente(self, entries):
        try:
            if not self.selected_id:
                messagebox.showwarning('Seleccionar','Seleccione primero un cliente.')
                return
            data = {k: entries[k].get().strip() for k in entries}
            cnt = update_client(self.selected_id, **data)
            messagebox.showinfo('Éxito', f'{cnt} registro(s) actualizados.')
            self.load_clientes()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo actualizar: {e}')

    def delete_cliente(self):
        try:
            if not self.selected_id:
                messagebox.showwarning('Seleccionar','Seleccione primero un cliente.')
                return
            if messagebox.askyesno('Confirmar','¿Eliminar cliente seleccionado?'):
                cnt = delete_client(self.selected_id)
                messagebox.showinfo('Éxito', f'{cnt} registro(s) eliminados.')
                self.load_clientes()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo eliminar: {e}')

    def export_clientes_excel(self):
        try:
            rows = read_clients(1000)
            if not rows:
                messagebox.showwarning('Atención','No hay datos para exportar.')
                return
            filepath = filedialog.asksaveasfilename(defaultextension='.xlsx', filetypes=[('Excel','*.xlsx')], initialfile='clientes.xlsx')
            if not filepath: return
            wb = openpyxl.Workbook(); ws = wb.active; ws.title='Clientes'
            ws.append(list(rows[0].keys()))
            for r in rows: ws.append(list(r.values()))
            wb.save(filepath)
            messagebox.showinfo('Éxito', f'Exportado a {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar: {e}')

    def export_clientes_pdf(self):
        try:
            rows = read_clients(1000)
            if not rows:
                messagebox.showwarning('Atención','No hay datos para exportar.')
                return
            filepath = filedialog.asksaveasfilename(defaultextension='.pdf', filetypes=[('PDF','*.pdf')], initialfile='clientes.pdf')
            if not filepath: return
            doc = SimpleDocTemplate(filepath, pagesize=landscape(A4), leftMargin=20, rightMargin=20, topMargin=30, bottomMargin=20)
            styles = getSampleStyleSheet(); elements = []
            elements.append(Paragraph('Reporte: Clientes', styles['Heading2'])); elements.append(Paragraph(f'Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}', styles['Normal'])); elements.append(Spacer(1,12))
            headers = list(rows[0].keys()); data = [headers]
            for r in rows: data.append([str(r.get(h,'')) for h in headers])
            table = Table(data, repeatRows=1); table.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0), colors.HexColor('#2c3e50')), ('TEXTCOLOR',(0,0),(-1,0), colors.white), ('FONTNAME',(0,0),(-1,0),'Helvetica-Bold'), ('ALIGN',(0,0),(-1,-1),'LEFT'), ('GRID',(0,0),(-1,-1),0.25, colors.grey), ('ROWBACKGROUNDS',(0,1),(-1,-1), [colors.whitesmoke, colors.lightgrey])]))
            elements.append(table); doc.build(elements)
            messagebox.showinfo('Éxito', f'PDF exportado: {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar: {e}')
