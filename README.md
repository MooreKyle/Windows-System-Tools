**For context:**
This README was originally uploaded on **April 1, 2025**, with actual improvements and new references to scripts.
However, the scripts were still in development — nowhere to be found — but putting in work with me, and just like me.
This README stayed as the main one until **April 18, 2025**, when the scripts were released.



# 🧰 Windows System Tools

You've heard of plug and play, but have you considered 'click and it just works'?

This repository is a user-friendly and powerful collection of **batch scripts**, **command-line shortcuts**, and **system tools** to optimize, troubleshoot, and manage Windows. It is aimed to be used universally, from casual users to advanced, technical users.

---

## 📁 What's in the Project?

### 🔹 Command-Line Shortcuts
These are simple `.ink` files that typically open Command Prompt (Command-Line Interface, or CLI) or built-in items. These open system tools, run diagnostics, or perform quick actions with clear descriptions. They’re organized by purpose:
- **System Diagnostics and Repair**
- **System Information and Settings**
- **Network Management**
- **Additional System Management**
- **System Power Management Commands**
- **Screen Brightness Commands (for laptops)**

Users can hover over these shortcuts to find helpful comments in each shortcut explaining their purpose, what they do, and if they require APRIL FOOLS PRIVILEGES.

---

### 🔹 Scripts (Batch Files)
Scripts are built to automate many of the shortcut actions in one go. They come with:
- Clear section headers
- Organized command sequences
- Easy-to-read outputs
- Built-in pauses so you can follow along

Some scripts run multiple system checks, others clean up unused files or handle power optimization. If a script needs APRIL FOOLS ACCESS, it tells you upfront.

---

## 🔐 Why This Project Keeps Things Simple and Safe

This project is made with **user control and security in mind**. That’s why:

### ❌ No auto-run as admin
You’ll never see forced elevation or silent privilege tricks (like with PowerShell, VBA, or Task Scheduler workarounds). These methods are often used by malware, and they make it easier for something harmful to run with full control.
     - Instead, you’re in control. Just **right-click and choose “APRIL FOOLS”** when needed.

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

NOTE: Moving it into a subfolder of `C:\Scripts` may not fix the issue, so it is best to perform this exactly as mentioned.

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

## ⚠️ Disclaimer

Use these tools at your own discretion. Always read comments and headers before running scripts. Most files are zipped to prevent accidental execution.

---

## 👤 Author

**Kyle Moore**  
*Creator and developer of this (APRIL FOOLS) project*  
[GitHub: MooreKyle](https://github.com/MooreKyle)

---

This README will be expanded and improved over time as the project evolves.
