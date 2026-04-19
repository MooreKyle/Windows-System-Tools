@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ===============================================================================
:: Windows System Tools - Updater
:: Checks GitHub for updates and refreshes the installed project copy when needed.
:: Uses a full refresh approach with backup and restore protection.
:: ===============================================================================

:: -------------------------------------------------------------------------------
:: CONFIGURATION
:: -------------------------------------------------------------------------------
:: GitHub repository details used to check for updates and download the project.
set "REPO_OWNER=MooreKyle"
set "REPO_NAME=Windows-System-Tools"
set "REPO_BRANCH=main"

:: -------------------------------------------------------------------------------
:: INSTALL LOCATION
:: -------------------------------------------------------------------------------
:: Default install location for the project on this PC.
set "INSTALL_ROOT=C:\Scripts"
set "INSTALL_DIR=%INSTALL_ROOT%\Windows-System-Tools"


:: -------------------------------------------------------------------------------
:: OPTIONAL: PORTABLE / USB-BASED INSTALL LOCATION
:: -------------------------------------------------------------------------------
:: Advanced option.
:: Uncomment the two lines below, and comment out the default install location
:: above, to install the project to the same drive the updater is being run from.
::
:: Example:
:: If the updater is run from drive E:, the project will install to:
::     E:\Scripts\Windows-System-Tools
::
::set "INSTALL_ROOT=%~d0\Scripts"
::set "INSTALL_DIR=%INSTALL_ROOT%\Windows-System-Tools"


:: Updater settings file (.ini) kept outside the installed project folder.
set "STATE_FILE=%INSTALL_ROOT%\Windows-System-Tools-Updater.ini"

:: Temporary working paths used while downloading, extracting, and preparing files.
set "TEMP_ROOT=%TEMP%\WST_Updater"
set "DOWNLOAD_ZIP=%TEMP_ROOT%\repo.zip"
set "EXTRACT_DIR=%TEMP_ROOT%\extract"
set "STAGING_DIR=%TEMP_ROOT%\staging"
set "REMOTE_JSON=%TEMP_ROOT%\branch.json"

:: GitHub addresses used to check the latest commit and download the project ZIP.
set "API_BRANCH_URL=https://api.github.com/repos/%REPO_OWNER%/%REPO_NAME%/branches/%REPO_BRANCH%"
set "ZIP_URL=https://github.com/%REPO_OWNER%/%REPO_NAME%/archive/refs/heads/%REPO_BRANCH%.zip"

:: Expected main folder name inside the downloaded GitHub ZIP.
set "ZIP_FOLDER_NAME=%REPO_NAME%-%REPO_BRANCH%"

:: Temporary backup folder used while replacing the current installed copy.
set "BACKUP_NAME=Windows-System-Tools__OLD"
set "BACKUP_DIR=%INSTALL_ROOT%\%BACKUP_NAME%"

:: Keep the backup folder after a successful update? 0 = no, 1 = yes.
set "KEEP_BACKUP=0"

:: -------------------------------------------------------------------------------
:: RUNTIME STATE
:: -------------------------------------------------------------------------------
:: Values loaded or detected while the updater is running.
set "REMOTE_COMMIT="
set "LOCAL_COMMIT="
set "LOCAL_BRANCH="
set "LOCAL_INSTALL_STATE="

:: Basic checks for whether the installed project and updater settings file exist.
set "INSTALL_PRESENT=0"
set "STATE_PRESENT=0"

:: Main decision flags used to determine what the updater should do.
set "FIRST_INSTALL=0"
set "FORCE_REINSTALL=0"
set "NEEDS_UPDATE=0"
set "REPAIR_MODE=0"

:: Checks for important root files used to confirm the installed project looks complete.
set "CHECK_README=0"
set "CHECK_LICENSE=0"
set "CHECK_CHANGELOG=0"

:: ===============================================================================
:: STARTUP
:: ===============================================================================

:: -------------------------------------------------------------------------------
:: WINDOW TITLE
:: -------------------------------------------------------------------------------
title Windows System Tools - Updater

