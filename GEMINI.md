# User Terminal & Shell Preferences

Whenever setting up, configuring, or modifying the command line, terminal, or shell environments on Windows for this user:

- **Terminal Environment**:
  - Use **Windows Terminal** configured with **`One Half Dark`** color scheme, **85% acrylic frosted glass transparency**, and **smooth bar cursor**.
  - Font MUST be **`JetBrainsMono Nerd Font`** to prevent broken box glyphs.
- **Shells**:
  - **PowerShell**: Oh My Posh (`jandedobbeleer` default theme), PSReadLine predictive autocomplete (history-based inline view), and `RemoteSigned` execution policy.
  - **Command Prompt (`cmd.exe`)**: Enhanced via **Clink** (`clink autorun install`) with Oh My Posh and doskey aliases.
- **Startup Banner**:
  - Linux-style MOTD with multi-color gradient "HELLO WORLD" ASCII art and live system stats (OS, CPU threads, Memory, Disk C, Uptime).
- **Modern CLI Toolchain**:
  - `eza --icons=auto` for `ls`, `ll`, and `tree`
  - `bat` for `cat` (syntax-highlighted file viewing)
  - `zoxide` (`z` and `zi`) for smart directory jumping
  - `lazygit` (`lg`) for interactive Git
  - `ripgrep` (`rg`) for fast code searches
  - `bottom` (`btm`) for interactive system monitoring
- **Dotfiles & Automated Installer**:
  - User repository: `https://github.com/Haitham-Albusaidi/windows-terminal-config`
  - Single-command full installation on any new PC:
    `powershell.exe -ExecutionPolicy Bypass -File .\install.ps1`
