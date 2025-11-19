@echo off
setlocal
set VENV_DIR=venv
if not exist %VENV_DIR% (
  python -m venv %VENV_DIR%
)
call %VENV_DIR%\Scripts\activate
python -m pip install --upgrade pip
if exist requirements.txt (
  pip install -r requirements.txt
)
where gunicorn >nul 2>nul
if %ERRORLEVEL%==0 (
  %VENV_DIR%/Scripts/gunicorn -w 4 -b 0.0.0.0:8000 app:app > gunicorn.log 2>&1
) else (
  %VENV_DIR%/Scripts/python app.py > app.log 2>&1
)
timeout /t 5 /nobreak >nul
echo Server started in background
