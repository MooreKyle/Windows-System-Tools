@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ============================================
echo #    FULL SYSTEM DIAGNOSTICS AND REPAIR    #
echo ============================================
echo.

echo ============================================
echo #            System Performance            #
echo ============================================
echo.

echo Uptime may affect system performance and stability.
echo.
systeminfo | find "System Boot Time"

echo Running Energy Efficiency Diagnostics...
::Change to 60 after debugging
powercfg /energy /output "%USERPROFILE%\Desktop\energy-report.html" /duration 60
:: powercfg /energy /output "C:\Scripts\energy-report.html" /duration 60
:: powercfg /energy /output "%SystemRoot%\system32\energy-report.html" /duration 5
:: powercfg /energy /duration 5

echo.
echo Saving scheduled tasks to file and displaying a summary in terminal...
echo.
::echo Viewing Scheduled Tasks...
::schtasks

echo.
schtasks /query /fo LIST > %USERPROFILE%\Desktop\ScheduledTasks.txt
echo List of scheduled tasks saved to %USERPROFILE%\Desktop\ScheduledTasks.txt
:: schtasks /query /fo LIST > C:\Scripts\ScheduledTasks.txt
:: echo List of scheduled tasks saved to C:\Scripts\ScheduledTasks.txt

schtasks /fo table
echo.

echo.
echo ============================================
echo #        System Performance Complete       #
echo ============================================
echo.

echo.
echo ============================================
echo #              System Reports              #
echo ============================================
echo.

echo Generating Sleep Study Report...
powercfg /sleepstudy /output "%USERPROFILE%\Desktop\sleepstudy.html"

echo Generating Battery Report (For Laptops)...
powercfg /batteryreport /output "%USERPROFILE%\Desktop\battery-report.html"

echo Generating Disk Usage Report...
wmic logicaldisk get deviceid, volumename, description, filesystem, size, freespace

echo Opening Windows Reliability Monitor...
perfmon /rel

echo Retrieving Last 10 System Event Logs...
wevtutil qe System /c:10 /f:text

echo.
echo ============================================
echo #         System Reports Complete          #
echo ============================================
echo.

echo.
echo ============================================
echo #         System Health and Repair         #
echo ============================================
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

::echo Checking File System Status...
::echo Checking if system is a laptop...
::wmic computersystem get pcSystemType > temp.txt
::findstr /C:"2" temp.txt >nul
::if %errorlevel% neq 0 (
  ::echo This command is for laptops only. Skipping...
::) else (
  ::fsutil dirty query C:
::)

echo.
echo ============================================
echo #       System Health Check Complete       #
echo ============================================
echo.

echo.
echo ============================================
echo #   Full System Diagnostics Complete       #
echo ============================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
