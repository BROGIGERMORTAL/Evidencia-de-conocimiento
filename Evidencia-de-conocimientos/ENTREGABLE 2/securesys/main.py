import tkinter as tk
from views.app_view import SecureSysApp

def main():
    app = SecureSysApp()  # 👈 sigue heredando de tk.Tk
    app.mainloop()

if __name__ == "__main__":
    main()
