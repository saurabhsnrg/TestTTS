import requests

"""Simple smoke test client for TestTTS backend.
Usage: python test_client.py
Make sure the backend is running at http://127.0.0.1:8000
"""

def main():
    url = 'http://127.0.0.1:8000/synthesize'
    payload = {
        'text': 'Hello from TestTTS smoke test. This verifies synthesis end-to-end.',
        'voice': 'af_heart',
        'lang': 'a'
    }
    print('Posting synth request...')
    r = requests.post(url, json=payload, timeout=300)
    try:
        r.raise_for_status()
    except Exception as e:
        print('Request failed:', e)
        print('Response:', r.status_code, r.text)
        return
    data = r.json()
    synth_url = data.get('url')
    if not synth_url:
        print('No url returned:', data)
        return
    print('Downloading generated audio from', synth_url)
    rr = requests.get(synth_url, stream=True)
    if rr.status_code != 200:
        print('Failed to download audio:', rr.status_code)
        return
    with open('audio_test.wav', 'wb') as f:
        for chunk in rr.iter_content(1024):
            f.write(chunk)
    print('Saved audio_test.wav')

if __name__ == '__main__':
    main()
