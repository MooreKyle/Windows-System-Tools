# 🧰 Windows System Tools

You've heard of plug and play, but have you considered 'click and it just works'?

This repository is a user-friendly and powerful collection of **command-line shortcuts**, **batch scripts**, and **system tools** to optimize, troubleshoot, and manage Windows. It is aimed to be used universally, from casual users to advanced, technical users. With that being said, the project has major focuses in minimizing jargon and technical wording, communicating clearly to the user with meaningful and intuitive output and much more, so that it is comprehendable for a large audience. The numbering system is used across this project to improve ease-of-access and user friendliness, especially for consistent referencing.

---

## 📁 What's in the Project?

### 🔹 Command-Line Shortcuts
Shortcuts are simple `.ink` files that typically open Command Prompt (CMD, a Command-Line Interface (CLI)) or built-in items. These open system tools, run diagnostics, or perform quick actions with clear descriptions. They’re organized by purpose:
- **1. System Diagnostics and Repair**
- **2. System Information and Settings**
- **3. Network Management**
- **4. Additional System Management**
- **5. System Power Management Commands**
- **6. Screen Brightness Commands (for laptops)**
- **ALL COMMANDS**

Users can hover over these shortcuts to find helpful comments in each shortcut explaining their purpose, what they do, and if they require administrator privileges.

---

### 🔹 Scripts (Batch Files)
Scripts are `.bat` files that are built to automate many of the shortcut actions in one go. They open Command Prompt, however, some commands open built-in items. They come with:
- Clear and organized section headers
- Organized command sequences
- Easy-to-read outputs and prompts
- Optimized spacing between most commands and scripts

For the sake of consistency and intuitiveness, they follow the same organization convention as shortcuts:
- **1. System Diagnostics and Repair**
- **2. System Information and Settings**
- **3. Network Management**
- **4. Additional System Management**
- **ALL SCRIPTS**

Some scripts run multiple system checks (especially the combined script variations labeled x.9, where x is the whole number for the respective folder), others clean up unused files or handle power optimization. If a script needs administrator access, it tells you upfront within the documentation file, `Script Documentation and Flags.txt`. The scripts are designed to fit on a quarter (1 quadrant) or half (2 quadrants) of the screen, with no horizontal scrolling required for most PC monitors.
	- This allows for documentation to fit on-screen as reference with a script or two on-screen simultaneously, and running. This also helps multi-monitor users.

This file details each scripts purposes and use-cases, list of commands in order with brief descriptions of what they do, and if a script requires administrator privileges or a network connection to fully function.
The file is also designed to minimize horizontal scrolling, making it fit well onto a quarter (one quadrant) or half (two quadrants) of a computer screen, as shown below:

                               |                               
                               |                               
                               |                               
                               |                               
               Q2              |              Q1                 
                               |                               
                               |                               
                               |                               
                               |                               
                               |                               
---------------------------------------------------------------
                               |                               
                               |                               
                               |                               
                               |                               
                               |                               
               Q3              |              Q4                  
                               |                               
                               |                               
                               |                               
                               |                               

This is very useful when paired with Windows `Snap Assist` feature, which allows a user to drag a window to a corner or side of their screen to make the window `snap` to it. Snapping features include:
   - 4 corners (takes up one quadrant, or a quarter of the screen)
   - Left or right horizontal sides (takes up 2 quadrants, or a vertical half of the screen)
   - Top side (takes up all 4 quadrants, going windowed full screen)

---

## 🔐 Why This Project Keeps Things Simple and Safe

This project is made with **user control and security in mind**. That’s why:

### ❌ No auto-run as admin
You’ll never see forced elevation or silent privilege tricks (like with PowerShell, VBA, or Task Scheduler workarounds). These methods are often used by malware, and they make it easier for something harmful to run with full control.
     - Instead, you’re in control. Just **right-click and choose “Run as administrator”** when needed.

### ❌ Shortcuts don’t auto-run as admin
Shortcuts in this project are not pre-set to always run as admin because if someone (or something) triggers that shortcut, it may be irreversible.
     - Leaving it off adds a layer of safety. You can always run a shortcut as admin manually when needed.

