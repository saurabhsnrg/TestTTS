python -m venv .venv
.\.venv\Scripts\pip.exe install --upgrade pip
.\.venv\Scripts\pip.exe install -r requirements.txt
echo "To package the backend with PyInstaller (optional):"
echo ".\.venv\\Scripts\\pyinstaller --onefile backend_app.py"