::---------------------------------------------------------------------------------------------
:: SPLASH / INTRODUCTION SCREEN
::---------------------------------------------------------------------------------------------
cls
echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.
echo.
echo ==========================================================================================
echo #                             WINDOWS SYSTEM TOOLS - UPDATER                             #
echo ==========================================================================================
echo.
echo This updater checks GitHub for the latest version of the project and updates
echo the installed project copy when needed.
echo.
echo If an update or repair is needed, the updater replaces the current project
echo folder contents with a fresh copy.
echo.
echo Project install folder:
echo     %INSTALL_DIR%
echo.
echo WARNING: Do not store personal files inside that folder.
echo The updater may replace its contents during an update or repair.
echo.
echo Press CTRL+C to cancel, or press any key to continue...
pause >nul
::---------------------------------------------------------------------------------------------
:: END OF SPLASH / INTRODUCTION SCREEN
::---------------------------------------------------------------------------------------------

:: -------------------------------------------------------------------------------
:: STARTUP / UPDATER INFORMATION
:: -------------------------------------------------------------------------------
cls

echo.
echo                                                                   Copyright (c) Kyle Moore
echo                                                                       GitHub.com/MooreKyle
echo.

echo.
echo ==========================================================================================
echo #                             WINDOWS SYSTEM TOOLS - UPDATER                             #
echo ==========================================================================================
echo.

echo Repository:
echo     %REPO_OWNER%/%REPO_NAME%
echo Branch:
echo     %REPO_BRANCH%
echo Project install folder:
echo     %INSTALL_DIR%
echo Updater settings file:
echo     %STATE_FILE%
::echo Updater script path:
::echo     %~f0
echo.

::timeout /t 30 /nobreak

::Run early checks and gather current project / update information.
call :CheckPowerShell
if errorlevel 1 goto :FAIL

call :EnsureExternalUpdaterLocation
if errorlevel 1 goto :FAIL

call :EnsureInstallRoot
if errorlevel 1 goto :FAIL

call :PrepareTemp
if errorlevel 1 goto :FAIL

call :InspectLocalInstall
if errorlevel 1 goto :FAIL

call :GetRemoteCommit
if errorlevel 1 goto :FAIL

echo ====================== Current Status ======================
echo.
echo Latest remote commit:
echo     %REMOTE_COMMIT%
echo.

call :DecideAction
if errorlevel 1 goto :FAIL

:: Safety check for contradictory updater action flags.
set /a ACTION_COUNT=0
if "%FIRST_INSTALL%"=="1" set /a ACTION_COUNT+=1
if "%REPAIR_MODE%"=="1" set /a ACTION_COUNT+=1
if "%NEEDS_UPDATE%"=="1" set /a ACTION_COUNT+=1

if %ACTION_COUNT% GTR 1 goto :UNEXPECTED_STATE

if "%FIRST_INSTALL%"=="1" (
    echo Status:
    echo     First-time install detected.
    echo.
) else if "%REPAIR_MODE%"=="1" (
    echo Status:
    echo     The installed project looks incomplete, missing, or previously interrupted.
    echo     A full repair reinstall will be performed.
    echo.
) else if "%NEEDS_UPDATE%"=="1" (
    echo Status:
    echo     An update is available.
    echo.
) else (
    echo Status:
    echo     No update required.
    echo.
    goto :SUCCESS_NO_UPDATE
)

echo ==================== Update in Progress ====================
echo.
echo Recording updater status as Updating...
call :WriteStateOnly "Updating"
if errorlevel 1 goto :FAIL

echo Downloading the latest project files...
call :DownloadZip
if errorlevel 1 goto :DOWNLOAD_OR_PREP_FAIL

echo Extracting the downloaded project files...
call :ExtractZip
if errorlevel 1 goto :DOWNLOAD_OR_PREP_FAIL

echo Checking the extracted project files...
call :ValidateExtractedProject
if errorlevel 1 goto :DOWNLOAD_OR_PREP_FAIL

echo Preparing the updated project files...
call :PrepareStaging
if errorlevel 1 goto :DOWNLOAD_OR_PREP_FAIL

echo Replacing the current installed project copy...
call :ReplaceInstall
if errorlevel 1 goto :REPLACE_FAIL

echo Saving final updater details...
call :WriteFullIni "Healthy"
if errorlevel 1 goto :POST_INSTALL_FAIL

echo.
echo.
echo ==========================================================================================
echo #                                    UPDATE COMPLETE                                     #
echo ==========================================================================================
echo.
echo Project install folder updated successfully:
echo     %INSTALL_DIR%
goto :END

:: ===============================================================================
:: FUNCTIONS / MAIN LOGIC
:: ===============================================================================

