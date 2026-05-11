from fastapi import FastAPI
from pydantic import BaseModel
from typing import Optional
import uuid, os
from fastapi.staticfiles import StaticFiles
from kokoro_service import KokoroService

app = FastAPI()
svc = KokoroService()

# ensure audio dir exists
os.makedirs('audio', exist_ok=True)
app.mount('/audio', StaticFiles(directory='audio'), name='audio')

class SynthesizeRequest(BaseModel):
    text: str
    voice: Optional[str] = 'af_heart'
    lang: Optional[str] = 'a'

@app.get('/status')
def status():
    return {'status': 'ok'}

@app.post('/synthesize')
def synth(req: SynthesizeRequest):
    filename = f"{uuid.uuid4().hex}.wav"
    out_path = os.path.join('audio', filename)
    svc.synthesize_to_file(req.text, voice=req.voice, lang=req.lang, out_path=out_path)
    return {'url': f'http://127.0.0.1:8000/audio/{filename}'}

if __name__ == '__main__':
    import uvicorn
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--download-model', action='store_true', help='Download Kokoro model to local cache and exit')
    args = parser.parse_args()
    if args.download_model:
        print('Downloading Kokoro model to ./model_cache (this may take a while)')
        svc.ensure_model_cache()
        print('Model download complete')
        raise SystemExit(0)
    uvicorn.run(app, host='127.0.0.1', port=8000)
