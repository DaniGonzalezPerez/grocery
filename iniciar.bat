@echo off
title Almacen - Servidor
echo ========================================
echo    Almacen - Iniciando servidor...
echo ========================================
echo.

cd /d "%~dp0backend"

echo Verificando dependencias...
pip install flask flask-cors mysql-connector-python >nul 2>&1

echo Iniciando servidor...
start /b python server.py

echo Esperando a que el servidor este listo...
timeout /t 3 /noqueue >nul

echo.
echo Abriendo aplicacion en el navegador...
start "" "http://localhost:5000"

echo.
echo ========================================
echo  Servidor activo en http://localhost:5000
echo  Presiona cualquier tecla para detener.
echo ========================================
echo.
pause >nul

taskkill /f /im python.exe >nul 2>&1
