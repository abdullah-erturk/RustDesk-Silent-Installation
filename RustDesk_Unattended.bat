
@echo off
title RustDesk
mode con:cols=50 lines=5
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit >nul 2>&1
title RustDesk
mode con:cols=95 lines=20

:: If you have a Rustdesk server, type the domain or ip address. Example: set domain=-host=192.168.1.1
set domain=

:: If you have a Rustdesk server, type the key your server generated. Example: set key=ghtYUjykk2489=
set key=

:: NOTE: 
:: If you do not specify domain and key, RustDesk software will be installed with default settings.


cd /d %temp%
echo.
echo.
echo    RustDesk
echo.
echo.

:: Rustdesk software will be downloaded and installed as an overnight release only.
:: You may need to manually change the github link in the script when Rustdesk releases the final version of the software.
echo    RustDesk downloading software, please wait...
start /wait /min powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/rustdesk/rustdesk/releases/download/nightly/rustdesk-1.2.0-x86_64-pc-windows-msvc.exe', 'rustdesk%domain%,key=%key%.exe')" >nul 2>&1

echo.
echo    Installing RustDesk software, please wait...
start /wait rustdesk%domain%,key=%key%.exe --silent-install
echo.
echo.
echo   !!! INSTALLATION COMPLETED !!!
echo.
echo.
echo    You can run the program via the shortcut created on the desktop or the Start Menu...
del /f /q "rustdesk%domain%,key=%key%.exe" >nul
echo.
echo.
echo    Press any key to EXIT...
echo.
pause >nul
exit