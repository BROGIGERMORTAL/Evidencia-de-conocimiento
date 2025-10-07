import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import openpyxl
from datetime import datetime
from reportlab.lib.pagesizes import A4, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from controllers.incidentes_controller import create_inc, read_inc, update_inc, delete_inc

class IncidentesView(tk.Frame):
    def __init__(self, parent):
        super().__init__(parent, bg='#ecf0f1')
        self.pack(fill='both', expand=True)
        ttk.Label(self, text='Gestión de Incidentes', font=('Arial', 16, 'bold')).pack(pady=10)
        form = ttk.LabelFrame(self, text='Registrar Incidente'); form.pack(fill='x', padx=10, pady=10)
        entries = {}
        fields = [('instalacion_id','Instalación ID'),('fecha_hora','Fecha y Hora (YYYY-MM-DD HH:MM:SS)'),('zona','Zona'),('tipo','Tipo'),('descripcion','Descripción'),('personal_involucrado','Personal Involucrado'),('respuesta_implementada','Respuesta Implementada'),('tiempo_reaccion','Tiempo Reacción (segundos)')]
        for i,(k,label) in enumerate(fields):
            ttk.Label(form, text=label).grid(row=i, column=0, sticky='w', padx=5, pady=3)
            ent = ttk.Entry(form, width=60); ent.grid(row=i, column=1, padx=5, pady=3); entries[k]=ent
        btn_frame = tk.Frame(form); btn_frame.grid(row=len(fields), column=0, columnspan=2, pady=8)
        ttk.Button(btn_frame, text='Crear Incidente', command=lambda: self.create_incidente(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Actualizar Incidente', command=lambda: self.update_incidente(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Eliminar Incidente', command=self.delete_incidente).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Refrescar Lista', command=self.load_incidentes).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar Excel', command=self.export_incidentes_excel).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar PDF', command=self.export_incidentes_pdf).pack(side='left', padx=5)
        table_frame = ttk.LabelFrame(self, text='Incidentes - Lista'); table_frame.pack(fill='both', expand=True, padx=10, pady=10)
        cols = ('incidente_id','fecha_hora','instalacion_id','zona','tipo','tiempo_reaccion')
        self.tree = ttk.Treeview(table_frame, columns=cols, show='headings')
        for c in cols: self.tree.heading(c, text=c); self.tree.column(c, width=140)
        self.tree.pack(fill='both', expand=True); self.tree.bind('<<TreeviewSelect>>', lambda e: self.on_select(e, entries))
        self.selected_id = None; self.load_incidentes()

    def create_incidente(self, entries):
        try:
            data = {k: entries[k].get().strip() for k in entries}
            # validate date
            try:
                datetime.strptime(data['fecha_hora'],'%Y-%m-%d %H:%M:%S')
            except Exception:
                messagebox.showwarning('Validación','Formato de fecha inválido. Use YYYY-MM-DD HH:MM:SS'); return
            nid = create_inc(data); messagebox.showinfo('Éxito', f'Incidente creado con ID {nid}'); self.load_incidentes()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo crear incidente: {e}')

    def load_incidentes(self):
        try:
            rows = read_inc(200); self.tree.delete(*self.tree.get_children())
            for r in rows: self.tree.insert('', 'end', values=(r['incidente_id'], r['fecha_hora'], r['instalacion_id'], r.get('zona',''), r.get('tipo',''), r.get('tiempo_reaccion',0)))
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo cargar incidentes: {e}')

    def on_select(self, event, entries):
        try:
            sel = self.tree.selection(); 
            if not sel: return
            vals = self.tree.item(sel[0], 'values')
            entries['instalacion_id'].delete(0,'end'); entries['instalacion_id'].insert(0, vals[2])
            entries['fecha_hora'].delete(0,'end'); entries['fecha_hora'].insert(0, vals[1])
            entries['zona'].delete(0,'end'); entries['zona'].insert(0, vals[3])
            entries['tipo'].delete(0,'end'); entries['tipo'].insert(0, vals[4])
            entries['tiempo_reaccion'].delete(0,'end'); entries['tiempo_reaccion'].insert(0, vals[5])
            self.selected_id = vals[0]
        except Exception as e:
            print('on_select', e)

    def update_incidente(self, entries):
        try:
            if not self.selected_id: messagebox.showwarning('Seleccionar','Seleccione primero un incidente.'); return
            data = {k: entries[k].get().strip() for k in entries}
            cnt = update_inc(self.selected_id, **data); messagebox.showinfo('Éxito', f'{cnt} registro(s) actualizados.'); self.load_incidentes()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo actualizar: {e}')

    def delete_incidente(self):
        try:
            if not self.selected_id: messagebox.showwarning('Seleccionar','Seleccione primero un incidente.'); return
            if messagebox.askyesno('Confirmar','¿Eliminar incidente seleccionado?'):
                cnt = delete_inc(self.selected_id); messagebox.showinfo('Éxito', f'{cnt} registro(s) eliminados.'); self.load_incidentes()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo eliminar: {e}')

    def export_incidentes_excel(self):
        try:
            rows = read_inc(1000); 
            if not rows: messagebox.showwarning('Atención','No hay datos para exportar.'); return
            filepath = filedialog.asksaveasfilename(defaultextension='.xlsx', filetypes=[('Excel','*.xlsx')], initialfile='incidentes.xlsx')
            if not filepath: return
            wb = openpyxl.Workbook(); ws = wb.active; ws.title='Incidentes'; ws.append(list(rows[0].keys()))
            for r in rows: ws.append(list(r.values())); wb.save(filepath); messagebox.showinfo('Éxito', f'Exportado a {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar: {e}')

    def export_incidentes_pdf(self):
        try:
            rows = read_inc(1000); 
            if not rows: messagebox.showwarning('Atención','No hay datos para exportar.'); return
            filepath = filedialog.asksaveasfilename(defaultextension='.pdf', filetypes=[('PDF','*.pdf')], initialfile='incidentes.pdf')
            if not filepath: return
            doc = SimpleDocTemplate(filepath, pagesize=landscape(A4), leftMargin=20, rightMargin=20, topMargin=30, bottomMargin=20)
            styles = getSampleStyleSheet(); elements=[]; elements.append(Paragraph('Reporte: Incidentes', styles['Heading2'])); elements.append(Paragraph(f'Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}', styles['Normal'])); elements.append(Spacer(1,12))
            headers = list(rows[0].keys()); data=[headers]
            for r in rows: data.append([str(r.get(h,'')) for h in headers])
            table = Table(data, repeatRows=1); table.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0), colors.HexColor('#922b21')), ('TEXTCOLOR',(0,0),(-1,0), colors.white), ('FONTNAME',(0,0),(-1,0),'Helvetica-Bold'), ('ALIGN',(0,0),(-1,-1),'LEFT'), ('GRID',(0,0),(-1,-1),0.25, colors.grey), ('ROWBACKGROUNDS',(0,1),(-1,-1), [colors.white, colors.lightgrey])]))
            elements.append(table); doc.build(elements); messagebox.showinfo('Éxito', f'PDF exportado: {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar PDF: {e}')