:: -------------------------------------------------------------------------------
:: STARTUP CHECKS / BASIC SETUP
:: -------------------------------------------------------------------------------
:CheckPowerShell
:: Makes sure PowerShell can be started before the updater uses it.
powershell -NoProfile -Command "exit 0" >nul 2>&1
if errorlevel 1 (
    echo ERROR: PowerShell is required for this updater to download and extract files.
    echo ERROR: It could not be found or started on this system.
    exit /b 1
)
exit /b 0

:EnsureExternalUpdaterLocation
:: Prevents the updater from being run from inside the installed project folder
:: or any folder inside it.
set "SCRIPT_DIR=%~dp0"
if /I "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

set "SCRIPT_DIR_WITH_SLASH=%SCRIPT_DIR%\"
set "INSTALL_DIR_WITH_SLASH=%INSTALL_DIR%\"

echo;%SCRIPT_DIR_WITH_SLASH% | findstr /I /B /C:"%INSTALL_DIR_WITH_SLASH%" >nul
if not errorlevel 1 (
    echo ERROR: This updater script is being run from inside the installed project folder.
    echo.
    echo To avoid interfering with the installed project during an update, the updater must stay outside:
    echo     %INSTALL_DIR%
    echo.
    echo Recommended location for normal use:
	echo     %INSTALL_ROOT%\Update-Windows-System-Tools.bat
    exit /b 1
)

exit /b 0

:EnsureInstallRoot
:: Creates the main install root folder if it does not already exist.
if not exist "%INSTALL_ROOT%" (
    echo Creating install root folder...
    mkdir "%INSTALL_ROOT%" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Could not create:
        echo     %INSTALL_ROOT%
        exit /b 1
    )
)
exit /b 0

:: -------------------------------------------------------------------------------
:: TEMPORARY WORKSPACE / LOCAL INSTALL CHECKS
:: -------------------------------------------------------------------------------
:PrepareTemp
:: Clears and recreates the temporary working folder used by the updater.
if exist "%TEMP_ROOT%" (
    rmdir /s /q "%TEMP_ROOT%" >nul 2>&1
)

mkdir "%TEMP_ROOT%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not prepare the updater's temporary working folder:
    echo     %TEMP_ROOT%
    exit /b 1
)

mkdir "%EXTRACT_DIR%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not create the temporary extract folder.
    exit /b 1
)

mkdir "%STAGING_DIR%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not create the temporary preparation folder.
    exit /b 1
)

exit /b 0

:InspectLocalInstall
:: Checks whether the installed project and updater settings file currently exist.
if exist "%INSTALL_DIR%" set "INSTALL_PRESENT=1"
if exist "%STATE_FILE%" set "STATE_PRESENT=1"

:: Checks for important root files to confirm the installed project looks complete.
if exist "%INSTALL_DIR%\README.md" set "CHECK_README=1"
if exist "%INSTALL_DIR%\LICENSE" set "CHECK_LICENSE=1"
if exist "%INSTALL_DIR%\CHANGELOG.md" set "CHECK_CHANGELOG=1"

:: Loads saved updater details if the external .ini file is present.
if "%STATE_PRESENT%"=="1" (
    call :ReadIni "%STATE_FILE%"
)

exit /b 0

:ReadIni
:: Reads saved updater details from the external .ini settings file.
for /f "usebackq tokens=1,* delims==" %%A in ("%~1") do (
    if /I "%%A"=="Branch" set "LOCAL_BRANCH=%%B"
    if /I "%%A"=="LastInstalledCommit" set "LOCAL_COMMIT=%%B"
    if /I "%%A"=="InstallState" set "LOCAL_INSTALL_STATE=%%B"
)
exit /b 0

:: -------------------------------------------------------------------------------
:: REMOTE REPOSITORY CHECKS / UPDATE DECISION LOGIC
:: -------------------------------------------------------------------------------
:GetRemoteCommit
:: Downloads the current branch details and reads the latest commit ID.
if exist "%REMOTE_JSON%" del /f /q "%REMOTE_JSON%" >nul 2>&1


:: PowerShell download mode:
:: Default behavior hides the PowerShell progress display because visible progress
:: output can cause the updater's console layout to redraw incorrectly after resizing.
:: To restore visible PowerShell progress, comment out the active command block
:: below and uncomment the optional command block under it.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ProgressPreference='SilentlyContinue'; try { Invoke-WebRequest -UseBasicParsing '%API_BRANCH_URL%' -OutFile '%REMOTE_JSON%' -ErrorAction Stop; exit 0 } catch { exit 1 }"

