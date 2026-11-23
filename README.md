# Windows Terminal, PowerShell & CMD Setup

My personal dotfiles and configuration to make Windows Terminal, PowerShell, and Command Prompt (`cmd.exe`) look great and feel fast.

It includes:
- **Oh My Posh** prompt with custom icons and git status.
- **JetBrainsMono Nerd Font** so icons render properly without missing glyph boxes.
- **Linux-style MOTD**: Shows an ASCII "HELLO WORLD" banner and system stats (OS, CPU, RAM, Disk, Uptime) when opening a tab.
- **Clink**: Brings history auto-suggestions, Oh My Posh, and readline shortcuts into classic `cmd.exe`.
- **Modern CLI replacements**:
  - `eza` for colorful `ls` / `ll` / `tree` with icons.
  - `bat` for syntax-highlighted `cat`.
  - `zoxide` (`z`) for jumping between directories quickly.
  - `lazygit` (`lg`) for an interactive terminal Git UI.
  - `ripgrep` (`rg`) for fast code searches.
  - `bottom` (`btm`) for a terminal-based system/process monitor.
  - `delta` for syntax-highlighted, word-level Git diffs.
  - `dust` for an interactive, visual disk space analyzer.
  - `tldr` for quick practical examples of any command.
- **Smart History Navigation**: Up/Down Arrow automatically matches the prefix of whatever you started typing.
- **`open .` Shortcut**: Quickly opens the current directory in Windows File Explorer.
- **Windows Terminal Styling**: One Half Dark theme, 85% acrylic frosted glass background, tab accent colors, and smooth cursor animation.

---

## Quick Setup

Clone the repo and run the installer script in PowerShell:

```powershell
git clone https://github.com/Haitham-Albusaidi/windows-terminal-config.git
cd windows-terminal-config
powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
```

Once it finishes, restart Windows Terminal and everything will be active.

---

## Daily Shortcuts & Commands

| Command | What it does | Example |
| :--- | :--- | :--- |
| `ls` | Colorized directory listing with icons | `ls` |
| `ll` | Detailed list with file sizes, permissions, and git status | `ll` |
| `tree` | Visual directory tree | `tree` |
| `cat <file>` | View file contents with syntax highlighting and line numbers | `cat package.json` |
| `open [dir]` | Open any directory (or current folder with `open .`) in File Explorer | `open .` |
| `z <folder>` | Jump to any recently visited directory without full paths | `z MyProject` |
| `zi` | Interactive fuzzy folder picker | `zi` |
| `lg` | Open LazyGit visual interface (press `q` to exit) | `lg` |
| `rg "<text>"` | Fast text search across files in the project | `rg "API_KEY"` |
| `btm` | Live graphical CPU/RAM/process monitor (press `q` to exit) | `btm` |
| `dust` | Visual tree of what files and folders are taking up disk space | `dust` |
| `tldr <cmd>` | Practical cheatsheet examples for any command | `tldr git commit` |
| `git diff` | Syntax-highlighted word-level diff viewer via Delta | `git diff` |
| `motd` | Re-print the startup banner and live system stats | `motd` |

---

## What's in this Repo?

```text
windows-terminal-config/
├── install.ps1                               # 1-click installer script
├── README.md                                 # This file
├── configs/
│   ├── powershell/
│   │   └── Microsoft.PowerShell_profile.ps1  # PowerShell profile (history autocomplete, aliases, prompt)
│   ├── clink/
│   │   └── oh-my-posh.lua                    # Clink autorun script for cmd.exe
│   └── windows-terminal/
│       └── settings-defaults.json            # Reference visual settings (acrylic, font, cursor)
└── bin/
    ├── motd.ps1                              # MOTD banner & live system stats script
    ├── motd.cmd                              # Command runner for motd
    ├── ls.cmd                                # eza wrapper
    ├── ll.cmd                                # eza detailed wrapper
    ├── tree.cmd                              # eza tree wrapper
    ├── cat.cmd                               # bat wrapper
    ├── open.cmd                              # explorer.exe wrapper
    ├── z.cmd                                 # zoxide wrapper
    ├── zi.cmd                                # zoxide interactive wrapper
    ├── lg.cmd / lazygit.cmd                  # lazygit wrapper
    ├── rg.cmd                                # ripgrep wrapper
    ├── btm.cmd                               # bottom wrapper
    ├── dust.cmd                              # dust wrapper
    ├── tldr.cmd                              # tldr wrapper
    ├── delta.cmd                             # delta wrapper
    └── fzf.cmd                               # fzf wrapper
```

---

## Manual Setup (If you prefer doing it by hand)

If you'd rather not run `install.ps1` and want to set things up manually:

1. **Install the tools via winget:**
   ```powershell
   winget install JanDeDobbeleer.OhMyPosh DEVCOM.JetBrainsMonoNerdFont chrisant996.Clink ajeetdsouza.zoxide JesseDuffield.lazygit junegunn.fzf BurntSushi.ripgrep.MSVC Clement.bottom eza-community.eza sharkdp.bat dandavison.delta bootandy.dust dbrgn.tealdeer -s winget
   ```

2. **Register Clink for CMD:**
   ```cmd
   clink autorun install
   ```

3. **Configure Git with Delta:**
   ```cmd
   git config --global core.pager "delta"
   git config --global interactive.diffFilter "delta --color-only"
   git config --global delta.navigate true
   git config --global delta.line-numbers true
   git config --global delta.syntax-theme "OneHalfDark"
   ```

4. **Copy the scripts & configs:**
   * Copy everything in `bin/` to `%LOCALAPPDATA%\Microsoft\WindowsApps\`
   * Copy `configs/clink/oh-my-posh.lua` to `%LOCALAPPDATA%\clink\oh-my-posh.lua`
   * Copy `configs/powershell/Microsoft.PowerShell_profile.ps1` to:
     `%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
     *(and to `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` if using PowerShell 7)*

5. **Configure Windows Terminal:**
   * Open Settings (`Ctrl + ,`) -> **Defaults** -> **Appearance**:
     * **Font face**: `JetBrainsMono Nerd Font`
     * **Color scheme**: `One Half Dark`
     * **Transparency**: Set opacity to `85%` and check `Enable acrylic material`
     * **Cursor**: Set cursor shape to `Bar` and motion to `Smooth`

---

## Instructions for AI Assistants (Antigravity, Cursor, etc.)

If you are an AI assistant tasked with installing this configuration on a new machine:

1. Clone this repository to a local directory:
   ```cmd
   git clone https://github.com/Haitham-Albusaidi/windows-terminal-config.git
   ```
2. Run the automated installer:
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File .\windows-terminal-config\install.ps1
   ```
3. The script handles all package installations, file copies, registry autoruns, and terminal settings automatically and idempotently.
