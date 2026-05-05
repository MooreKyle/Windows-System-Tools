@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.
:: Clears print jobs, prepares disk cleanup, and restarts Windows Explorer
echo.
echo ======================================
echo #  System Cleanup and Maintenance    #
echo ======================================
echo.

echo Clearing Printer Queue...
net stop spooler
del /Q /F /S %systemroot%\System32\spool\PRINTERS\*.*
net start spooler

echo Opening Disk Cleanup for (C:)...
cleanmgr /d C:
::cleanmgr /sageset:1

echo Restarting Windows Explorer...
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo ======================================
echo #  Cleanup and Maintenance Complete  #
echo ======================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
