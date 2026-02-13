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

echo =========================================
echo   Fixing IIS for Access 2007
echo =========================================
echo.

echo [1/3] Setting Application Pool to 32-bit...
%windir%\system32\inetsrv\appcmd set apppool "DefaultAppPool" /enable32BitAppOnWin64:true

echo [2/3] Installing Access OLEDB (if not present)...
regsvr32 /u /s msjetoledb40.dll
regsvr32 /s msjetoledb40.dll

echo [3/3] Restarting IIS...
iisreset /restart

echo.
echo =========================================
echo   IIS Configuration Complete!
echo =========================================
echo.
echo Now try: http://localhost/oup/create_database.asp
pause
