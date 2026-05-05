@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo  ======================================================
echo  #     Starting Advanced Network Troubleshooting      #
echo  ======================================================
echo.
echo Resetting Network...
netsh winhttp reset proxy

echo  ======================================================
echo  # Releasing and Renewing IP Address                  #
echo  ======================================================
ipconfig /release
ipconfig /renew

echo  ======================================================
echo  #  Flushing DNS Resolver Cache                       #
echo  ======================================================
ipconfig /flushdns

echo  ======================================================
echo  #  Renewing DHCP Lease                               #
echo  ======================================================
ipconfig /renew

echo  ======================================================
echo  #  Releasing DHCP Lease                              #
echo  ======================================================
ipconfig /release

echo  ======================================================
echo  # Displaying Full IP Configuration Info              #
echo  ======================================================
ipconfig /all

:: Additional tests beyond 'Basic Network Reset'
echo  ======================================================
echo  # Running Ping Test                                  #
echo  ======================================================
ping duckduckgo.com

echo  ======================================================
echo  # Running Traceroute                                 #
echo  ======================================================
tracert duckduckgo.com

echo  ======================================================
echo  # Viewing Active Wireless Networks                   #
echo  ======================================================
netsh wlan show networks mode=bssid

echo =======================================================
echo  # Checking Wireless Adapter Info                     #
echo =======================================================
:: Unofficial Windows command over singular variant
	:: Should show all wireless (Wi-Fi) interfaces, but may be unreliable for automation in contrast.
netsh wlan show interfaces
::netsh wlan show interface
timeout /t 3 >nul

echo  ======================================================
echo  # Checking Network Interface Status                  #
echo  ======================================================
netsh interface show interface

echo  ======================================================
echo  # Viewing Active Connections and Open Ports          #
echo  ======================================================
netstat -ano

echo  ======================================================
echo  # Displaying Current Network Traffic                 #
echo  ======================================================
netstat -e

echo  ======================================================
echo  # Viewing Routing Table Summary                      #
echo  ======================================================
netstat -rn

echo  ======================================================
echo  # Printing Full Routing Table                        #
echo  ======================================================
route print

echo.
echo  ======================================================
echo  #     Advanced Network Troubleshooting Complete      #
echo  ======================================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
