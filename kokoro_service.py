import os
import logging
import soundfile as sf
import numpy as np
from kokoro import KPipeline

log = logging.getLogger(__name__)

class KokoroService:
    def __init__(self, lang='a'):
        # lazy init to avoid long startup in some environments
        self.pipeline = None
        self.lang = lang

    def _ensure(self, lang=None):
        if lang is None:
            lang = self.lang
        if self.pipeline is None:
            # If a bundled model_cache exists, prefer it by setting HF environment caches
            bundled_cache = os.path.abspath(os.path.join(os.path.dirname(__file__), 'model_cache'))
            if os.path.isdir(bundled_cache):
                os.environ.setdefault('HF_HOME', bundled_cache)
                os.environ.setdefault('TRANSFORMERS_CACHE', bundled_cache)
                os.environ.setdefault('HF_DATASETS_CACHE', bundled_cache)
            # device is CPU by default for this packaging
            self.pipeline = KPipeline(lang_code=lang)

    def synthesize_to_file(self, text, voice='af_heart', lang=None, out_path='out.wav', sample_rate=24000):
        self._ensure(lang=lang)
        try:
            generator = self.pipeline(text, voice=voice)
            audio_data = None
            for i, (gs, ps, audio) in enumerate(generator):
                if audio_data is None:
                    audio_data = audio
                else:
                    audio_data = np.concatenate([audio_data, audio], axis=0)
            if audio_data is None:
                raise RuntimeError('No audio generated')
            # ensure output directory exists
            os.makedirs(os.path.dirname(out_path) or '.', exist_ok=True)
            sf.write(out_path, audio_data, sample_rate)
            return out_path
        except Exception:
            log.exception('Synthesis failed')
            raise
