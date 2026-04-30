# 🧰 Windows System Tools

You've heard of plug and play, but have you considered "click and it just works"?

This repository is a user-friendly collection of **command-line shortcuts**, **batch scripts**, and **system tools** for optimizing, troubleshooting, and managing Windows.

It is designed to be useful for both casual and advanced users, with strong focus on:
- clear wording with minimal jargon
- meaningful and easy-to-read output
- intuitive organization
- consistent numbering for easier reference

---

## 🚀 Recommended Starting Points

If you're new to the project, start with these:

- **Read `Script Documentation and Flags.txt` first** to understand what each script does, what commands it uses, and whether it requires administrator privileges or a network connection.
- **Check `CHANGELOG.md`** if you want a clear summary of released changes or changes currently tracked under `[Unreleased]`.
- **Use `Update-Windows-System-Tools.bat` after first setup** if you want future project updates to be easier. Before using it, copy the updater script outside the installed project folder, such as to `C:\Scripts`.
- **Use the test script `~CLI_Check_Script_Permissions_or_Trust~.bat` first** if you want to confirm that Windows permissions, trust settings, or administrator access are not blocking script execution.
- **Start with the numbered folders** based on what you need, such as diagnostics, system information, network tools, or power-related commands.
- **Check shortcut comments** by hovering over them, since they include brief explanations and note when administrator privileges may be needed.

---

## 📁 What's in the Project?

### 🔹 Command-Line Shortcuts
Shortcuts are standard Windows shortcut (`.lnk`) files that typically open Command Prompt (`CMD`, a command-line interface or `CLI`) or built-in Windows items. They open system tools, run diagnostics, or perform quick actions with clear descriptions. They’re organized by purpose:
- **1. System Diagnostics and Repair**
- **2. System Information and Settings**
- **3. Network Management**
- **4. Additional System Management**
- **5. System Power Management Commands**
- **6. Screen Brightness Commands (for laptops)**
- **ALL COMMANDS**

Users can hover over these shortcuts to find helpful comments in each shortcut explaining their purpose, what they do, and whether they require administrator privileges.

---

### 🔹 Scripts (Batch Files)
Scripts are `.bat` files built to automate many of the shortcut actions in one place. They open Command Prompt, though some commands open built-in Windows items. They come with:
- clear and organized section headers
- organized command sequences
- easy-to-read outputs and prompts
- consistent spacing between commands and sections

For the sake of consistency and intuitiveness, they follow the same organization convention as the shortcuts:
- **1. System Diagnostics and Repair**
- **2. System Information and Settings**
- **3. Network Management**
- **4. Additional System Management**
- **ALL SCRIPTS**

Some scripts run multiple system checks, especially the combined script variations labeled `x.9`, where `x` is the whole number for the respective folder. Others clean up unused files or handle power optimization. If a script requires administrator access, that is noted in `Script Documentation and Flags.txt`.  

That file details each script's purpose and use cases, the commands included in order with brief descriptions of what they do, and whether a script requires administrator privileges or a network connection to function fully.

The scripts and their documentation were designed to fit comfortably in quarter-screen or half-screen layouts on a standard monitor, with minimal horizontal scrolling. This makes it easier to keep documentation visible while one or more scripts are running, and it also works well for multi-monitor users.

This pairs especially well with the Windows `Snap Assist` feature, which allows users to quickly arrange CMD windows into:
- four corners (quarter-screen views)
- left or right halves
- a larger single window when needed

---

### 🔹 Updater Script
The repository also includes an external updater script: `Update-Windows-System-Tools.bat`.

It is designed to:
- check the latest project commit on GitHub
- compare that against the updater’s saved local state
- download a fresh copy of the project when needed
- replace the installed project copy more safely during updates or repairs

The updater is meant to be kept **outside** the installed project folder so it does not interfere with replacement during refreshes.

By default, it is designed around:
- `C:\Scripts\Update-Windows-System-Tools.bat`
- `C:\Scripts\Windows-System-Tools`

