Write-Host "Run from project root after installing npm deps"
npm install
# Build electron app for Windows
npx electron-builder --win --x64
Write-Host "Built with electron-builder. See dist/ for output."