::powershell -NoProfile -ExecutionPolicy Bypass -Command ^
::    "try { Invoke-WebRequest -UseBasicParsing '%API_BRANCH_URL%' -OutFile '%REMOTE_JSON%' -ErrorAction Stop; exit 0 } catch { exit 1 }"


if errorlevel 1 (
    echo ERROR: Could not check GitHub for the latest branch information.
    exit /b 1
)

for /f "usebackq tokens=* delims=" %%A in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$json = Get-Content -Raw '%REMOTE_JSON%' | ConvertFrom-Json; $json.commit.sha"`) do (
    set "REMOTE_COMMIT=%%A"
)

if not defined REMOTE_COMMIT (
    echo ERROR: Could not read the latest remote commit ID.
    exit /b 1
)

exit /b 0

:DecideAction
:: No updater settings file means this is treated as a first install.
if "%STATE_PRESENT%"=="0" (
    set "FIRST_INSTALL=1"
    set "FORCE_REINSTALL=1"
    set "REPAIR_MODE=0"
    exit /b 0
)

:: If the installed project or its important files are missing, force a repair reinstall.
if "%INSTALL_PRESENT%"=="0" set "FORCE_REINSTALL=1"

if "%CHECK_README%"=="0" set "FORCE_REINSTALL=1"
if "%CHECK_LICENSE%"=="0" set "FORCE_REINSTALL=1"
if "%CHECK_CHANGELOG%"=="0" set "FORCE_REINSTALL=1"

:: If the saved branch does not match the updater branch, force a reinstall.
if defined LOCAL_BRANCH (
    if /I not "%LOCAL_BRANCH%"=="%REPO_BRANCH%" set "FORCE_REINSTALL=1"
) else (
    set "FORCE_REINSTALL=1"
)

:: If the previous run did not end in a healthy state, treat it as interrupted or incomplete.
if defined LOCAL_INSTALL_STATE (
    if /I not "%LOCAL_INSTALL_STATE%"=="Healthy" set "FORCE_REINSTALL=1"
) else (
    set "FORCE_REINSTALL=1"
)

:: Compare the saved local commit against the latest remote commit.
if defined LOCAL_COMMIT (
    if /I not "%LOCAL_COMMIT%"=="%REMOTE_COMMIT%" set "NEEDS_UPDATE=1"
) else (
    set "NEEDS_UPDATE=1"
)

if "%FIRST_INSTALL%"=="1" exit /b 0

if "%FORCE_REINSTALL%"=="1" (
    set "REPAIR_MODE=1"
    exit /b 0
)

exit /b 0

:: -------------------------------------------------------------------------------
:: DOWNLOAD / EXTRACTION / STAGING
:: -------------------------------------------------------------------------------
:DownloadZip
:: Downloads the latest project ZIP into the updater's temporary working folder.
if exist "%DOWNLOAD_ZIP%" del /f /q "%DOWNLOAD_ZIP%" >nul 2>&1


:: PowerShell download mode:
:: Default behavior hides the PowerShell progress display because visible progress
:: output can cause the updater's console layout to redraw incorrectly after resizing.
:: To restore visible PowerShell progress, comment out the active command block
:: below and uncomment the optional command block under it.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ProgressPreference='SilentlyContinue'; try { Invoke-WebRequest -UseBasicParsing '%ZIP_URL%' -OutFile '%DOWNLOAD_ZIP%' -ErrorAction Stop; exit 0 } catch { exit 1 }"

::powershell -NoProfile -ExecutionPolicy Bypass -Command ^
::    "try { Invoke-WebRequest -UseBasicParsing '%ZIP_URL%' -OutFile '%DOWNLOAD_ZIP%' -ErrorAction Stop; exit 0 } catch { exit 1 }"


if errorlevel 1 (
    echo ERROR: Could not download the latest project ZIP.
    exit /b 1
)

if not exist "%DOWNLOAD_ZIP%" (
    echo ERROR: The download did not complete correctly. The project ZIP was not found.
    exit /b 1
)

exit /b 0

:ExtractZip
:: Extracts the downloaded project ZIP so its files can be checked and prepared.


:: PowerShell extraction mode:
:: Default behavior hides the PowerShell progress display because visible progress
:: output can cause the updater's console layout to redraw incorrectly after resizing.
:: To restore visible PowerShell progress, comment out the active command block
:: below and uncomment the optional command block under it.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ProgressPreference='SilentlyContinue'; try { Expand-Archive -LiteralPath '%DOWNLOAD_ZIP%' -DestinationPath '%EXTRACT_DIR%' -Force; exit 0 } catch { exit 1 }"