The updater includes a short introduction screen before it runs, tracks updater state through an external `.ini` file, and uses a full refresh approach instead of trying to patch only certain changed files.

---

## 🔐 Why This Project Keeps Things Simple and Safe

This project is built with **user control and security in mind**. That’s why:

### ❌ No auto-run as admin
You won't see forced elevation or silent privilege tricks here, such as PowerShell, VBA, or Task Scheduler workarounds. Methods like these are often abused by malware, and they make it easier for something harmful to run with full control.

  - Instead, you’re in control. Just **right-click and choose `Run as administrator`** when needed.

### ❌ Shortcuts don’t auto-run as admin
Shortcuts in this project are not pre-set to always run as administrator. If someone, or something, triggers a shortcut like that, the action may be harder to stop or undo.

  - Leaving that setting off adds a layer of safety. You can still run a shortcut as administrator manually when needed.

### ❌ No admin tricks inside scripts
Scripts in this project do not try to force individual commands to run as administrator. That approach is messy, unreliable, and unnecessary.

- If a script requires elevated permissions, it is meant to be run with full administrator rights from the start.

---

## 🛠️ If a Script Closes Instantly — Here's Why

Sometimes, when a script is run as administrator, it may flash and close immediately. That is usually not a bug — it is often Windows silently blocking it.

### Why this can happen:  
  - the script is stored in **Desktop**, **Downloads**, or **OneDrive**
  - It was downloaded or copied from another PC
  - Windows marked it as **untrusted**

This mainly affects scripts that are run as administrator.

### How to fix it:
1. Create a safe folder directly on the `C:` drive, such as `C:\Scripts`

   This is also the recommended base location for the updater script and installed project folder. If `C:\Scripts` does not already exist, the updater can create it when needed.
   
2. Move the `.bat` file there
3. Right-click it and choose `Run as administrator`

**Note:** Moving it into a subfolder of `C:\Scripts` may or may not fix the issue.

After that, Windows will often trust the script again, even if you move it back later. In other words, the hidden trust flag is often cleared once this is done.

If it still does not run, your PC may also be blocking it through SmartScreen or antivirus settings.

To check that:
   1. Right-click the file and choose **Properties**.
   2. If you see an **Unblock** checkbox at the bottom, check it, click **Apply**, and try again.

This is separate from the hidden trust flag, but it can block files in a similar way.

---

## ✅ Summary of Security Choices

| Feature                                     | Used?   | Reason                               |
|---------------------------------------------|---------|--------------------------------------|
| Auto-elevation with PowerShell or VBA       | ❌ No  | Too risky, often abused by malware   |
| Admin elevation inside scripts              | ❌ No  | Messy and unreliable                 |
| Shortcuts set to “Run as administrator”     | ❌ No  | Safer to let users decide            |
| Clear comments for admin-needed commands    | ✅ Yes | Lets users know what needs elevation |
| Right-click → Run as admin support          | ✅ Yes | Clean, safe, and expected behavior   |

---

## ❓ Frequently Asked Questions (FAQ)

### Why does CMD prompt continuously scroll down when I scroll up? Is there a way to prevent this?

CMD will always scroll down to the most recently updated output while new content is still being rendered.

Currently, there is no fixed, controlled way to prevent this until the script fully finishes, pauses for input, or otherwise stops updating the display.

- There may or may not be a future update to improve this. 
- One possible workaround is to click and hold the scroll thumb or scroll track, preferably the scroll thumb for better control.  
    - Once the mouse click is released, the scroll position will usually jump back to the bottom.
    - If new terminal output appears while the mouse click is being held, that jump back to the bottom is effectively buffered and will usually happen after release.
    - If no new output appears while the mouse click is held and released, the scroll position may remain where it was until a later update moves it again.



### Why does the Graphical User Interface (GUI) font text shrink in CMD, even when not much text is visually displayed?

The terminal can adjust based on how much content it thinks it needs to render, not just what is visibly shown on-screen.

