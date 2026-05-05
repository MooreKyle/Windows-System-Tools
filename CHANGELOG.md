# 🧰 Windows System Tools – Changelog

All notable changes to this project will be documented in this file.

Changes for upcoming releases may be tracked in the [Unreleased] section as work is completed before a formal versioned release is finalized.

This project uses Semantic Versioning.

- PATCH (`1.0.1`) = fixes, corrections, documentation sync, and non-breaking cleanup
- MINOR (`1.1.0`) = new scripts, utilities, or meaningful non-breaking improvements
- MAJOR (`2.0.0`) = breaking changes or major project restructuring

---

## [Unreleased]

### Added
- Added new external updater script: `Update-Windows-System-Tools.bat`, for future project updates.
  - Uses a commit-based full-refresh approach to install, update, or repair the project.
  - Supports first install, update checks, repair reinstalls, backup-and-replacement flow, and safer recovery handling.
  - Includes an introduction screen, clearer user-facing output, and more organized code comments.
  - Tracks updater state through an external `.ini` file: `Windows-System-Tools-Updater.ini`.
  - Is intended to be kept outside the installed project folder, and blocks execution from anywhere inside it.
  - Hides PowerShell progress output by default to prevent console redraw issues, while keeping optional advanced code paths available for portable installs, updater path debugging, and visible PowerShell progress output.

### Changed
- None yet.

### Fixed
- Fixed GitHub license detection so the Apache 2.0 badge displays properly.
- Fixed a missing blank line before the `Current Status` header in `Update-Windows-System-Tools.bat` when the install root folder is created.

### Documentation
- Revised `README.md` for better detail, clarity, readability, and newcomer guidance.
  - Added a `Recommended Starting Points` section.
  - Added direct references to `CHANGELOG.md`, `Update-Windows-System-Tools.bat`, and `~CLI_Check_Script_Permissions_or_Trust~.bat`.
  - Added clearer updater usage guidance, including copying the updater outside the installed project folder before use.
  - Clarified updater-related information in the `Updater Script` and `How to fix it:` sections.
  - Updated the README's disclaimer statement to no longer mention archived folders, and to further emphasize safety practices.
- Preserved the previous main README as `README (v1.0 release era).md`.
- Finalized the structure of `CHANGELOG.md`, including release tracking, `[Unreleased]`, and Semantic Versioning guidance.

### Removed
- Removed an old placeholder `.Gitkeep` file from the `\2. Windows CLI Scripts` folder.
- Removed `.rar` archive packaging from `1. Windows CLI Shortcuts`, `2. Windows CLI Scripts`, and future active project folders, leaving them directly accessible for easier browsing and access.
	- Duplicate nested folders created by unarchiving each folder have also been deleted to reduce repetition.

### Notes
- This release establishes the new updater and changelog workflow that future project updates will build on.

---

## Releases

## [1.0.0] - 2025-04-18

### ✅ Highlights
- Base release complete: 16 finalized batch scripts + quadrant-ready documentation
- Collection of Windows Command-Line Interface (CLI) Shortcut commands
- Designed for both casual and advanced users: CLI shortcuts (with hover-over comments) and .bat script automation
- Project structure established for future modular expansion - Shortcuts and scripts grouped into categorized, numbered folders, and more.

---

### 🛠️ Scripts
- ✅ Included test script `~CLI_Check_Script_Permissions_or_Trust~` with (0–4.8) for stable base release.
  - Used as a sample script for testing script administrator permissions and trust flag(s) in Windows.
- ✅ Added all scripts from all categorized folders into `ALL SCRIPTS` folder as alternative, ease-of-access option.
- ✅ Created placeholder for scripts folder: `2. Windows CLI Scripts`
- ✅ Finalized and tested all main batch scripts (`0–4.8`) for stable base release.
- ✅ Fixed folder path syntax for `4.3 - Windows Update Reset` script.
- ✅ Integrated DISM `/RestoreHealth` for system image repair (`/CheckHealth` only checks, does not fix) and added displaying system logging locations of commands into:
  - `1.8 - System Health and Repair` and `1.9 -Full System Diagnostics and Repair`.
- ✅ Fixed unified diagnostic script (`1.9 – Full System Diagnostics and Repair`).
- ✅ Verified and corrected outdated commands and working directory references.
- ✅ Standardized right-aligned watermarks and copyright.
- ✅ All network scripts (`3.x`) debugged, enhanced, and finalized (including the 3.9 consolidation).
- ✅ Headers, UI echos, and script commands aligned for quadrant viewing with no horizontal scroll.
- ✅ Finished `CLI_Check_Script_Permissions_or_Trust` script for users to easily test run a sample script.
- ✅ Most reports generated from scripts are saved to user desktop (current exception: `1.8 - System Health and Repair` logs) and notify user.
- ✅ Assigned decimal number values corresponding to whole numbers, for scripts of their respective numbered, categorized folder. The count does not reset (unlike for shortcuts).
- ✅ Duplicated the categorized, numbered folders of Windows CLI Shortcuts folders of same names, but for scripts.

---

### ⚡ CLI Shortcuts
- ✅ Removed a duplicate folder (of same name in file path: `5. System Power Management Commands`), requiring extra clicks to reach actual respective contents.
- ✅ Moved all categorized, numbered CLI Shortcut folders and `ALL COMMANDS` folder into `Windows CLI Shortcuts` folder, then, renamed to `1. Windows CLI Shortcuts`.
- ✅ Added: "Enable Ultimate Performance Power Plan" and "List Available Power Plans" to `5. System Power Management Commands` and `ALL COMMANDS` folders.
- ✅ Added all commands from all categorized folders into `ALL COMMANDS` folder as alternative, ease-of-access option.
- ✅ Assigned numbers (that count up starting from 1) to all shortcuts, based on order of perceived importance. The count resets in each categorized, numbered folder.
- ✅ Organized Windows CLI Shortcut Commands into categorized, numbered folders (`1-6`) and pushed to GitHub.
- ✅ Created base collection of Windows CLI Shortcut commands with hover-over comments explaining purposes, use-cases, and if requiring administrator privileges.

---

### 📄 Documentation
- ✅ Created this changelog for future documentation of scripts and beyond for the project.
- ✅ Updated `README.md` and `README (APRIL FOOLS).md` with statements of clarity, context, and awareness.
- ✅ Finalized license choice to remain as Apache License 2.0 and uploaded to GitHub. Added authorship and copyright info to LICENSE file.
- ✅ Completed `Script Documentation and Flags.txt` with:
  - Organized and clean UI headers
  - Script purposes and brief command descriptions
  - Accurate admin/network flags
  - Minimal-scroll layout optimized for quadrant viewing and Windows Snap Assist feature
- ✅ Standardized right-aligned watermarks and copyright.
- ✅ Added internal version tracking and legend system to documentation.
- ✅ Synced command names, descriptions and order of appearances with finalized script command structures.

---

### 🗂️ Other Notes
- ✅ Updated encrypted `DevNotes.rar` with more future plans, updates, and additional things...
- ✅ Created encrypted `DevNotes.rar` to preserve QOL roadmap and update tracking, and more things...
- 🌱 Future plans include: Quality-of-Life updates to scripts/shortcuts, additional scripts and shortcuts, GUI command shortcuts, registry key integration, possible PowerShell support, and more!
