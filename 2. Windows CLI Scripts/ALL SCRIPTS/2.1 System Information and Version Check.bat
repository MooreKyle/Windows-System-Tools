@echo off
chcp 65001
cls
echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ==========================================================================================
echo #                             DISPLAYING SYSTEM INFORMATION                              #
echo ==========================================================================================
echo.

echo.
echo ==========================================================================================
echo #  Checking Windows Version                                                              #
echo ==========================================================================================
echo.
start "" winver
echo.
echo                          ----------------------------------------
echo                          :      CPU Information (Detailed)      :
echo                          ----------------------------------------
echo.
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors
wmic path win32_VideoController get name,adapterram
start "" dxdiag

echo.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"Original Install Date" /C:"System Manufacturer" /C:"System Model" /C:"System Type" /C:"BIOS Version" /C:"Processor(s)" /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"Windows Directory"

echo.
echo View the 'About Windows' popup for additional information.
echo.
echo.
echo ==========================================================================================
echo #  Checking System Uptime                                                                #
echo ==========================================================================================
echo.
systeminfo | find "System Boot Time"

echo.
echo.
echo ==========================================================================================
echo #  Listing Loaded Drivers                                                                #
echo ==========================================================================================
echo.
echo Saving driver list to file and displaying a summary in terminal...
echo.

:: Save full driver list to file in wide table format for clarity
driverquery /fo table /v > "%USERPROFILE%\Desktop\LoadedDrivers.txt"
:: driverquery /fo table /v > "C:\Scripts\LoadedDrivers.txt"

:: Display just the basic summary in terminal for clarity
driverquery /fo table

echo.
echo.
echo Full driver list saved to %USERPROFILE%\Desktop\LoadedDrivers.txt
::echo Full driver list saved to C:\Scripts\LoadedDrivers.txt

echo.
echo.
echo ==========================================================================================
echo #  Displaying Installed Programs List                                                    #
echo ==========================================================================================
::wmic product get name,version > C:\Scripts\ProgramsRaw.txt
::(
    ::echo NOTE: This list may not include all installed programs. Some entries may be missing or incomplete.
    ::echo.
	::echo.
    ::type C:\Scripts\ProgramsRaw.txt
::) > C:\Scripts\InstalledPrograms.txt
::del C:\Scripts\ProgramsRaw.txt
::echo.
::echo Installed programs saved to C:\Scripts\InstalledPrograms.txt

wmic product get name,version > "%USERPROFILE%\Desktop\ProgramsRaw.txt"
(
    echo NOTE: This list may not include all installed programs. Some entries may be missing or incomplete.
    echo.
    echo.
    type "%USERPROFILE%\Desktop\ProgramsRaw.txt"
) > "%USERPROFILE%\Desktop\InstalledPrograms.txt"
del "%USERPROFILE%\Desktop\ProgramsRaw.txt"
echo.
echo Installed programs saved to %USERPROFILE%\Desktop\InstalledPrograms.txt

powercfg /energy /output "%USERPROFILE%\Desktop\energy-report.html" /duration 60

echo.
echo.
echo ==========================================================================================
echo #                           SYSTEM INFORMATION CHECK COMPLETE                            #
echo ==========================================================================================
echo.
echo Pressing any key will exit the terminal.
echo.
pause