::powershell -NoProfile -ExecutionPolicy Bypass -Command ^
::    "try { Expand-Archive -LiteralPath '%DOWNLOAD_ZIP%' -DestinationPath '%EXTRACT_DIR%' -Force; exit 0 } catch { exit 1 }"


if errorlevel 1 (
    echo ERROR: Could not extract the downloaded project ZIP.
    exit /b 1
)

if not exist "%EXTRACT_DIR%\%ZIP_FOLDER_NAME%" (
    echo ERROR: The expected extracted project folder was not found:
    echo     %EXTRACT_DIR%\%ZIP_FOLDER_NAME%
    exit /b 1
)

exit /b 0

:ValidateExtractedProject
:: Checks that the extracted project contains the important root files it should have.
if not exist "%EXTRACT_DIR%\%ZIP_FOLDER_NAME%\README.md" (
    echo ERROR: The extracted project is missing README.md
    exit /b 1
)

if not exist "%EXTRACT_DIR%\%ZIP_FOLDER_NAME%\LICENSE" (
    echo ERROR: The extracted project is missing LICENSE
    exit /b 1
)

if not exist "%EXTRACT_DIR%\%ZIP_FOLDER_NAME%\CHANGELOG.md" (
    echo ERROR: The extracted project is missing CHANGELOG.md
    exit /b 1
)

exit /b 0

:PrepareStaging
:: Rebuilds the temporary preparation folder and copies the extracted project files into it.
if exist "%STAGING_DIR%" (
    rmdir /s /q "%STAGING_DIR%" >nul 2>&1
)

mkdir "%STAGING_DIR%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not recreate the temporary preparation folder.
    exit /b 1
)

xcopy "%EXTRACT_DIR%\%ZIP_FOLDER_NAME%\*" "%STAGING_DIR%\" /E /I /H /Y >nul
if errorlevel 1 (
    echo ERROR: Could not copy the extracted project files into the temporary preparation folder.
    exit /b 1
)

if not exist "%STAGING_DIR%\README.md" (
    echo ERROR: The prepared project files appear incomplete.
    exit /b 1
)

exit /b 0

:: -------------------------------------------------------------------------------
:: INSTALL REPLACEMENT / BACKUP RESTORE
:: -------------------------------------------------------------------------------
:ReplaceInstall
:: Remove any leftover backup folder from an earlier updater run.
if exist "%BACKUP_DIR%" (
    rmdir /s /q "%BACKUP_DIR%" >nul 2>&1
    if exist "%BACKUP_DIR%" (
        echo ERROR: Could not remove the old backup folder:
        echo     %BACKUP_DIR%
        exit /b 1
    )
)

:: Move the current installed project folder aside first if it already exists.
if exist "%INSTALL_DIR%" (
    ren "%INSTALL_DIR%" "%BACKUP_NAME%" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Could not rename the current project install folder.
		echo Make sure nothing inside the installed project folder is open or in use.
        exit /b 1
    )
)

:: Create a fresh project install folder.
mkdir "%INSTALL_DIR%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not create a fresh project install folder.
    call :RestoreBackup
    exit /b 1
)

:: Copy the prepared project files into the installed project folder.
xcopy "%STAGING_DIR%\*" "%INSTALL_DIR%\" /E /I /H /Y >nul
if errorlevel 1 (
    echo ERROR: Could not copy the new project files into the installed project folder.
    rmdir /s /q "%INSTALL_DIR%" >nul 2>&1
    call :RestoreBackup
    exit /b 1
)

:: Confirm that the updated project install looks complete enough to keep.
if not exist "%INSTALL_DIR%\README.md" (
    echo ERROR: The updated project install appears incomplete.
    rmdir /s /q "%INSTALL_DIR%" >nul 2>&1
    call :RestoreBackup
    exit /b 1
)

:: Remove the old backup after success unless it is being intentionally kept.
if "%KEEP_BACKUP%"=="0" (
    if exist "%BACKUP_DIR%" (
        rmdir /s /q "%BACKUP_DIR%" >nul 2>&1
        if exist "%BACKUP_DIR%" (
            echo WARNING: The update succeeded, but the old backup folder could not be removed.
            echo     %BACKUP_DIR%
        )
    )
)

exit /b 0

