@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 2>nul
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else (
    goto gotAdmin
)
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /b
:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

echo =========================================
echo   OSSD University Planner Deployment
echo =========================================
echo.

echo [1/4] Creating IIS directory...
if not exist "C:\inetpub\wwwroot\OUP" mkdir "C:\inetpub\wwwroot\OUP"

echo [2/4] Copying files...
xcopy /E /I /Y "C:\OUP-Project\*" "C:\inetpub\wwwroot\OUP\" 
if errorlevel 1 (
    echo ERROR: File copy failed
    pause
    exit /b 1
)

echo [3/4] Setting permissions...
icacls "C:\inetpub\wwwroot\OUP\db" /grant IIS_IUSRS:(OI)(CI)M /T 
icacls "C:\inetpub\wwwroot\OUP\db\oup_data.mdb" /grant IIS_IUSRS:M 

echo [4/4] Verifying...
if exist "C:\inetpub\wwwroot\OUP\login.asp" (
    echo SUCCESS: Deployment complete!
) else (
    echo ERROR: Deployment failed
    pause
    exit /b 1
)

echo.
echo =========================================
echo   NEXT STEPS:
echo =========================================
echo.
echo 1. Open browser and go to:
echo    http://localhost/oup/create_database.asp
echo.
echo 2. Then go to:
echo    http://localhost/oup/universities/init_universities.asp
echo.
echo 3. Finally register at:
echo    http://localhost/oup/register.asp
echo.
echo =========================================
pause
