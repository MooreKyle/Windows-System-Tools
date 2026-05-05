@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ============================================
echo # Resetting Windows Update Components      #
echo ============================================
echo.

:: Stops Windows Update-related services
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver

ren C:\WindowsSoftwareDistribution SoftwareDistribution.old
ren C:\WindowsSystem32catroot2 catroot2.old

:: Starts Windows Update-related services
net start wuauserv
net start cryptSvc
net start bits
net start msiserver

echo.
echo ============================================
echo # Windows Update Components Reset Complete #
echo ============================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
