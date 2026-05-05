@echo off
title Enable Task Scheduler Operational Log

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ===============================================================================
echo #                  Enable Task Scheduler Operational Log                      #
echo ===============================================================================
echo.

echo This will enable the Operational log for Task Scheduler.
echo It allows advanced task run history to be recorded and retrieved.
echo.
echo Required for features like:
echo   - Recently run scheduled tasks (last 24h)
echo   - Verbose diagnostics using Task Scheduler logs
echo.
echo This setting is safe to enable. It does not run any tasks or apps.
echo.

echo Enabling log...
wevtutil set-log Microsoft-Windows-TaskScheduler/Operational /enabled:true

echo.
echo Task Scheduler log has been enabled successfully.
echo Future scheduled task runs will now be logged in detail.
echo.

:CHOICE
echo ===============================================================================
echo Would you like to:
echo   [1] Leave the log enabled and exit the terminal
echo   [2] Disable the log
echo   [3] Exit the terminal without changes
echo ===============================================================================
set /p userChoice=Type 1, 2, or 3 and press Enter: 

if "%userChoice%"=="1" goto EXIT
if "%userChoice%"=="2" goto DISABLE
if "%userChoice%"=="3" goto EXIT

echo.
echo Invalid selection. Try again.
echo.
goto CHOICE

:DISABLE
echo.
echo Disabling Task Scheduler log...
wevtutil set-log Microsoft-Windows-TaskScheduler/Operational /enabled:false
echo Log disabled successfully.
goto EXIT

:EXIT
echo.
echo ===============================================================================
echo #                    Logging Feature Process Complete                         #
echo ===============================================================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
