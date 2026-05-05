@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ============================================
echo # Generating System Reports                #
echo ============================================
echo.

echo Generating Energy Efficiency Report...
::Change to 60 after debugging
powercfg /energy /output "%USERPROFILE%\Desktop\energy-report.html" /duration 60
:: powercfg /energy /output "C:\Scripts\energy-report.html" /duration 60
:: powercfg /energy /output "%SystemRoot%\system32\energy-report.html" /duration 5
:: powercfg /energy /duration 5

echo Generating Sleep Study Report...
powercfg /sleepstudy /output "%USERPROFILE%\Desktop\sleepstudy.html"
echo.

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
echo # System Reports Complete                  #
echo ============================================
echo.
pause