### ❌ No admin tricks inside scripts
Scripts don't force individual commands to run as admin — that’s unstable, messy, and unnecessary. If a script needs elevated permissions, it’s meant to be run with full admin rights from the start.

---

## 🛠️ If a Script Closes Instantly — Here's Why

Sometimes when you run a script as admin, it flashes and closes immediately. That’s not a bug — it's Windows blocking it silently.

### Why it happens:
- The script is stored in **Desktop**, **Downloads**, or **OneDrive**
- It was downloaded or copied from another PC
- Windows marked it as **“untrusted”**

This mostly affects scripts run as administrator.

### How to fix it:
1. Create a safe folder like `C:\Scripts`
2. Move the `.bat` file there
3. Right-click it → Run as administrator

NOTE: Moving it into a subfolder of `C:\Scripts` may or may not fix the issue

After that, Windows usually trusts the script again, even if you move it back. Therefore, the hidden "trust" flag is removed once this is performed.

If it still won’t run, your PC may also be blocking it using SmartScreen or antivirus settings.
To check that:
   1. Right-click the file → Properties
   2. If you see an “Unblock” checkbox at the bottom, check it, click Apply, and try again

This is a separate setting from the hidden trust flag, but it can block files in a similar way.

---

## ✅ Summary of Security Choices

| Feature                                     | Used?   | Reason                             |
|---------------------------------------------|---------|------------------------------------|
| Auto-elevation with PowerShell or VBA       | ❌ No  | Too risky, often abused by malware |
| Admin elevation inside scripts              | ❌ No  | Messy and unreliable               |
| Shortcuts set to “Run as administrator”     | ❌ No  | Safer to let users decide          |
| Clear comments for admin-needed commands    | ✅ Yes | Lets you know what needs elevation |
| Right-click → Run as admin support          | ✅ Yes | Clean, safe, and expected behavior |

---

## ❓ Frequently Asked Questions (FAQ)

Q: Why does CMD prompt continuously scroll down when I scroll up? Is there a way to prevent this?

CMD will always scroll down to what's currently being dynamically rendered and displayed to the user whenever it updates the display with new content.

Currently, there is no way to prevent this in a controlled manner, until the script executes fully, pauses with a prompt to the user, or similar.
	- There may or may not be an update to fix this in the future.



Q: Why does the Graphical User Interface (GUI) font text shrink in CMD, even when not much text is visually displayed in CMD?

A: The terminal is adjusting dynamically based on how much content it 'thinks' it has to render, not just what gets displayed. This should not happen currently for any scripts.
For instance, even if a command like 'driveryquery' (which initialize large virtual output buffers, triggering the font shrink even if nothing is printed) has outputs redirected to files, it's still handled internally as a massive text operation, so CMD adapts visually to that.
	- This is not a concern unless:
		- It causes layout breaking (kind of rare)
		- You're optimizing for screen readability, in which case spacing or clear commands can be used, but it's generally not worth the trade-off.
Basically, it's kinda baked into how the shell window renders things. Note that batch scripting was created in 1981.

Therefore, it's not a crash, and it doesn't mess up your output.

Though, be forewarned that holding Ctrl+*Mouse Scroll Zoom In/Out* could cause display problems even if going back to the original zoom threshold you had when running the script. The display will likely break, and not show all details in the terminal. I recommend not zooming if possible.

However, if you must zoom out, a possible solution for things to not be permanently broken is to scroll to the bottom of the script and then zoom out. It is likely to show all text (or most of it) in the entire script, intact. If not, it may prevent only the text that is visible on-screen from 'vanishing'.

If the font text shrinks, it's likely because too many entries from a command or a combination of commands were generated from the system (too many scheduled tasks, drivers, etc.). This has not happened to me, however, please notify me if this is an issue for you (with output or a copy of it.
If this becomes a common issue, I may take into consideration adapting the scripts to ensure it works better for more users. The awkward font change is understandably more difficult and complex to work with, even when zooming in.



Q: Why didn't you put more commands together in scripts, versus splitting them up?

A: This was a constraint for design decisions for many reasons. Scripts that are overloaded (no programming pun intended) with too many commands and too much output crash when run with administrator privileges. While scripts may run as normal without admin privileges, they are needed to ensure every command runs (for some or all scripts).