:RestoreBackup
:: Tries to restore the previous project install if replacement fails partway through.
if exist "%BACKUP_DIR%" (
    if not exist "%INSTALL_DIR%" (
        ren "%BACKUP_DIR%" "Windows-System-Tools" >nul 2>&1
    ) else (
        rmdir /s /q "%INSTALL_DIR%" >nul 2>&1
        ren "%BACKUP_DIR%" "Windows-System-Tools" >nul 2>&1
    )
)
exit /b 0

:: -------------------------------------------------------------------------------
:: UPDATER SETTINGS FILE (.ini)
:: -------------------------------------------------------------------------------
:WriteStateOnly
:: Saves a temporary updater status before the main replacement work finishes.
set "STATE_VALUE=%~1"

(
    echo [Updater]
    echo RepoOwner=%REPO_OWNER%
    echo RepoName=%REPO_NAME%
    echo Branch=%REPO_BRANCH%
    echo InstallRoot=%INSTALL_ROOT%
    echo InstallDirectory=%INSTALL_DIR%
    echo LastInstalledCommit=%LOCAL_COMMIT%
    echo InstallState=%STATE_VALUE%
    echo LastRunDate=%DATE%
    echo LastRunTime=%TIME%
    echo LastRunResult=%STATE_VALUE%
) > "%STATE_FILE%"

if errorlevel 1 (
    echo ERROR: Could not save the temporary updater details.
    exit /b 1
)

exit /b 0

:WriteFullIni
:: Saves the final updater details after a successful update finishes.
set "FINAL_STATE=%~1"

(
    echo [Updater]
    echo RepoOwner=%REPO_OWNER%
    echo RepoName=%REPO_NAME%
    echo Branch=%REPO_BRANCH%
    echo InstallRoot=%INSTALL_ROOT%
    echo InstallDirectory=%INSTALL_DIR%
    echo LastInstalledCommit=%REMOTE_COMMIT%
    echo InstallState=%FINAL_STATE%
    echo LastRunDate=%DATE%
    echo LastRunTime=%TIME%
    echo LastRunResult=%FINAL_STATE%
    echo LastUpdateDate=%DATE%
    echo LastUpdateTime=%TIME%
) > "%STATE_FILE%"

if errorlevel 1 (
    echo ERROR: Could not save the final updater details.
    exit /b 1
)

exit /b 0

:MarkFailedIfPossible
:: Tries to save a failed updater result if the updater stops partway through.
(
    echo [Updater]
    echo RepoOwner=%REPO_OWNER%
    echo RepoName=%REPO_NAME%
    echo Branch=%REPO_BRANCH%
    echo InstallRoot=%INSTALL_ROOT%
    echo InstallDirectory=%INSTALL_DIR%
    echo LastInstalledCommit=%LOCAL_COMMIT%
    echo InstallState=Failed
    echo LastRunDate=%DATE%
    echo LastRunTime=%TIME%
    echo LastRunResult=Failed
) > "%STATE_FILE%" 2>nul

exit /b 0

:: -------------------------------------------------------------------------------
:: RESULTS / FAILURE HANDLING / SCRIPT EXIT
:: -------------------------------------------------------------------------------
:SUCCESS_NO_UPDATE
:: Shown when the saved local commit already matches the latest remote commit.
echo.
echo ==========================================================================================
echo #                                   NO UPDATE REQUIRED                                   #
echo ==========================================================================================
echo.
echo The installed project already matches the latest tracked commit.
goto :END

:DOWNLOAD_OR_PREP_FAIL
:: Used when downloading, extracting, checking, or preparing project files fails.
call :MarkFailedIfPossible
goto :FAIL

:REPLACE_FAIL
:: Used when replacing the installed project folder fails.
call :MarkFailedIfPossible
goto :FAIL

:POST_INSTALL_FAIL
:: Used when the update finishes but the final updater details cannot be saved.
call :MarkFailedIfPossible
goto :FAIL

:UNEXPECTED_STATE
:: Catch-all for unexpected internal updater states.
echo.
echo ERROR: The updater reached an unexpected internal state.
echo ERROR: Please close the updater and try again.
echo ERROR: If the issue continues, redownload the updater script and project files.
call :MarkFailedIfPossible
goto :FAIL

:FAIL
:: Final failure output shown after the updater has already attempted recovery steps.
echo.
echo.
echo ==========================================================================================
echo #                                     UPDATE FAILED                                      #
echo ==========================================================================================
echo.
echo No successful update was completed.
echo If an earlier installed copy was present and could be restored, the updater attempted that.
goto :END

:END
:: Final pause and clean exit point for the updater.
echo.
echo Pressing any key will exit the terminal.
echo.
pause
endlocal
exit /b