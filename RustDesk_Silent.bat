
	:: INFO:
	:: RustDesk Silent Installation AIO
	:: RustDesk Github: https://github.com/rustdesk/rustdesk
	:: https://github.com/abdullah-erturk/RustDesk-Silent-Installation

@echo off
setlocal enabledelayedexpansion
title RustDesk Silent Installation Tool v2 ^| by Abdullah ERTšRK
mode con:cols=90 lines=25
color 0B

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Language Check (PS 2.0 Compatible)
for /f "delims=" %%a in ('powershell -NoProfile -Command "(Get-UICulture).TwoLetterISOLanguageName" 2^>nul') do set OS_LANG=%%a
set LANG_TR=0
if /i "%OS_LANG%"=="tr" set LANG_TR=1

:Menu
cls
echo.
echo    ============================================================================
echo			RUSTDESK SILENT INSTALLATION TOOL by Abdullah ERTšRK
echo.
echo.		github.com/abdullah-erturk ^| erturk-dev.netlify.app

echo    ============================================================================
echo.
if "%LANG_TR%"=="1" (
    echo    Ltfen kurulum trn se‡in:
    echo.
    echo    [1] Public Sunucu ile Kurulum  ^(Standart, cretsiz RustDesk sunucular^)
    echo.
    echo    [2] Private Sunucu ile Kurulum ^(™zel IP/Host ve Key gerektirir^)
    echo.
    echo    [3] €IKIž
	echo.
	echo.
	choice /c 123 /n /m "Se‡iminiz [1-2-3] : "

) else (
    echo    Please select installation type:
    echo.
    echo    [1] Install with Public Server  ^(Standard, free RustDesk servers^)
    echo.
    echo    [2] Install with Private Server ^(Requires custom IP/Host and Key^)
    echo.
    echo    [3] Exit
	echo.
	echo.
	choice /c 123 /n /m "Your Choice [1-2-3] : "

)
if errorlevel 3 exit
if errorlevel 2 goto PrivateInstall
if errorlevel 1 goto PublicInstall
goto Menu

:PrivateInstall
cls
echo.
if "%LANG_TR%"=="1" (
    echo    === PRIVATE SUNUCU AYARLARI ===
    echo    Ltfen sunucu IP adresini veya Host adn girin. ^(”rn: rustdesk.myserver.com^)
) else (
    echo    === PRIVATE SERVER SETTINGS ===
    echo    Please enter the Server IP or Hostname. ^(e.g. rustdesk.myserver.com^)
)
echo.
set /p RS_HOST="Host/IP: "
if "%RS_HOST%"=="" goto PrivateInstall

echo.
if "%LANG_TR%"=="1" (
    echo    Ltfen Key ^(žifre^) bilgisini girin. E§er key yoksa boŸ brakp ENTER'a basn.
) else (
    echo    Please enter the Key. If no key is required, leave blank and press ENTER.
)
set /p RS_KEY="Key: "
goto StartProcess

:PublicInstall
set RS_HOST=
set RS_KEY=
goto StartProcess

:StartProcess
cls
cd /d %temp%
taskkill /im rustdesk.exe /f >nul 2>&1

echo.
if "%LANG_TR%"=="1" (
    echo    Gncel RustDesk srm kontrol ediliyor...
) else (
    echo    Checking the latest RustDesk version...
)

:: PowerShell 2.0 / Windows 7 Compatible Version Fetcher
for /f "delims=" %%v in ('powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072; $req = [System.Net.WebRequest]::Create('https://github.com/rustdesk/rustdesk/releases/latest'); $req.AllowAutoRedirect = $true; try { $res = $req.GetResponse(); $res.ResponseUri.OriginalString.Split('/')[-1].Trim('v') } catch { 'ERROR' }"') do set version=%%v

if "%version%"=="" set version=ERROR
if "%version%"=="ERROR" (
    if "%LANG_TR%"=="1" (
        echo    Hata: Github'dan srm bilgisi alnamad! ˜nternet ba§lantnz kontrol edin.
    ) else (
        echo    Error: Could not retrieve version info from Github! Check your internet connection.
    )
    pause
    exit /b 1
)

if "%LANG_TR%"=="1" (
    echo    En son srm bulundu: %version%
) else (
    echo    Latest version found: %version%
)

:: Detect Architecture properly
set ARCH_TYPE=x86
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" set ARCH_TYPE=x86_64
if defined PROCESSOR_ARCHITEW6432 set ARCH_TYPE=x86_64
if /i "%PROCESSOR_ARCHITECTURE%"=="ARM64" set ARCH_TYPE=aarch64

if "%ARCH_TYPE%"=="x86_64" (
    set "download_url=https://github.com/rustdesk/rustdesk/releases/download/%version%/rustdesk-%version%-x86_64.exe"
)
if "%ARCH_TYPE%"=="aarch64" (
    set "download_url=https://github.com/rustdesk/rustdesk/releases/download/%version%/rustdesk-%version%-aarch64.exe"
)
if "%ARCH_TYPE%"=="x86" (
    set "download_url=https://github.com/rustdesk/rustdesk/releases/download/%version%/rustdesk-%version%-x86-sciter.exe"
)

echo.
if "%LANG_TR%"=="1" (
    echo    RustDesk indiriliyor, ltfen bekleyin...
) else (
    echo    RustDesk is downloading, please wait...
)

:: PowerShell 2.0 TLS 1.2 WebClient Download
powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072; try { (New-Object Net.WebClient).DownloadFile('%download_url%', 'rustdesk_installer.exe') } catch { exit 1 }"
if %errorlevel% neq 0 (
    if "%LANG_TR%"=="1" (
        echo    ˜ndirme baŸarsz oldu!
    ) else (
        echo    Download failed!
    )
    pause
    exit /b 1
)

:: Smart renaming for silent install with config
set "rustdesk_file=rustdesk_installer.exe"

if not "%RS_HOST%"=="" (
    if not "%RS_KEY%"=="" (
        set "rustdesk_file=rustdesk-host=%RS_HOST%,key=%RS_KEY%.exe"
    ) else (
        set "rustdesk_file=rustdesk-host=%RS_HOST%.exe"
    )
    rename rustdesk_installer.exe "!rustdesk_file!"
    timeout /t 2 >nul 2>&1
)

echo.
if "%LANG_TR%"=="1" (
    echo    RustDesk sessizce kuruluyor...
) else (
    echo    RustDesk is installing silently...
)

cmd /c start /wait "" "%temp%\!rustdesk_file!" --silent-install

:check_service
sc query "RustDesk" | findstr /I "RUNNING" >nul 2>&1
if not errorlevel 1 goto end
timeout /t 5 /nobreak >nul 2>&1
goto check_service

:end
del /f /q rustdesk* >nul 2>&1
echo.
if "%LANG_TR%"=="1" (
    echo    KURULUM TAMAMLANDI!
    echo    RustDesk baŸaryla kuruldu ve arka planda ‡alŸyor.
    echo.
    echo    €kŸ icin herhangi bir tuŸa basn...
) else (
    echo    INSTALLATION COMPLETED!
    echo    RustDesk has been successfully installed and is running in the background.
    echo.
    echo    Press any key to exit...
)
pause >nul
exit