import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import openpyxl
from datetime import datetime
from reportlab.lib.pagesizes import A4, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from controllers.instalaciones_controller import create_install, read_install, update_install, delete_install

class InstalacionesView(tk.Frame):
    def __init__(self, parent):
        super().__init__(parent, bg='#ecf0f1')
        self.pack(fill='both', expand=True)
        ttk.Label(self, text='Gestión de Instalaciones', font=('Arial', 16, 'bold')).pack(pady=10)
        form = ttk.LabelFrame(self, text='Crear / Actualizar Instalación')
        form.pack(fill='x', padx=10, pady=10)
        entries = {}
        fields = [('cliente_id', 'Cliente ID'), ('tipo', 'Tipo'), ('direccion', 'Dirección'), ('coordenadas', 'Coordenadas'), ('nivel_seguridad', 'Nivel Seguridad')]
        for i, (k, label) in enumerate(fields):
            ttk.Label(form, text=label).grid(row=i, column=0, sticky='w', padx=5, pady=3)
            ent = ttk.Entry(form, width=50)
            ent.grid(row=i, column=1, padx=5, pady=3)
            entries[k] = ent
        btn_frame = tk.Frame(form); btn_frame.grid(row=len(fields), column=0, columnspan=2, pady=8)
        ttk.Button(btn_frame, text='Crear Instalación', command=lambda: self.create_instalacion(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Actualizar Instalación', command=lambda: self.update_instalacion(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Eliminar Instalación', command=self.delete_instalacion).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Refrescar Lista', command=self.load_instalaciones).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar Excel', command=self.export_instalaciones_excel).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar PDF', command=self.export_instalaciones_pdf).pack(side='left', padx=5)
        table_frame = ttk.LabelFrame(self, text='Instalaciones - Lista'); table_frame.pack(fill='both', expand=True, padx=10, pady=10)
        cols = ('instalacion_id','cliente_id','tipo','direccion','coordenadas','nivel_seguridad')
        self.tree = ttk.Treeview(table_frame, columns=cols, show='headings')
        for c in cols: self.tree.heading(c, text=c); self.tree.column(c, width=120)
        self.tree.pack(fill='both', expand=True)
        self.tree.bind('<<TreeviewSelect>>', lambda e: self.on_select(e, entries))
        self.selected_id = None
        self.load_instalaciones()

    def create_instalacion(self, entries):
        try:
            data = {k: entries[k].get().strip() for k in entries}
            nid = create_install(data)
            messagebox.showinfo('Éxito', f'Instalación creada con ID {nid}'); self.load_instalaciones()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo crear instalación: {e}')

    def load_instalaciones(self):
        try:
            rows = read_install(200); self.tree.delete(*self.tree.get_children())
            for r in rows: self.tree.insert('', 'end', values=(r['instalacion_id'], r['cliente_id'], r['tipo'], r['direccion'], r.get('coordenadas',''), r.get('nivel_seguridad','')))
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo cargar instalaciones: {e}')

    def on_select(self, event, entries):
        try:
            sel = self.tree.selection(); 
            if not sel: return
            vals = self.tree.item(sel[0], 'values')
            entries['cliente_id'].delete(0,'end'); entries['cliente_id'].insert(0, vals[1])
            entries['tipo'].delete(0,'end'); entries['tipo'].insert(0, vals[2])
            entries['direccion'].delete(0,'end'); entries['direccion'].insert(0, vals[3])
            entries['coordenadas'].delete(0,'end'); entries['coordenadas'].insert(0, vals[4])
            entries['nivel_seguridad'].delete(0,'end'); entries['nivel_seguridad'].insert(0, vals[5])
            self.selected_id = vals[0]
        except Exception as e:
            print('on_select', e)

    def update_instalacion(self, entries):
        try:
            if not self.selected_id: messagebox.showwarning('Seleccionar','Seleccione primero una instalación.'); return
            data = {k: entries[k].get().strip() for k in entries}
            cnt = update_install(self.selected_id, **data)
            messagebox.showinfo('Éxito', f'{cnt} registro(s) actualizados.'); self.load_instalaciones()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo actualizar: {e}')

    def delete_instalacion(self):
        try:
            if not self.selected_id: messagebox.showwarning('Seleccionar','Seleccione primero una instalación.'); return
            if messagebox.askyesno('Confirmar','¿Eliminar instalación seleccionada?'):
                cnt = delete_install(self.selected_id); messagebox.showinfo('Éxito', f'{cnt} registro(s) eliminados.'); self.load_instalaciones()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo eliminar: {e}')

    def export_instalaciones_excel(self):
        try:
            rows = read_install(1000)
            if not rows: messagebox.showwarning('Atención','No hay datos para exportar.'); return
            filepath = filedialog.asksaveasfilename(defaultextension='.xlsx', filetypes=[('Excel','*.xlsx')], initialfile='instalaciones.xlsx')
            if not filepath: return
            wb = openpyxl.Workbook(); ws = wb.active; ws.title='Instalaciones'; ws.append(list(rows[0].keys()))
            for r in rows: ws.append(list(r.values()))
            wb.save(filepath); messagebox.showinfo('Éxito', f'Exportado a {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar: {e}')

    def export_instalaciones_pdf(self):
        try:
            rows = read_install(1000); 
            if not rows: messagebox.showwarning('Atención','No hay datos para exportar.'); return
            filepath = filedialog.asksaveasfilename(defaultextension='.pdf', filetypes=[('PDF','*.pdf')], initialfile='instalaciones.pdf')
            if not filepath: return
            doc = SimpleDocTemplate(filepath, pagesize=landscape(A4), leftMargin=20, rightMargin=20, topMargin=30, bottomMargin=20)
            styles = getSampleStyleSheet(); elements=[]; elements.append(Paragraph('Reporte: Instalaciones', styles['Heading2'])); elements.append(Paragraph(f'Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}', styles['Normal'])); elements.append(Spacer(1,12))
            headers = list(rows[0].keys()); data=[headers]
            for r in rows: data.append([str(r.get(h,'')) for h in headers])
            table = Table(data, repeatRows=1); table.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0), colors.HexColor('#1b4f72')), ('TEXTCOLOR',(0,0),(-1,0), colors.white), ('FONTNAME',(0,0),(-1,0),'Helvetica-Bold'), ('ALIGN',(0,0),(-1,-1),'LEFT'), ('GRID',(0,0),(-1,-1),0.25, colors.grey), ('ROWBACKGROUNDS',(0,1),(-1,-1), [colors.whitesmoke, colors.lightgrey])]))
            elements.append(table); doc.build(elements); messagebox.showinfo('Éxito', f'PDF exportado: {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar PDF: {e}')
