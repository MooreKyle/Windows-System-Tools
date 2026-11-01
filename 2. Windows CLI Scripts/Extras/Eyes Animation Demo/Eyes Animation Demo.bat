@echo off
setlocal
title ...?
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.
echo.
echo ============================================
echo #           EYES ANIMATION DEMO            #
echo ============================================
echo.
REM The Shadow will yield only to one with the eye of truth...
echo Press any key to begin, or wait 5 seconds.
timeout /t 5 >nul
cls
if not exist "%~dp0Eyes Animation Engine.ps1" (
    echo Missing Eyes Animation Engine.ps1 in the same folder.
    pause
    exit /b 1
)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Eyes Animation Engine.ps1" -EyeCount 20 -PupilMode Combined -FastBlinkPercent 22
cls
echo.
echo Eyes Animation Demo ended.
echo.
endlocal
