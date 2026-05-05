@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo  ===============================================
echo  #  Starting Full Network Reset and Fix        #
echo  ===============================================
echo.

echo  ===============================================
echo  # Resetting Network Configuration             #
echo  ===============================================
netsh int ip reset
netsh winsock reset
netsh advfirewall reset

echo  ===============================================
echo  # Clearing Saved Wi-Fi Profiles               #
echo  ===============================================
netsh wlan delete profile name=*

echo  ===============================================
echo  # Flushing DNS Cache                          #
echo  ===============================================
ipconfig /flushdns

echo  ===============================================
echo  # Releasing and Renewing IP Address           #
echo  ===============================================
ipconfig /release
ipconfig /renew

echo.
echo  ===============================================
echo  #  Full Reset Complete - Restart Recommended  #
echo  ===============================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
