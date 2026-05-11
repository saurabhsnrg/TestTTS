TestTTS

A local Windows (Electron) app that uses Kokoro-82M for CPU-only TTS.

Quick start (development):
1. Install Python 3.11+ and Node.js
2. Backend: in repository root, run `python -m venv .venv` then `.\.venv\Scripts\pip.exe install -r requirements.txt` and `python backend_app.py`
3. Frontend: `npm install` then `npm run start` (from project root)

Packaging:
- To build the Electron app (requires npm deps): run `npx electron-builder --win` (or use scripts/package-electron.ps1)
- To package the backend into a single exe: use `package-backend.ps1` which calls PyInstaller (requires .venv)

Notes:
- The backend exposes POST /synthesize and serves generated WAV files under /audio
- The app uses the Kokoro package (Apache license). When distributing, include the model attribution and license from https://huggingface.co/hexgrad/Kokoro-82M
- CPU-only inference will be slower; consider bundling a Python runtime or a prebuilt backend binary for an easier user experience.
