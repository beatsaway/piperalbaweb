@echo off
setlocal
cd /d "%~dp0"
set PORT=8770

echo Freeing port %PORT%...
for /f "tokens=5" %%P in ('netstat -ano ^| findstr /R /C:":%PORT% .*LISTENING"') do (
  echo Stopping PID %%P
  taskkill /F /PID %%P >nul 2>&1
)

echo Opening http://127.0.0.1:%PORT%
start "" cmd /c "timeout /t 1 /nobreak >nul & start http://127.0.0.1:%PORT%"

echo Local preview only. Uploading this folder to a web host does not need Python.
echo Serving http://127.0.0.1:%PORT%  ^&  close this window to stop it.
python -m http.server %PORT% --bind 127.0.0.1
if errorlevel 1 pause
