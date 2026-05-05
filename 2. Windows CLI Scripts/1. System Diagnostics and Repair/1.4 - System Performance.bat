@echo off
chcp 65001 >nul

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ==========================================================================================
echo #                                   SYSTEM PERFORMANCE                                  #
echo ==========================================================================================
echo.
echo.
echo ==========================================================================================
echo #  Checking System Uptime                                                                #
echo ==========================================================================================
echo.
echo Uptime may affect system performance and stability.
echo.
systeminfo | find "System Boot Time"

echo.
echo.
echo ==========================================================================================
echo #  Running Energy Efficiency Diagnostics                                                 #
echo ==========================================================================================
:: Enable power efficiency diagnostics
echo Running Energy Efficiency Diagnostics...
::Change to 60 after debugging
powercfg /energy /output "%USERPROFILE%\Desktop\energy-report.html" /duration 60
:: powercfg /energy /output "C:\Scripts\energy-report.html" /duration 60
:: powercfg /energy /output "%SystemRoot%\system32\energy-report.html" /duration 5
:: powercfg /energy /duration 5
echo.
echo.
echo ==========================================================================================
echo #  Viewing Scheduled Tasks                                                               #
echo ==========================================================================================
echo.
echo Saving scheduled tasks to file and displaying a summary in terminal...
echo.

echo.
schtasks /query /fo LIST > %USERPROFILE%\Desktop\ScheduledTasks.txt
echo List of scheduled tasks saved to %USERPROFILE%\Desktop\ScheduledTasks.txt
:: schtasks /query /fo LIST > C:\Scripts\ScheduledTasks.txt
:: echo List of scheduled tasks saved to C:\Scripts\ScheduledTasks.txt

schtasks /fo table
echo.

:: Done
echo.
echo ==========================================================================================
echo #                               SYSTEM PERFORMANCE COMPLETE                              #
echo ==========================================================================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
