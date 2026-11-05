@echo off
setlocal
cd /d "%~dp0\.."
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-AvalAI.ps1"
echo.
echo Installer finished. Press any key to close.
pause >nul
