# Build Electron installer and include backend exe
Write-Host "Ensure backend exe exists at build\\backend\\TestTTS-backend.exe before running this"

# Install frontend deps
npm install

# Run electron-builder (this will include build/backend via extraResources)
npx electron-builder --win --x64

Write-Host "Installer created under dist\\"
