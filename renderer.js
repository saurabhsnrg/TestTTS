const synthBtn = document.getElementById('synth');
const stopBtn = document.getElementById('stop');
const textEl = document.getElementById('text');
const voiceEl = document.getElementById('voice');
const player = document.getElementById('player');
const download = document.getElementById('download');
let currentUrl = null;

document.addEventListener('DOMContentLoaded', async () => {
  try {
    const voices = await window.api.getVoices();
    voiceEl.innerHTML = '';
    voices.forEach(v => {
      const opt = document.createElement('option');
      opt.value = v.id;
      opt.textContent = `${v.name} (${v.lang})`;
      voiceEl.appendChild(opt);
    });
  } catch (e) { console.error('Failed to load voices', e); }
});

synthBtn.onclick = async () => {
  const text = textEl.value.trim();
  if (!text) return alert('Enter text');
  synthBtn.disabled = true;
  synthBtn.textContent = 'Synthesizing...';
  try {
    const res = await window.api.synthesize({ text, voice: voiceEl.value });
    if (res.url) {
      currentUrl = res.url;
      player.src = res.url;
      await player.play();
      download.href = res.url;
      download.download = 'output.wav';
    } else {
      alert(res.error || 'Synthesis failed');
    }
  } catch (err) {
    alert('Error: ' + err.message);
  } finally {
    synthBtn.disabled = false;
    synthBtn.textContent = 'Synthesize';
  }
};

stopBtn.onclick = () => { player.pause(); player.currentTime = 0; };
