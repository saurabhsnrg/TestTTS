Write-Host "Package backend with PyInstaller (optional). Requires .venv and pyinstaller installed in venv."
.\.venv\Scripts\pip.exe install pyinstaller
.\.venv\Scripts\pyinstaller --onefile backend_app.py --add-data "audio;audio" --name TestTTS-backend
Write-Host "Binary located in dist\\TestTTS-backend.exe"
