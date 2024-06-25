

' INFO:

' RustDesk Silent Installation
' Copyright (C) 2024 Abdullah ERTÜRK
' https://github.com/abdullah-erturk/RustDesk-Silent-Installation


@echo off
setlocal enabledelayedexpansion
title RustDesk ^| made by Abdullah ERTURK
mode con:cols=50 lines=5
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit >nul 2>&1
mode con:cols=95 lines=20

if exist "%windir%\system32\curl.exe" (
goto :run
) else (
echo.
echo    ATTENTION
echo.
echo    curl.exe not found, first you need to download curl.exe and copy it to %windir%\system32\
echo.
echo Press any key to exit.
pause >nul
start "" "https://curl.se/windows/"
exit
)

:run
:: If you have a Rustdesk server, type the domain name or ip address. Example: set domain=-host=192.168.1.1
set domain=

:: If you have a Rustdesk server, type the key your server generated. Example: set key=ghtYUjykk2489=
set key=

:: NOTE: 
:: If you do not specify a domain and key, RustDesk will install with default settings and use public servers.

cd /d %temp%
echo.
echo.
echo    RustDesk
echo.
echo.

:: The script only downloads the latest stable version of Rustdesk software
echo    RustDesk downloading software, please wait...

set github_user=rustdesk
set github_repo=rustdesk

set target_name_match=x86_64.exe

for /f "tokens=1,* delims=:" %%A IN ('curl -ks https://api.github.com/repos/%github_user%/%github_repo%/releases/latest ^| findstr "browser_download_url"') do (
    set url=%%B
    if not "!url:%target_name_match%=!"=="!url!" (
        curl -kOL !url! >nul 2>&1
        for /r %%F in (*%target_name_match%*) do (
            set "downloaded_file=%%~nxF"
            set "downloaded_file_path=%%F"
        )
        set "new_filename=rustdesk%domain%,key=%key%.exe"
        move "!downloaded_file_path!" "!new_filename!" >nul 2>&1
    )
)

echo.
echo    Installing RustDesk software, please wait...
start /wait rustdesk%domain%,key=%key%.exe --silent-install
echo.
echo.
echo    INSTALLATION COMPLETED 
echo.
echo.
echo    You can run the program via the shortcut created on the desktop or the Start Menu...
echo.
echo.
echo    Press any key to EXIT...
echo.
pause >nul
del /f /q "rustdesk%domain%,key=%key%.exe" >nul
exit
