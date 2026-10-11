@echo off
title Sasquatch Cleanup Tools
color 06

echo ==========================================
echo        Sasquatch Cleanup Tools
echo ==========================================
echo.

echo [1/7] Cleaning User Temp...
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%D in ("%TEMP%\*") do rd /s /q "%%D" >nul 2>&1
echo        Done!
echo.

echo [2/7] Cleaning Windows Temp...
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
for /d %%D in ("%SystemRoot%\Temp\*") do rd /s /q "%%D" >nul 2>&1
echo        Done!
echo.

echo [3/7] Cleaning Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%D in ("%SystemRoot%\SoftwareDistribution\Download\*") do rd /s /q "%%D" >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
echo        Done!
echo.

echo [4/7] Cleaning Thumbnail Cache...
taskkill /f /im explorer.exe >nul 2>&1
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*" >nul 2>&1
start explorer.exe
echo        Done!
echo.

echo [5/7] Cleaning Windows Error Reports...
rd /s /q "%ProgramData%\Microsoft\Windows\WER" >nul 2>&1
echo        Done!
echo.

echo [6/7] Flushing DNS Cache...
ipconfig /flushdns
echo        Done!
echo.

echo [7/7] Emptying Recycle Bin...
powershell -NoProfile -Command "Clear-RecycleBin -Force" >nul 2>&1
echo        Done!
echo.

echo Running Disk Cleanup...
cleanmgr /verylowdisk
echo        Done!
echo.

echo ==========================================
echo      Cleanup Complete!
echo ==========================================
pause