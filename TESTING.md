TESTING TestTTS (smoke test)

1) Start the backend (in a terminal)
   python -m venv .venv
   .\.venv\Scripts\pip.exe install --upgrade pip
   .\.venv\Scripts\pip.exe install -r requirements.txt
   .\.venv\Scripts\python.exe backend_app.py

   (Alternatively) run start-backend.bat which automates the above.

2) In a second terminal, run the smoke tester:
   python test_client.py

3) Expected result
   - test_client.py should print the generated /audio/<uuid>.wav URL then save audio_test.wav
   - Play audio_test.wav with any player (Windows Explorer, VLC)

Troubleshooting
- If the POST to /synthesize fails, inspect backend console for errors. Common problems: missing kokoro package, model weights not downloaded, or missing system dependency (e.g., libsndfile for soundfile).
- For libsndfile on Windows, install the appropriate wheel or redistribute packages (soundfile will often work if dependencies are installed).

Notes
- First run of kokoro may download model weights from Hugging Face; ensure internet access and enough disk space (~100s of MB).
- CPU-only will be slower; for faster performance consider a machine with AVX/optimized BLAS or using a GPU build.
