@echo off
REM Create venv if missing and install requirements, then run backend
if not exist .venv (
  python -m venv .venv
  .venv\Scripts\pip.exe install --upgrade pip
  .venv\Scripts\pip.exe install -r requirements.txt
)
.venv\Scripts\python.exe backend_app.py
