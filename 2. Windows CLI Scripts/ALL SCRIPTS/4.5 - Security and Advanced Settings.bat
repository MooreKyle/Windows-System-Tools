@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ============================================
echo # Opening Security and Advanced Settings     #
echo ============================================
echo.

:: Opens GUI Windows security and advanced applications settings
echo Opening Windows Security Center...
start windowsdefender:

echo Opening Advanced System Settings...
SystemPropertiesAdvanced

echo Opening User Account Management...
netplwiz

echo Opening Certificate Store...
certutil -store My

echo Opening Environment Variable Editor...
rundll32 sysdm.cpl,EditEnvironmentVariables

echo ============================================
echo # All Windows Settings Opened              #
echo ============================================
pause
