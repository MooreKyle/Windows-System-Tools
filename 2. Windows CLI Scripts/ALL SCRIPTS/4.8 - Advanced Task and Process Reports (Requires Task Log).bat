@echo off
cls
chcp 65001 >nul
echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo =============================================================
echo #            Advanced Task and Process Reports              #
echo =============================================================
echo.
echo This script generates detailed system-level diagnostics
echo and reporting for advanced users. It covers:
echo.
echo   - Scheduled Task Details (Verbose Mode)
echo   - Active Services and Their States
echo   - Currently Running Processes (with memory usage)
echo   - Startup Programs Auto-Launching on Boot
echo   - Recently Run Scheduled Tasks (from last 24h)
echo.
echo Useful for:
echo   - Power users and system admins
echo   - Deep troubleshooting or auditing
echo   - Understanding background activity and startup impact
echo.
echo Output files are saved to your Desktop.
echo.
echo =============================================================
echo.

:: Save full scheduled task info (Verbose)
echo Generating full scheduled task report (verbose)...
schtasks /query /fo LIST /v > "%USERPROFILE%\Desktop\ScheduledTasks_Verbose.txt"
echo Verbose scheduled tasks report saved to %USERPROFILE%\Desktop\ScheduledTasks_Verbose.txt

echo.
:: Display active services list
echo Generating active services list...
sc queryex type= service state= all > "%USERPROFILE%\Desktop\ActiveServices.txt"
echo Active services list saved to %USERPROFILE%\Desktop\ActiveServices.txt

echo.
:: Show running processes with memory usage
echo Generating running processes report...
tasklist /v > "%USERPROFILE%\Desktop\RunningProcesses.txt"
echo Running processes report saved to %USERPROFILE%\Desktop\RunningProcesses.txt

echo.
:: Export all startup items
echo Generating startup programs list...
wmic startup get Caption,Command,User > "%USERPROFILE%\Desktop\StartupPrograms.txt"
echo Startup programs list saved to %USERPROFILE%\Desktop\StartupPrograms.txt

echo.
:: View recently run scheduled tasks (last 24h)
echo Checking for recently run scheduled tasks...
wevtutil qe Microsoft-Windows-TaskScheduler/Operational /q:"*[System[(EventID=200 or EventID=201) and TimeCreated[timediff(@SystemTime) <= 86400000]]]" /f:text > "%USERPROFILE%\Desktop\RecentScheduledTaskRuns.txt"
echo Recent task runs saved to %USERPROFILE%\Desktop\RecentScheduledTaskRuns.txt

echo.
echo =============================================================
echo #       Advanced Task and Process Reporting Complete        #
echo =============================================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause