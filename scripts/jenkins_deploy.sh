#!/usr/bin/env bash
set -e
VENV_DIR=venv
if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
fi
source "$VENV_DIR/bin/activate"
python -m pip install --upgrade pip
if [ -f requirements.txt ]; then
  pip install -r requirements.txt || true
fi
# Prefer gunicorn if available
if command -v gunicorn >/dev/null 2>&1; then
  exec gunicorn -w 4 -b 0.0.0.0:8000 app:app
else
  exec python app.py
fi
