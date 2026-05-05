@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ========================================
echo # Starting Basic Network Reset         #
echo ========================================
echo.
echo Resetting Network...
netsh winhttp reset proxy

echo ========================================
echo # Releasing and Renewing IP Address    #
echo ========================================
ipconfig /release
ipconfig /renew

echo ========================================
echo #  Flushing DNS Resolver Cache         #
echo ========================================
ipconfig /flushdns

echo ========================================
echo #  Renewing DHCP Lease                 #
echo ========================================
ipconfig /renew

echo ========================================
echo #  Releasing DHCP Lease                #
echo ========================================
ipconfig /release

echo ========================================
echo # Displaying Current IP Configuration  #
echo ========================================
ipconfig

echo.
echo ========================================
echo #  Network Reset Completed             #
echo ========================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
