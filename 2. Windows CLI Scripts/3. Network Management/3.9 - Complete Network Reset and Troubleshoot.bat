echo Script started. If you see this, it is running.
pause

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

@echo off
title Network Reset and Troubleshoot - Running...
cls

echo.
echo =======================================================
echo  #      Complete Network Reset and Troubleshoot       #
echo =======================================================
echo.
echo This script will perform a full network reset, run troubleshooting tests,
echo and attempt to restore full network functionality.
echo.
echo WARNING: This process may reset saved network configurations.
echo Press **CTRL+C** to cancel or any key to continue...
pause >nul

:: =========================================================
:: NETWORK TROUBLESHOOTING & DIAGNOSTICS
:: =========================================================
echo =======================================================
echo  # Checking Available Wi-Fi Networks                  #
echo =======================================================
netsh wlan show networks mode=bssid
timeout /t 3 >nul

echo =======================================================
echo  # Checking Wireless Adapter Info                     #
echo =======================================================
:: Unofficial Windows command over singular variant
	:: Should show all wireless (Wi-Fi) interfaces, but may be unreliable for automation in contrast.
netsh wlan show interfaces
::netsh wlan show interface
timeout /t 3 >nul

echo =======================================================
echo  # Checking Network Interface Status                  #
echo =======================================================
netsh interface show interface
timeout /t 3 >nul

echo =======================================================
echo  # Checking Wireless Drivers                          #
echo =======================================================
netsh wlan show drivers
timeout /t 3 >nul

echo =======================================================
echo  # Checking Saved Wi-Fi Profiles                      #
echo =======================================================
netsh wlan show profiles
timeout /t 3 >nul

echo =======================================================
echo  # Viewing Routing Table Summary                      #
echo =======================================================
netstat -rn
timeout /t 3 >nul

echo =======================================================
echo  # Displaying Full IP Configuration Info              #
echo =======================================================
ipconfig /all
timeout /t 3 >nul

echo =======================================================
echo  # Running Ping Test                                  #
echo =======================================================
ping duckduckgo.com
timeout /t 3 >nul

echo =======================================================
echo  # Running Traceroute                                 #
echo =======================================================
tracert duckduckgo.com
timeout /t 3 >nul

echo =======================================================
echo  # Viewing Active Connections and Open Ports          #
echo =======================================================
netstat -ano
timeout /t 3 >nul

echo =======================================================
echo  # Displaying Current Network Traffic                 #
echo =======================================================
netstat -e
timeout /t 3 >nul

echo =======================================================
echo  # Printing Full Routing Table                        #
echo =======================================================
route print
timeout /t 3 >nul

:: =========================================================
:: NETWORK RESETS & REPAIRS
:: =========================================================
echo =======================================================
echo  # Resetting Network Configuration                    #
echo =======================================================
netsh winhttp reset proxy
ipconfig /flushdns
ipconfig /release
ipconfig /renew
timeout /t 5 >nul

echo =======================================================
echo  # Performing Full Network Reset                      #
echo =======================================================
netsh int ip reset
netsh winsock reset
netsh advfirewall reset
timeout /t 5 >nul

echo =======================================================
echo  # Deleting All Saved Wi-Fi Profiles                  #
echo =======================================================
netsh wlan delete profile name=*
timeout /t 5 >nul

echo.
echo =======================================================
echo  #   Full Network Reset Done - Restart Recommended    #
echo =======================================================
echo.
echo Process complete. Do not close this window manually.
echo Press any key to exit, or type 'exit' and press Enter.
cmd /k
pause