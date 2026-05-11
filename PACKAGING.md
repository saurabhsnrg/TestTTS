Packaging TestTTS (quick reference)

Prereqs:
- Node.js (16+)
- Python 3.11+
- Git

Build backend (dev):
1. python -m venv .venv
2. .\.venv\Scripts\pip.exe install -r requirements.txt
3. python backend_app.py

Package backend (optional):
- .\.venv\Scripts\pip.exe install pyinstaller
- .\.venv\Scripts\pyinstaller --onefile backend_app.py --add-data "audio;audio" --name TestTTS-backend

Build frontend (Windows):
- npm install
- npm run build:win

Bundling notes:
- Place the PyInstaller single exe into the installer resources or ship as a separate artifact.
- To auto-run the backend at startup, include a simple launcher that starts the backend in background and then starts the Electron app.

Code signing:
- Configure electron-builder with CSC_LINK and CSC_KEY_PASSWORD env vars for signing.

Model attribution:
- Include ATTRIBUTION.md from the project root with model URL and license.
