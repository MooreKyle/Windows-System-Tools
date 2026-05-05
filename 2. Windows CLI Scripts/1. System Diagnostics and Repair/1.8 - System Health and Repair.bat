@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.
:: Consider rearranging all commands here later.
echo.
echo ====================================
echo #     System Health and Repair     #
echo ====================================
echo.

echo Running System File Checker...
sfc /scannow
echo Results have been logged to:
echo     - C:\Windows\Logs\CBS\CBS.log

echo Checking System Image Health with DISM...
dism /online /cleanup-image /checkhealth
echo Results have been logged to:
echo     - C:\Windows\Logs\CBS\CBS.log
echo     - C:\Windows\Logs\DISM\dism.log

echo.
echo Checking and repairing system image with DISM if needed (this may take several minutes)...
echo Connecting to the Internet...
dism /online /cleanup-image /restorehealth
echo Results have been logged to:
echo     - C:\Windows\Logs\DISM\dism.log

echo Checking Disk for Errors...
chkdsk /f
echo If the scan runs at next boot, results will be logged to:
echo      - Event Viewer (GUI) ^> Windows Logs ^> Application
echo      - Look for 'Source: Wininit' with 'Event ID: 1001'

echo Checking Disk for Bad Sectors...
chkdsk /r
echo If the scan runs at next boot, results will be logged to:
echo      - Event Viewer (GUI) ^> Windows Logs ^> Application
echo      - Look for 'Source: Wininit' with 'Event ID: 1001'

echo Checking File System Status...
echo Checking if drive C: has file system issues (Dirty Bit)...
fsutil dirty query C:

echo.
echo.
echo ====================================
echo #     System Repair Complete       #
echo ====================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
