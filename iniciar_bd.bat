@echo off
chcp 65001 >nul
title Almacen - Inicializar Base de Datos
echo ========================================
echo   Almacen - Inicializacion de la BD
echo ========================================
echo.

:: Leer credenciales del .env
set "ENV_FILE=%~dp0.env"
if not exist "%ENV_FILE%" (
    echo ERROR: No se encontro el archivo .env
    echo Copia .env.example a .env y configura tus credenciales.
    echo.
    pause
    exit /b 1
)

for /f "usebackq tokens=1,* delims==" %%a in ("%ENV_FILE%") do (
    set "%%a=%%b"
)

:: Buscar mysql.exe
set "MYSQL_CMD=mysql"
where mysql >nul 2>&1
if %errorlevel% neq 0 (
    if exist "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" (
        set "MYSQL_CMD=C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
    ) else if exist "C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe" (
        set "MYSQL_CMD=C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe"
    ) else if exist "C:\Program Files\MySQL\MySQL Server 9.0\bin\mysql.exe" (
        set "MYSQL_CMD=C:\Program Files\MySQL\MySQL Server 9.0\bin\mysql.exe"
    ) else (
        echo ERROR: No se encontro mysql.exe
        echo Instala MySQL Server o anade su carpeta bin al PATH.
        echo.
        pause
        exit /b 1
    )
)

echo Conectando a MySQL como %DB_USER%@%DB_HOST%...
echo.
echo AVISO: Si la base de datos ya existe se borrara y se creara de nuevo.
echo.

:: Ejecutar el SQL
"%MYSQL_CMD%" -h %DB_HOST% -u %DB_USER% -p%DB_PASSWORD% < "%~dp0database\database.sql"

if %errorlevel%==0 (
    echo.
    echo ========================================
    echo   Base de datos creada correctamente
    echo ========================================
    echo.
    echo   Base de datos: %DB_NAME%
    echo   Tablas creadas:
    echo     - productos       ^(19 productos^)
    echo     - pedidos         ^(15 pedidos^)
    echo     - detalles_pedido ^(detalles de cada pedido^)
    echo     - stock           ^(stock de cada producto^)
    echo.
    echo   Ya puedes ejecutar iniciar.bat
    echo.
) else (
    echo.
    echo ERROR al crear la base de datos.
    echo Comprueba que:
    echo   1. MySQL esta instalado y en ejecucion
    echo   2. Las credenciales en .env son correctas
    echo.
)

pause
