@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 2>nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto gotAdmin)
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /b
:gotAdmin
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")

echo [1/3] Removing read-only...
attrib -r "C:\inetpub\wwwroot\db\oup_data.mdb" /s

echo [2/3] Setting folder permissions...
icacls "C:\inetpub\wwwroot\db" /grant Everyone:F /T
icacls "C:\inetpub\wwwroot\db" /grant IIS_IUSRS:(OI)(CI)F /T
icacls "C:\inetpub\wwwroot\db" /grant IUSR:(OI)(CI)F /T

echo [3/3] Setting file permissions...
icacls "C:\inetpub\wwwroot\db\oup_data.mdb" /grant Everyone:F
icacls "C:\inetpub\wwwroot\db\oup_data.mdb" /grant IIS_IUSRS:F
icacls "C:\inetpub\wwwroot\db\oup_data.mdb" /grant IUSR:F

echo Done!
pause