Too many commands running back to back, along with too much output, can cause possible issues like resource bottlenecks and memory issues within CMD, causing it to unexpectedly close. This would prevents users from viewing the results.
	- Commands like wevtutil or full schtasks dumps flood stdout (the standard output), and are more prone to making a script crash.



Q: Why does CMD Prompt get stuck without updating to execute the rest of the script?

A: CMD may not always refresh its display to update the user on its actual current progress.
	- To fix this, pressing any key should refresh it. If the script finishes and a key is pressed to trigger a display refresh, it should update the contents, not exit the script.
		- Causes to this (which I can't confirm 100%) are CMD is an unfocused/background window (not clicked on and active (foreground window)), resizing the CMD window during execution, or process interruptions/resource overload on PC.



Q: Can you run two or more scripts at once?

A: Yes, you can run multiple .bat scripts in different CMD windows at the same time. However, results may vary depending on the scripts.
	- If they're read-only/reporting scripts, you're safe to run both at once.
	- If they alter settings (like dism, sfc, netsh, or power changes), run them one at a time to be safe.

I have not experimented much with what specific script combinations can run parallel. This may or may not be updated here in the future.



Q: Is there any convenience to running many scripts at once, and any recommendations to perform this effectively?

A: The scripts were designed to fit well on a standard PC monitor, where the text is not too far horizontally, that it requires CMD to be in full-screen to see everything.

	The scripts were designed with the ability to fit up to 4 CMD windows on-screen simultaneously, one per quarter quadrant, like shown below.
		- This is easily performed with Windows "Snap Assist" feature, to drag windows to edges or corners of the screen to snap them into place.
			- This is very effective in easily setting up CMD windows in quarters, halves, or on the entire screen. This should also be very effective for multi-monitor users.



Q: Why did the terminal (seemingly) close at the end when it was finished?

A: When the script finishes, it prompts you to close it with "Press any key to continue . . .". If you have anything in your clipboard from the copy function, and then right-click on your mouse, this will count as entering a key.
	- Copying anything to the clipboard can accidentally occur when clicking on and highlighting even a single character in the terminal (including when the mouse isn't hovering over the highlighted area and being right-clicked)
		- You can also prevent this by clicking and right-clicking a blank space (or multiple, without highlighting more than one row) in the terminal, which will clear your clipboard of a character, or 'key' so to speak. This will help if a user accidentally right-clicks.
	
	- Crashes should not occur, however, if a solution is not mentioned in this Q&A and it still occurs, please report it via my email on my GitHub Profile, or report the issue via GitHub on the repository itself.



Q: Why does pressing 'Ctrl+C' together ask me to cancel execution of the 'batch job' instead of copying text to my clipboard

A: Ctrl+C is the override function that replaces the traditional 'copy' shortcut key in the Command Prompt. If performed accidentally, a user can enter 'Y' or 'y' to resume execution of the script (there may be minor, uncommon exceptions causing a script to bug out and cancel tasks/close terminal itself, however).
	- Using Ctrl+C for the 'copy' function works as normal when right-clicking anywhere in CMD with your mouse when a section is highlighted, or using Ctrl+C when a section of text is highlighted.



Q: Why does CMD flash and never seemingly open to execute or show results of a shortcut/script?

A: Not all shortcut commands are designed to keep the terminal open (though it's very few of these, like the 'Enable Ultimate Performance Power Plan') on having been run and finished successfully.
If scripts are not located in a root folder of the C:/ drive, there may be issues getting the script to run at all.

It is important to ensure Windows SmartScreen is not blocking any of these items upon downloading them from GitHub. To unblock them, right-click properties of the main folder containing everything, and select 'Unblock' if the option is there. This will apply to all items within the folder.
Be sure to use the test script in this repository to test Windows Permissions/Administrator Privileges, as this is the most common issue.

---

## ⚠️ Disclaimer

Use these tools at your own discretion. Always read comments and headers before running shortcuts, and read the supplied documentation before running scripts. Most files are compressed/zipped to prevent accidental execution.

---

## 👤 Author

**Kyle Moore**  
*Creator and developer of this project*  
[GitHub: MooreKyle](https://github.com/MooreKyle)

---

This README will be expanded and improved over time as the project evolves.
