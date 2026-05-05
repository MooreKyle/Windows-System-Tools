@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo  =======================================================
echo  #  Starting Wi-Fi and LAN Diagnostics                 #
echo  =======================================================
echo.

echo  =======================================================
echo  # Checking Available Wi-Fi Networks                   #
echo  =======================================================
netsh wlan show networks mode=bssid

:: Shows additional Wi-Fi LAN information
echo  =======================================================
echo  # Checking Wireless Adapter Info                      #
echo  =======================================================
netsh wlan show interfaces

echo  =======================================================
echo  # Checking Network Interface Status                   #
echo  =======================================================
netsh interface show interface

echo  =======================================================
echo  # Checking Wireless Drivers                           #
echo  =======================================================
netsh wlan show drivers

echo  =======================================================
echo  # Checking Saved Wi-Fi Profiles                       #
echo  =======================================================
netsh wlan show profiles

echo  =======================================================
echo  # Displaying Full IP Configuration Info               #
echo  =======================================================
ipconfig /all

echo  =======================================================
echo  # Viewing Routing Table Summary                       #
echo  =======================================================
netstat -rn

echo ========================================================
echo  # Printing Full Routing Table                         #
echo ========================================================
route print
timeout /t 3 >nul

echo.
echo  =======================================================
echo  #  Wi-Fi and LAN Diagnostics Complete                 #
echo  =======================================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
