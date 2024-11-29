

	:: INFO:

	:: RustDesk Silent Installation
	:: Copyright (C) 2024 Abdullah ERTURK
	:: https://github.com/abdullah-erturk/RustDesk-Silent-Installation

	:: RustDesk Github Link: https://github.com/rustdesk/rustdesk

@echo off
setlocal enabledelayedexpansion
title RustDesk ^| made by Abdullah ERTURK
mode con:cols=50 lines=5
:: Check if running as administrator
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit >nul 2>&1
mode con:cols=95 lines=25
taskkill /im rustdesk.exe /f >nul 2>&1

cd /d %temp%

:: If you have a Rustdesk server, type the domain name or IP address. Example: set domain=192.168.1.1
set domain=

:: If you have a Rustdesk server, type the key your server generated. Example: set key=ghtYUjykk2489=
set key=

:: NOTE: 
:: If you do not specify a domain and key, RustDesk will install with default settings and use public servers.

echo.
echo.
echo    RustDesk
echo.
echo.

echo    Initializing...
echo.


:: The code to check the Rustdesk version number is taken from techahold's WindowsAgentAIOInstall.ps1 file. Thanks to him.
:: https://github.com/techahold/rustdeskinstall/blob/master/WindowsAgentAIOInstall.ps1

:: Create the get_latest_version.ps1 file and write its content
echo $url = 'https://www.github.com//rustdesk/rustdesk/releases/latest' > get_latest_version.ps1
echo $request = [System.Net.WebRequest]::Create($url) >> get_latest_version.ps1
echo $response = $request.GetResponse() >> get_latest_version.ps1
echo $realTagUrl = $response.ResponseUri.OriginalString >> get_latest_version.ps1
echo $RDLATEST = $realTagUrl.split('/')[-1].Trim('v') >> get_latest_version.ps1
echo $RDLATEST ^| Out-File -FilePath version.txt -Encoding ASCII >> get_latest_version.ps1

:: Run the PowerShell script to get the latest version number
powershell -ExecutionPolicy Bypass -File get_latest_version.ps1

:: Read the version number from the file
set /p version=<version.txt

if "%version%"=="" (
    echo    Error: Unable to retrieve RustDesk version information.
    pause
    exit /b 1
)

:: Clean the double quotes
set version=%version:"=%

echo    Latest version of RustDesk: %version%

set "url_64=https://github.com/rustdesk/rustdesk/releases/download/%version%/rustdesk-%version%-x86_64.exe"
set "url_32=https://github.com/rustdesk/rustdesk/releases/download/%version%/rustdesk-%version%-x86-sciter.exe"

:: Detect Windows version
for /f "tokens=4-5 delims=[.] " %%i in ('ver') do set os_version=%%i.%%j

set download_url=%url_64%
set is64bit=true
echo %os_version% | findstr /r "^10" >nul 2>&1
if errorlevel 1 (
    set download_url=%url_32%
    set is64bit=false
)

echo.
echo    RustDesk software is downloading, please wait...
echo.
powershell -Command "(New-Object Net.WebClient).DownloadFile('%download_url%', 'rustdesk.exe')"

:: Create the file name using the domain and key
set "rustdesk_file=rustdesk-host=%domain%,key=%key%.exe"
rename rustdesk.exe "%rustdesk_file%"
timeout /t 3  >nul 2>&1
echo    RustDesk is installing, please wait...
echo.
set "full_path=%temp%\%rustdesk_file%" 

:: Start the installation process and wait
cmd /c start /wait "" "%full_path%" --silent-install

:: Check if the RustDesk service has started
:check_service
sc query "RustDesk" | findstr /I "RUNNING" >nul 2>&1
if not errorlevel 1 (
    goto end
)
timeout /t 10 /nobreak >nul 2>&1
goto check_service

:end
del /f /q rustdesk* >nul 2>&1
del /f /q version.txt >nul 2>&1
del /f /q get_latest_version.ps1 >nul 2>&1
echo.
echo    INSTALLATION COMPLETED 
echo.
echo.
echo    You can run the program via the shortcut created on the desktop or the Start Menu...
echo.
echo.
echo    Press any key to EXIT...
echo.
pause >nul 2>&1
exit
