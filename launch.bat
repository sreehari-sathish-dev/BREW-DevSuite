@echo off
setlocal enabledelayedexpansion
title BREW DevSuite - FOSS Edition

:: Universal compatibility header
if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    echo ARM64 architecture detected
    set POWERSHELL_CMD=pwsh
) else (
    set POWERSHELL_CMD=powershell
)

:: Secure launch with policy bypass
%POWERSHELL_CMD% -ExecutionPolicy Bypass -NoProfile -File "auth.ps1" -Mode Auth
if %errorlevel% neq 0 exit /b

:: Main menu
:MainLoop
cls
echo [1] Web Development Tools
echo [2] AI Assistant
echo [X] Exit
set /p choice=Select:
goto :Option_%choice%

:Option_1
start "" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"
goto :MainLoop

:Option_2
%POWERSHELL_CMD% -Command "& '%~dp0modules\ai-tools.ps1'"
goto :MainLoop

:Option_X
exit