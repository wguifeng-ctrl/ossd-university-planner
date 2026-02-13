@echo off
echo =========================================
echo   Fixing Database Permissions
echo =========================================
echo.

echo [1/2] Removing read-only attribute...
attrib -r "C:\inetpub\wwwroot\db\oup_data.mdb"

echo [2/2] Granting full permissions...
icacls "C:\inetpub\wwwroot\db\oup_data.mdb" /grant Everyone:F
icacls "C:\inetpub\wwwroot\db\oup_data.mdb" /grant IIS_IUSRS:F
icacls "C:\inetpub\wwwroot\db\oup_data.mdb" /grant IUSR:F

echo.
echo Done! Now refresh the page.
pause
