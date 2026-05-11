const { app, BrowserWindow } = require('electron');
const path = require('path');
const { spawn } = require('child_process');

function startBundledBackend() {
  try {
    // When packaged, resources are placed under process.resourcesPath
    const bundledPath = path.join(process.resourcesPath, 'backend', 'TestTTS-backend.exe');
    const fs = require('fs');
    if (fs.existsSync(bundledPath)) {
      const child = spawn(bundledPath, [], { detached: true, stdio: 'ignore' });
      child.unref();
    }
  } catch (e) { console.error('Failed to start bundled backend', e); }
}

function createWindow() {
  const win = new BrowserWindow({
    width: 900,
    height: 700,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true
    }
  });
  win.loadFile(path.join(__dirname, 'index.html'));
}

app.whenReady().then(() => { startBundledBackend(); createWindow(); });
app.on('window-all-closed', () => { if (process.platform !== 'darwin') app.quit(); });
