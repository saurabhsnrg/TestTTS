const { contextBridge } = require('electron');
const fs = require('fs');
const path = require('path');

const voicesPath = path.join(__dirname, 'voices.json');

contextBridge.exposeInMainWorld('api', {
  getVoices: async () => {
    try {
      const raw = fs.readFileSync(voicesPath, 'utf8');
      return JSON.parse(raw);
    } catch (e) { return []; }
  },
  synthesize: async (payload) => {
    const res = await fetch('http://127.0.0.1:8000/synthesize', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });
    return res.json();
  },
  status: async () => { const res = await fetch('http://127.0.0.1:8000/status'); return res.json(); }
});