This should not currently happen for any scripts in the repository. However, even if a command such as `driverquery` has its output redirected to a file instead of being shown in the terminal, CMD may still treat it internally as a very large text operation. That can trigger visual changes such as the font appearing smaller.

- This is usually not a major concern unless:
  - it causes layout issues, which is uncommon
  - you are trying to optimize screen readability, in which case spacing or `cls`-style clearing may help, but usually is not worth the trade-off 

In other words, this behavior is mostly built into how the shell window renders content. Batch scripting itself dates back to 1981.

This is not a crash, and it does not usually affect the actual output.

Be aware that using **Ctrl + Mouse Scroll** to zoom in or out can cause display issues, even if you later return to the original zoom level. Some text may stop displaying correctly. If possible, it is best not to zoom while a script is running.

If you must zoom out, one possible workaround is to first scroll to the bottom of the script and then zoom out. This may preserve all, or at least most, of the script text. If not, it may still help prevent the text currently visible on-screen from appearing to vanish.

If the font appears smaller, it may be because too many entries were generated by one command or a combination of commands, such as a very large number of scheduled tasks, drivers, or other results.

This has not happened to me with the current scripts. However, if it does happen for you, please let me know and include the output if possible.

If this becomes a common issue, I may consider adapting the scripts further to improve readability for more users.



### Why didn't you put more commands together in scripts, versus splitting them up?

This came down to design constraints for several reasons. Scripts that are overloaded (no programming pun intended) with too many commands and too much output can crash when run with administrator privileges. While scripts may run as normal without admin privileges, those privileges are needed in some cases to ensure every command works as intended.

Too many commands running back to back, combined with too much output, can cause issues such as resource bottlenecks or memory strain within CMD, which may cause the terminal to close unexpectedly.
  - Commands such as `wevtutil` or full `schtasks` dumps can flood `stdout` (standard output), making a script more likely to crash.



### Why does CMD Prompt get stuck without updating to execute the rest of the script?

CMD may not always refresh its display in a way that reflects its actual progress.  
- One possible fix is to press any key, which may refresh the display.
- If the script has already finished and a key is pressed to trigger a refresh, it should update the visible contents rather than exit the script.
- Possible causes of this, which I cannot confirm with 100% certainty, may include:
  - CMD being unfocused, meaning it is running in the background instead of as the active foreground window
  - resizing the CMD window during execution
  - process interruptions or resource strain on the PC


### Why does CMD Prompt show initial information from a script, and later in its runtime of commands, the information seems like less, cut off, or vanished?

This may be more common on older computers (i.e.: Dell Inspiron 15 3000 Series - Inspiron 3542 system), especially systems with older internal components or outdated BIOS versions. Ironically, older PCs running a legacy scripting environment like batch may make this behavior more noticeable.    

- This may also be heavily tied to the PC not being fully updated, or not having enough memory (RAM) to let CMD keep displaying as much information at once.
- In those cases, CMD may begin dropping older visible content from the top of the window as more output is generated.
- Think: FIFO (First In, First Out).



### Can you run two or more scripts at once?

Yes, you can run multiple .bat scripts in different CMD windows at the same time. However, results may vary depending on the scripts.

  - If they are read-only or reporting scripts, it is generally safe to run more than one at once.  
  - If they change settings, such as `dism`, `sfc`, `netsh`, or power-related commands, it is safer to run them one at a time.

I have not experimented much with which specific script combinations can run in parallel. Information on this may or may not be updated here in the future.



### Is there any convenience to running many scripts at once, and any recommendations to perform this effectively?

Yes. The scripts were designed to fit well on a standard PC monitor, without requiring excessive horizontal space to read them.

They were also designed so multiple CMD windows can be kept visible at the same time, which makes it easier to compare results, keep documentation visible while scripts are running, or take better advantage of multi-monitor setups.

This works especially well with the Windows `Snap Assist` feature, which makes it easy to arrange CMD windows into:
- four corners (quarter-screen views)
- left or right halves
- a larger single window when needed

