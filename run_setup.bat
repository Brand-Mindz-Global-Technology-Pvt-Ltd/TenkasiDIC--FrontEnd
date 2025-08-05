@echo off
echo ========================================
echo Tenkasi DIC - Auto Setup Script
echo ========================================
echo.

:: Check if XAMPP is installed
echo [1/6] Checking XAMPP installation...
if exist "C:\xampp\xampp-control.exe" (
    echo ✅ XAMPP found at C:\xampp\
) else (
    echo ❌ XAMPP not found at C:\xampp\
    echo Please install XAMPP from: https://www.apachefriends.org/
    pause
    exit /b 1
)

:: Check if project exists in htdocs
echo.
echo [2/6] Checking project files...
if exist "C:\xampp\htdocs\TenkasiDIC--FrontEnd\" (
    echo ✅ Project found in htdocs
) else (
    echo ❌ Project not found in htdocs
    echo Please copy your project to: C:\xampp\htdocs\TenkasiDIC--FrontEnd\
    pause
    exit /b 1
)

:: Start XAMPP services
echo.
echo [3/6] Starting XAMPP services...
echo Starting Apache...
start /B "C:\xampp\xampp-control.exe"
timeout /t 3 /nobreak >nul

:: Wait for services to start
echo Waiting for services to start...
timeout /t 10 /nobreak >nul

:: Check if Apache is running
echo.
echo [4/6] Checking Apache service...
netstat -an | findstr ":80 " >nul
if %errorlevel% equ 0 (
    echo ✅ Apache is running on port 80
) else (
    echo ❌ Apache is not running
    echo Please start Apache manually in XAMPP Control Panel
    pause
    exit /b 1
)

:: Check if MySQL is running
echo.
echo [5/6] Checking MySQL service...
netstat -an | findstr ":3306 " >nul
if %errorlevel% equ 0 (
    echo ✅ MySQL is running on port 3306
) else (
    echo ❌ MySQL is not running
    echo Please start MySQL manually in XAMPP Control Panel
    pause
    exit /b 1
)

:: Open setup page in browser
echo.
echo [6/6] Opening setup page...
echo ✅ All services are running!
echo.
echo Opening setup page in browser...
start http://localhost/TenkasiDIC--FrontEnd/admin/setup.php
echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Complete the setup in your browser
echo 2. Access admin panel: http://localhost/TenkasiDIC--FrontEnd/admin/
echo 3. Upload your documents
echo.
echo Press any key to open admin panel...
pause >nul
start http://localhost/TenkasiDIC--FrontEnd/admin/
echo.
echo Admin panel opened! You can now:
echo - Upload documents
echo - Manage existing documents
echo - View statistics
echo.
pause 