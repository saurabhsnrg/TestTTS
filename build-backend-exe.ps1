# Build backend executable with PyInstaller (no pre-download of model)
Set-StrictMode -Version Latest

# Create venv if missing
if (-not (Test-Path ".venv")) {
  python -m venv .venv
}

.\.venv\Scripts\pip.exe install --upgrade pip
.\.venv\Scripts\pip.exe install -r requirements.txt
.\.venv\Scripts\pip.exe install pyinstaller

# Build with PyInstaller; do NOT include a pre-downloaded model cache
Write-Host "Running PyInstaller (this may take a while)"
.\.venv\Scripts\pyinstaller --noconfirm --onefile --add-data "audio;audio" --name TestTTS-backend backend_app.py

# Move built exe to build directory for electron packaging
if (Test-Path "dist\\TestTTS-backend.exe") {
  New-Item -ItemType Directory -Path "build\\backend" -Force | Out-Null
  Move-Item -Path "dist\\TestTTS-backend.exe" -Destination "build\\backend\\TestTTS-backend.exe" -Force
  Write-Host "Moved backend exe to build\\backend\\TestTTS-backend.exe"
} else {
  Write-Host "PyInstaller did not produce exe at dist\\TestTTS-backend.exe"
}
