@echo off
start "TestTTS Backend" cmd /k "\.\start-backend.bat"
REM Start Electron (assumes npm install done)
npm start
