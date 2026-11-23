# Modern Windows Terminal & Shell Environment

A curated, automated dotfiles and configuration suite that transforms **Windows Terminal**, **PowerShell**, and **Command Prompt (`cmd.exe`)** into a modern, colorful, and productive CLI environment with Oh My Posh, Nerd Fonts, Linux-style MOTD, and modern Rust-based command replacements.

---

## ðŸ¤– Instructions for AI Assistants (Antigravity, Cursor, etc.)

If you are an AI assistant tasked with installing this environment on a Windows machine, follow this single step:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
```

### What `install.ps1` does automatically:
1. Sets `RemoteSigned` execution policy for `CurrentUser`.
2. Installs required tools via `winget` in silent/non-interactive mode:
   - `JanDeDobbeleer.OhMyPosh` (Prompt engine)
   - `DEVCOM.JetBrainsMonoNerdFont` (Font with glyphs & icons)
   - `chrisant996.Clink` (Readline & Oh My Posh support for `cmd.exe`)
   - `ajeetdsouza.zoxide` (Smart directory jumping)
   - `JesseDuffield.lazygit` (Terminal UI for Git)
   - `junegunn.fzf` (Fuzzy finder)
   - `BurntSushi.ripgrep.MSVC` (Fast text search)
   - `Clement.bottom` (Graphical system monitor)
   - `eza-community.eza` (Modern, icon-rich `ls`/`dir`)
   - `sharkdp.bat` (Syntax-highlighted `cat`/`type`)
3. Automatically registers Clink with `cmd.exe` (`clink autorun install`).
4. Configures Git color output (`color.ui auto`, etc.).
5. Deploys universal command shims to `%LOCALAPPDATA%\Microsoft\WindowsApps`.
6. Deploys `oh-my-posh.lua` to `%LOCALAPPDATA%\clink\`.
7. Deploys profile scripts to Windows PowerShell (5.1) and PowerShell 7.
8. Configures Windows Terminal (`settings.json`) with `One Half Dark`, 85% acrylic glass transparency, and smooth bar cursor.

---

## ðŸš€ Quick Install (for Humans)

Clone this repository and run the installer in PowerShell as an administrator or current user:

```powershell
git clone https://github.com/Tankasuar/windows-terminal-config.git windows-terminal-config
cd windows-terminal-config
powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
```

Restart your terminal, and you're good to go!

---

## âš¡ Command Cheatsheet

| Command | Tool | What it does | Example |
| :--- | :--- | :--- | :--- |
| **`ls`** | `eza` | Color-coded file & directory listing with Nerd Font icons | `ls` |
| **`ll`** | `eza` | Detailed list with file sizes, permissions, and git status | `ll` |
| **`tree`** | `eza` | Visual colorful directory tree | `tree` |
| **`cat <file>`** | `bat` | File viewer with syntax highlighting and line numbers | `cat package.json` |
| **`z <folder>`** | `zoxide` | Jump anywhere instantly without typing long paths | `z MyProject` |
| **`zi`** | `zoxide` + `fzf` | Interactive fuzzy search directory picker | `zi` |
| **`lg`** | `lazygit` | Visual terminal dashboard for Git (staging, diffs, branches) | `lg` |
| **`rg "<text>"`** | `ripgrep` | Blazing-fast project-wide text search | `rg "apiKey"` |
| **`btm`** | `bottom` | Real-time interactive CPU, RAM, GPU, and process monitor | `btm` |
| **`fzf`** | `fzf` | Interactive fuzzy search utility | `fzf` |
| **`motd`** | Custom | Re-displays the colorful ASCII banner & Linux-style live system stats | `motd` |

---

## ðŸŽ¨ Visual Features

* **Glass Transparency:** Window background set to **85% opacity** with smooth Windows 11 acrylic frosted blur.
* **Smooth Animated Cursor:** Cursor set to a smooth gliding bar.
* **Color Palette:** **One Half Dark** theme for high-contrast, beautiful pastel CLI colors.
* **Font:** **JetBrainsMono Nerd Font** rendering Git branches, folder icons, and OS badges without broken boxes.

---

## ðŸ“ Repository Structure

```
.
â”œâ”€â”€ install.ps1                               # 1-click automated installer
â”œâ”€â”€ README.md                                 # Documentation & usage guide
â”œâ”€â”€ configs/
â”‚   â”œâ”€â”€ powershell/
â”‚   â”‚   â””â”€â”€ Microsoft.PowerShell_profile.ps1  # PSReadLine, Oh My Posh, zoxide, aliases
â”‚   â”œâ”€â”€ clink/
â”‚   â”‚   â””â”€â”€ oh-my-posh.lua                    # Clink autorun script & doskey bindings
â”‚   â””â”€â”€ windows-terminal/
â”‚       â””â”€â”€ settings-defaults.json            # Reference visual settings for Terminal
â””â”€â”€ bin/
    â”œâ”€â”€ motd.ps1                              # Linux-style live stats & ASCII art banner
    â”œâ”€â”€ motd.cmd                              # Universal runner for motd
    â”œâ”€â”€ ls.cmd                                # eza runner
    â”œâ”€â”€ ll.cmd                                # eza detailed runner
    â”œâ”€â”€ tree.cmd                              # eza tree runner
    â”œâ”€â”€ cat.cmd                               # bat runner
    â”œâ”€â”€ z.cmd                                 # zoxide runner
    â”œâ”€â”€ zi.cmd                                # zoxide interactive runner
    â”œâ”€â”€ lg.cmd                                # lazygit runner
    â”œâ”€â”€ lazygit.cmd                           # lazygit full runner
    â”œâ”€â”€ rg.cmd                                # ripgrep runner
    â”œâ”€â”€ btm.cmd                               # bottom runner
    â””â”€â”€ fzf.cmd                               # fzf runner
```

---

## ðŸ› ï¸ Manual Installation (Step-by-Step)

If you prefer to configure everything manually without using `install.ps1`:

1. **Install tools via winget:**
   ```powershell
   winget install JanDeDobbeleer.OhMyPosh DEVCOM.JetBrainsMonoNerdFont chrisant996.Clink ajeetdsouza.zoxide JesseDuffield.lazygit junegunn.fzf BurntSushi.ripgrep.MSVC Clement.bottom eza-community.eza sharkdp.bat -s winget
   ```

2. **Register Clink for Command Prompt:**
   ```cmd
   clink autorun install
   ```

3. **Deploy Scripts:**
   * Copy all files from `bin/` to `%LOCALAPPDATA%\Microsoft\WindowsApps\`
   * Copy `configs/clink/oh-my-posh.lua` to `%LOCALAPPDATA%\clink\oh-my-posh.lua`
   * Copy `configs/powershell/Microsoft.PowerShell_profile.ps1` to your Documents PowerShell folder:
     `%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`

4. **Set Font in Windows Terminal:**
   * In Windows Terminal Settings (`Ctrl + ,`) $\rightarrow$ **Defaults** $\rightarrow$ **Appearance**:
     * **Font face:** `JetBrainsMono Nerd Font`
     * **Color scheme:** `One Half Dark`
     * **Transparency:** `85%` + check *Enable acrylic material*
     * **Cursor:** `Bar` + `Smooth`

