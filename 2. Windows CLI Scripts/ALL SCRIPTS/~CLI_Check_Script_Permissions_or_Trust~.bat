@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Not running as administrator. Please right-click the script and select "Run as administrator".
	echo.
	echo.
	echo Press any key to exit the terminal.
	echo.
    pause
    exit /b
)

:: Confirm to user they successfully ran script as administrator
echo [OK] Running as administrator.
echo.

:: Notify user if script was run as administrator
echo Testing if CLI scripts will execute properly...
echo.

:: Log output both to terminal and to log file
set "logline=[OK] Script ran successfully at %date% %time%"
echo %logline%
echo %logline% >> "%~dp0script_debug_log.txt"
:: Notify user of where log was saved
echo [OK] script_debug_log.txt saved to "%~dp0script_debug_log.txt"

echo.
echo.
:: Prompt user to press any key to safely exit the terminal
echo Press any key to exit the terminal.
echo.
pause
