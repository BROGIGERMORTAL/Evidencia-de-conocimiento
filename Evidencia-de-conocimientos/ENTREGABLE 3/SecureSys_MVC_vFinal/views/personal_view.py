import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import openpyxl
from datetime import datetime
from reportlab.lib.pagesizes import A4, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from controllers.personal_controller import create_staff, read_staff, update_staff, delete_staff

class PersonalView(tk.Frame):
    def __init__(self, parent):
        super().__init__(parent, bg='#ecf0f1')
        self.pack(fill='both', expand=True)
        ttk.Label(self, text='Gestión de Personal', font=('Arial', 16, 'bold')).pack(pady=10)
        form = ttk.LabelFrame(self, text='Registrar Personal Seguridad'); form.pack(fill='x', padx=10, pady=10)
        entries = {}
        fields = [('nombres', 'Nombres'), ('apellidos', 'Apellidos'), ('documento_identidad', 'Documento Identidad'), ('telefono', 'Teléfono'), ('formacion', 'Formación'), ('evaluacion_periodica', 'Evaluación Periódica')]
        for i, (k, label) in enumerate(fields):
            ttk.Label(form, text=label).grid(row=i, column=0, sticky='w', padx=5, pady=3)
            ent = ttk.Entry(form, width=50); ent.grid(row=i, column=1, padx=5, pady=3); entries[k] = ent
        btn_frame = tk.Frame(form); btn_frame.grid(row=len(fields), column=0, columnspan=2, pady=8)
        ttk.Button(btn_frame, text='Crear Personal', command=lambda: self.create_personal(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Actualizar Personal', command=lambda: self.update_personal(entries)).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Eliminar Personal', command=self.delete_personal).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Refrescar Lista', command=self.load_personal).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar Excel', command=self.export_personal_excel).pack(side='left', padx=5)
        ttk.Button(btn_frame, text='Exportar PDF', command=self.export_personal_pdf).pack(side='left', padx=5)
        table_frame = ttk.LabelFrame(self, text='Personal Seguridad - Lista'); table_frame.pack(fill='both', expand=True, padx=10, pady=10)
        cols = ('empleado_id','nombres','apellidos','documento_identidad','telefono','formacion','evaluacion_periodica')
        self.tree = ttk.Treeview(table_frame, columns=cols, show='headings')
        for c in cols: self.tree.heading(c, text=c); self.tree.column(c, width=120)
        self.tree.pack(fill='both', expand=True); self.tree.bind('<<TreeviewSelect>>', lambda e: self.on_select(e, entries))
        self.selected_id = None; self.load_personal()

    def create_personal(self, entries):
        try:
            data = {k: entries[k].get().strip() for k in entries}
            nid = create_staff(data); messagebox.showinfo('Éxito', f'Personal creado con ID {nid}'); self.load_personal()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo crear personal: {e}')

    def load_personal(self):
        try:
            rows = read_staff(200); self.tree.delete(*self.tree.get_children())
            for r in rows: self.tree.insert('', 'end', values=(r['empleado_id'], r['nombres'], r['apellidos'], r['documento_identidad'], r.get('telefono',''), r.get('formacion',''), r.get('evaluacion_periodica','')))
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo cargar personal: {e}')

    def on_select(self, event, entries):
        try:
            sel = self.tree.selection(); 
            if not sel: return
            vals = self.tree.item(sel[0], 'values')
            entries['nombres'].delete(0,'end'); entries['nombres'].insert(0, vals[1])
            entries['apellidos'].delete(0,'end'); entries['apellidos'].insert(0, vals[2])
            entries['documento_identidad'].delete(0,'end'); entries['documento_identidad'].insert(0, vals[3])
            entries['telefono'].delete(0,'end'); entries['telefono'].insert(0, vals[4])
            entries['formacion'].delete(0,'end'); entries['formacion'].insert(0, vals[5])
            entries['evaluacion_periodica'].delete(0,'end'); entries['evaluacion_periodica'].insert(0, vals[6])
            self.selected_id = vals[0]
        except Exception as e:
            print('on_select', e)

    def update_personal(self, entries):
        try:
            if not self.selected_id: messagebox.showwarning('Seleccionar','Seleccione primero un personal.'); return
            data = {k: entries[k].get().strip() for k in entries}
            cnt = update_staff(self.selected_id, **data); messagebox.showinfo('Éxito', f'{cnt} registro(s) actualizados.'); self.load_personal()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo actualizar: {e}')

    def delete_personal(self):
        try:
            if not self.selected_id: messagebox.showwarning('Seleccionar','Seleccione primero un personal.'); return
            if messagebox.askyesno('Confirmar','¿Eliminar personal seleccionado?'):
                cnt = delete_staff(self.selected_id); messagebox.showinfo('Éxito', f'{cnt} registro(s) eliminados.'); self.load_personal()
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo eliminar: {e}')

    def export_personal_excel(self):
        try:
            rows = read_staff(1000)
            if not rows: messagebox.showwarning('Atención','No hay datos para exportar.'); return
            filepath = filedialog.asksaveasfilename(defaultextension='.xlsx', filetypes=[('Excel','*.xlsx')], initialfile='personal.xlsx')
            if not filepath: return
            wb = openpyxl.Workbook(); ws = wb.active; ws.title='Personal'; ws.append(list(rows[0].keys()))
            for r in rows: ws.append(list(r.values())); wb.save(filepath); messagebox.showinfo('Éxito', f'Exportado a {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar: {e}')

    def export_personal_pdf(self):
        try:
            rows = read_staff(1000); 
            if not rows: messagebox.showwarning('Atención','No hay datos para exportar.'); return
            filepath = filedialog.asksaveasfilename(defaultextension='.pdf', filetypes=[('PDF','*.pdf')], initialfile='personal.pdf')
            if not filepath: return
            doc = SimpleDocTemplate(filepath, pagesize=landscape(A4), leftMargin=20, rightMargin=20, topMargin=30, bottomMargin=20)
            styles = getSampleStyleSheet(); elements=[]; elements.append(Paragraph('Reporte: Personal de Seguridad', styles['Heading2'])); elements.append(Paragraph(f'Generado: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}', styles['Normal'])); elements.append(Spacer(1,12))
            headers = list(rows[0].keys()); data=[headers]
            for r in rows: data.append([str(r.get(h,'')) for h in headers])
            table = Table(data, repeatRows=1); table.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0), colors.HexColor('#117864')), ('TEXTCOLOR',(0,0),(-1,0), colors.white), ('FONTNAME',(0,0),(-1,0),'Helvetica-Bold'), ('ALIGN',(0,0),(-1,-1),'LEFT'), ('GRID',(0,0),(-1,-1),0.25, colors.grey), ('ROWBACKGROUNDS',(0,1),(-1,-1), [colors.white, colors.whitesmoke])]))
            elements.append(table); doc.build(elements); messagebox.showinfo('Éxito', f'PDF exportado: {filepath}')
        except Exception as e:
            messagebox.showerror('Error', f'No se pudo exportar PDF: {e}')
