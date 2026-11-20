@echo off
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ====================================
echo #     System Health and Repair     #
echo ====================================
echo.

echo Checking System Image Health with DISM...
dism /online /cleanup-image /checkhealth
echo Results have been logged to:
echo     - C:\Windows\Logs\CBS\CBS.log
echo     - C:\Windows\Logs\DISM\dism.log

echo.
echo Checking and repairing system image with DISM if needed (this may take several minutes)...
echo     - Internet access may be needed to complete repairs.
dism /online /cleanup-image /restorehealth
echo Results have been logged to:
echo     - C:\Windows\Logs\DISM\dism.log

echo.
echo Running System File Checker...
sfc /scannow
echo Results have been logged to:
echo     - C:\Windows\Logs\CBS\CBS.log

:: ---------- CHKDSK Selection Menu ----------

echo.
echo CHKDSK Options:
echo [1] Standard repair scan - chkdsk %SystemDrive% /f
echo     Recommended for most users. Fixes file system errors.
echo.
echo [2] Deep bad-sector scan - chkdsk %SystemDrive% /r
echo     Includes /f, but can take much longer. Use if drive problems are suspected.
echo.
echo [3] Skip CHKDSK
echo.

:: Only 1, 2, or 3 can be selected. No need to press Enter.
choice /c 123 /n /m "Choose an option [1-3]: "
set "chkdskChoice=%errorlevel%"

:: Stop this section if the menu was interrupted or failed.
if %chkdskChoice% LSS 1 goto CHKDSK_MENU_ERROR
if %chkdskChoice% GTR 3 goto CHKDSK_MENU_ERROR

:: Keep track of whether the user chose a CHKDSK scan.
set "showChkdskLogs="

if "%chkdskChoice%"=="1" (
    echo.
    echo Running standard CHKDSK repair scan on %SystemDrive%...
    chkdsk %SystemDrive% /f
    set "showChkdskLogs=1"
) else if "%chkdskChoice%"=="2" (
    echo.
    echo Running deep CHKDSK bad-sector scan on %SystemDrive%...
    echo Note: /r includes /f, so the standard repair scan will not run separately.
    chkdsk %SystemDrive% /r
    set "showChkdskLogs=1"
) else (
    echo.
    echo Skipping CHKDSK.
)

:: Show the Event Viewer instructions only when a CHKDSK scan is selected.
:: The ^ symbols allow CMD to display (GUI) correctly inside the IF block.
if defined showChkdskLogs (
    echo If CHKDSK runs at the next startup, its results can be found here:
    echo      - Event Viewer ^(GUI^) ^> Windows Logs ^> Application
    echo      - Look for 'Source: Wininit' with 'Event ID: 1001'
)

goto CHKDSK_MENU_DONE

:CHKDSK_MENU_ERROR
echo.
echo CHKDSK selection was interrupted or could not be completed.
echo No CHKDSK scan was started by this menu.

:CHKDSK_MENU_DONE

:: ---------- End of CHKDSK Selection Menu ----------

echo.
echo Checking File System Status...
echo Checking if drive %SystemDrive% has file system issues (Dirty Bit)...
fsutil dirty query %SystemDrive%

echo.
echo.
echo ====================================
echo #     System Repair Complete       #
echo ====================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause
