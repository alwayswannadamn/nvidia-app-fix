@echo off
chcp 65001
mode con: cols=60 lines=30
title NVIDIA Services Control Panel
color 0a

:menu
cls
echo ============================================================
echo             ███╗   ██╗██╗   ██╗██╗██████╗ ██╗ █████╗ 
echo             ████╗  ██║██║   ██║██║██╔══██╗██║██╔══██╗
echo             ██╔██╗ ██║██║   ██║██║██║  ██║██║███████║
echo             ██║╚██╗██║╚██╗ ██╔╝██║██║  ██║██║██╔══██║
echo             ██║ ╚████║ ╚████╔╝ ██║██████╔╝██║██║  ██║
echo             ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝
echo ============================================================
echo.
echo             NVIDIA Background Services Controller
echo ------------------------------------------------------------
echo  [1] Disable unnecessary NVIDIA background services
echo  [2] Enable all NVIDIA background services
echo  [3] Exit
echo ------------------------------------------------------------
set /p choice=Select an option (1-4): 

if "%choice%"=="1" goto disable
if "%choice%"=="2" goto enable
if "%choice%"=="3" exit
goto menu

:disable
cls
echo ------------------------------------------------------------
echo [ Disabling all unnecessary NVIDIA background services... ]
echo ------------------------------------------------------------

:: Kill non-essential processes
for %%p in (
  "NVIDIA App.exe"
  "NVIDIA Share.exe"
  "NVIDIA Web Helper.exe"
  "NVIDIA ShadowPlay Helper.exe"
  "NVIDIA Overlay.exe"
  "NvContainer.exe"
  "nvsphelper64.exe"
  "nvsphelper.exe"
  "NvBackend.exe"
) do (
  taskkill /f /im %%p >nul 2>&1
)

:: Stop telemetry and Experience services, keep only driver-critical ones
for %%s in (
  "NvContainerLocalSystem"
  "NvContainerNetworkService"
  "NvTelemetryContainer"
  "NVIDIA FrameView SDK Service"
) do (
  sc stop %%s >nul 2>&1
  sc config %%s start= disabled >nul 2>&1
)

:: Keep only these running for driver:
:: NVDisplay.ContainerLocalSystem (nvrlA.exe)
:: FvContainer.System and FvContainer (FrameView core)

echo Done.
echo.
pause
goto menu

:enable
cls
echo ------------------------------------------------------------
echo [ Re-enabling all NVIDIA background services... ]
echo ------------------------------------------------------------

for %%s in (
  "NvContainerLocalSystem"
  "NvContainerNetworkService"
  "NVDisplay.ContainerLocalSystem"
  "NvTelemetryContainer"
  "NVIDIA FrameView SDK Service"
) do (
  sc config %%s start= auto >nul 2>&1
  sc start %%s >nul 2>&1
)

echo All NVIDIA services have been re-enabled.
echo.
pause
goto menu

:show
cls
echo ------------------------------------------------------------
echo [ Currently running NVIDIA processes: ]
echo ------------------------------------------------------------
tasklist /fi "imagename eq NVIDIA*" /fo table
tasklist /fi "imagename eq Nv*" /fo table
echo ------------------------------------------------------------
pause
goto menu
