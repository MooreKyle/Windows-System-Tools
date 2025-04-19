# 🧰 Windows System Tools – Changelog

## v1.0.0 – 2025-04-18

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
