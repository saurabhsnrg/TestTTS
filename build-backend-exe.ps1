# Build backend executable with PyInstaller and pre-download Kokoro model
Set-StrictMode -Version Latest

# Create venv if missing
if (-not (Test-Path ".venv")) {
  python -m venv .venv
}

.\.venv\Scripts\pip.exe install --upgrade pip
.\.venv\Scripts\pip.exe install -r requirements.txt
.\.venv\Scripts\pip.exe install pyinstaller huggingface-hub

# Pre-download Kokoro model into backend/model_cache
Write-Host "Downloading Kokoro model to backend\\model_cache (this may be large)"
.\.venv\Scripts\python.exe - <<"PY"
from huggingface_hub import snapshot_download
print('Starting snapshot_download...')
snapshot_download(repo_id='hexgrad/Kokoro-82M', cache_dir='backend\\model_cache')
print('Download done')
PY

# Build with PyInstaller, include model_cache and audio folder
Write-Host "Running PyInstaller (this may take a while)"
.\.venv\Scripts\pyinstaller --noconfirm --onefile --add-data "backend\\model_cache;model_cache" --add-data "audio;audio" --name TestTTS-backend backend_app.py

# Move built exe to build directory for electron packaging
if (Test-Path "dist\\TestTTS-backend.exe") {
  New-Item -ItemType Directory -Path "build\\backend" -Force | Out-Null
  Move-Item -Path "dist\\TestTTS-backend.exe" -Destination "build\\backend\\TestTTS-backend.exe" -Force
  Write-Host "Moved backend exe to build\\backend\\TestTTS-backend.exe"
} else {
  Write-Host "PyInstaller did not produce exe at dist\\TestTTS-backend.exe"
}