The Windows `Snap Assist` feature works by dragging a window to a corner or side of the screen to snap it into place.



### Why did the terminal (seemingly) close at the end when it was finished?

When the script finishes, it displays the prompt: `"Press any key to continue . . ."`, which means pressing any key will close the script. If you have anything in your clipboard from using the copy function, then right-click with your mouse, that may count as entering a key.

- Copying can accidentally occur when highlighting even a single character in the terminal, including when the mouse is no longer hovering over the highlighted area before right-clicking.
- One possible workaround is to click and right-click a blank area in the terminal, or do so without highlighting more than one row, which may clear the copied character or "key" from the clipboard.

Crashes should not normally occur at this point. However, they are still possible, especially if the script produced a very large amount of output and CMD becomes overloaded.

- If that happens and no solution in this FAQ covers it, please report it through my email on my GitHub profile or by using the repository's **Issues** section.



### Why does pressing `Ctrl+C` together ask me to cancel execution of the "batch job" instead of copying text to my clipboard?

`Ctrl+C` overrides the usual copy shortcut in Command Prompt and instead acts as the interrupt command for the running batch job.

If this happens accidentally, entering `Y` or `y` will usually allow the script to continue running. There may be minor and uncommon exceptions where a script can still bug out, cancel tasks, or close the terminal.
  - Even if a script can sometimes continue after this, it is strongly recommended not to interrupt a running script unless necessary. Results may vary depending on the commands involved, and some changes may already have partially taken effect.
  - Copying with `Ctrl+C` still works normally when text is already highlighted in CMD.
  - Right-clicking anywhere in CMD also works as a copy method when text is highlighted.



### Why does CMD flash and never seemingly open to execute or show results of a shortcut or script?

Not all shortcut commands are designed to keep the terminal open after they finish running. This is uncommon, but it can happen with certain commands, such as `Enable Ultimate Performance Power Plan`.

If scripts are not located in a root-level folder on the `C:` drive, there may be issues getting them to run at all.

It is also important to make sure Windows SmartScreen is not blocking the downloaded files.

To check that:
1. Right-click the main folder containing the downloaded files and choose **Properties**.
2. If an **Unblock** option is present, enable it and choose **Apply** to save the change.

This should apply to the contents inside that folder as well.

Be sure to use the test script in this repository to verify Windows permissions and administrator access, since that is the most common cause of scripts not running properly.



### Do the scripts in CMD ever have their contents distorted during runtime? How do they handle text that is already generated when the window is stretched or compressed?

This is rarely, or at least uncommonly, a concern. Possible causes may include a PC with many running tasks, a lack of memory to handle running scripts effectively, or adjustments to the window during execution.

Generally, rare occurrences like this should not majorly affect readability.

- One possible fix is to minimize and restore the window.
- Stretching it back to the size it was before the issue occurred may also help.
- If neither works, rerunning the script may be the only fix.

The text generated in CMD usually wraps onto the next line or re-aligns itself depending on whether the window is compressed or stretched.

In other words, the contents adjust dynamically based on what can fit in the window, which helps reduce the chance of the displayed text becoming illegible.



### I opened the `Scripts Documentation and Flags.txt` file and the formatting is messed up, and not in order, why?

This is likely due to an outdated version of Windows, file corruption, or a corrupted Windows installation. Running built-in repair tools such as `SFC` or `DISM` may not always fix this.

Try updating Windows through Windows Update first.

If Windows Update itself is not working properly, you may need to update manually by using tools such as the Windows Update Assistant or Media Creation Tool.

- A future change may be made to `Scripts Documentation and Flags.txt` to improve compatibility across more systems.

---

## ⚠️ Disclaimer

Use these tools at your own discretion. Always read comments and headers before running shortcuts, and read the supplied documentation before running scripts. Most files are compressed or zipped to help prevent accidental execution.

---

## 👤 Author

**Kyle Moore**  
*Creator and developer of this project*  
[GitHub: MooreKyle](https://github.com/MooreKyle)

---

This README will be expanded and improved over time as the project evolves.
