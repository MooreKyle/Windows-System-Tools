@echo off
title Cancel Pending Repairs and Maintenance Tasks
cls
echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo =============================================================================== 
echo #             Cancel Pending Repairs and Maintenance Tasks                    #
echo =============================================================================== 
echo.

echo This script removes flags or commands that would run system repairs
echo or maintenance actions the next time your PC restarts.
echo.
echo It cancels things like:
echo   - Maintenance tasks added by recovery systems or tools
echo   - Some automatic diagnostic sessions
echo   - Scheduled shutdowns or restarts
echo.
echo The script first cancels any scheduled PC shutdown/restart for ease of access.
echo.
echo NOTE: This is safe to use. It does NOT cancel real-time active scans.
echo       It only removes what's pending for your next reboot.
echo.
echo NOTE: If you know your PC is in the middle of installing updates
echo       or running repairs, wait until that's done before using this script.
echo.
echo ===============================================================================

echo.
echo.
echo Cancelling any existing scheduled PC shutdown/restart...

:: Test to schedule and cancel a shutdown
::shutdown /s /t 86400

:: Cancel scheduled PC shutdown/restart - If end-of-script shutdown is not reached
shutdown /a >nul 2>&1
if %errorlevel%==0 (
    echo      - A scheduled shutdown/restart was active and has been cancelled.
) else (
    echo      - No shutdown or restart was scheduled.
)

del "%temp%\shutdown_status.txt" >nul 2>&1
echo.
echo.

echo The script will now perform safety checks and cancel any scheduled tasks.
echo.
echo Press **CTRL+C** to cancel or any key to continue...
pause >nul

:: Set fake flags for testing display of specific flags.
::echo.
::echo.
::echo ------------------------------Set fake flags-----------------------------------
:: Set fake flags
::echo dummy > %windir%\WinSxS\Pending.xml
::shutdown /s /t 86400
::fsutil dirty set C:
::echo -------------------------------------------------------------------------------

:: Precheck – Block execution if system is actively updating or transferring files
set "blockScript=0"
set "activeFlags="

echo.
echo.
echo ===============================================================================
echo #                       Pre-Execution Safety Checks                           #
echo =============================================================================== 
echo.

:: SAFETY CHECKS — Prevent running if sensitive operations are active
:: Pre-check safety
echo Performing safety pre-checks to prevent interference with active updates...
echo.

:: Check for Windows Update processes
tasklist | findstr /i "TiWorker.exe TrustedInstaller.exe" >nul
if %errorlevel%==0 (
    echo [!] Windows Update process is running: TiWorker.exe or TrustedInstaller.exe
    set "blockScript=1"
    set "activeFlags=%activeFlags% Windows Update"
)

:: Check for BITS network activity
echo Checking for Background Intelligent Transfer Service (BITS) traffic...
netstat -b | findstr /i "bits" >nul
if %errorlevel%==0 (
    echo [!] BITS is currently transferring data
    set "blockScript=1"
    set "activeFlags=%activeFlags% BITS"
)

if "%blockScript%"=="1" (
    echo.
    echo One or more system tasks are actively running:
    echo   →%activeFlags%
    echo.
    echo Script execution has been halted to avoid disruption.
    echo.
    pause
    exit /b
)

echo All clear. Proceeding with cancellation steps...
echo.

:: Cancel any pending CHKDSK
chkntfs /x C: >nul

:: Cancel scheduled shutdowns or restarts
shutdown /a >nul 2>&1

:: Simulate deletion of Pending.xml for testing purposes
echo Simulating deletion of Pending.xml (test only - no real file is touched)...
if exist "%windir%\WinSxS\Pending.xml" (
    echo Would delete: %windir%\WinSxS\Pending.xml
) else (
    echo [OK] No Pending.xml file found.
)

::echo.
::echo.
::echo -------------------------------Unset fake flags--------------------------------
:: Unset fake flags
::del %windir%\WinSxS\Pending.xml
::shutdown /a
::chkdsk C: /f /scan
::echo -------------------------------------------------------------------------------

echo.
echo.
echo All non-registry pending tasks (repairs, shutdowns/restarts, CHKDSK) have been cancelled.
echo.
echo =============================================================================== 
echo #                      Cancellation Process Complete                          #
echo =============================================================================== 
echo.
echo Pressing any key will exit the terminal.
echo.
pause
