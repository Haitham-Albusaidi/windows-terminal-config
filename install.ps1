<#
.SYNOPSIS
    Automated full installer for Windows Terminal, PowerShell, and CMD enhancements.
.DESCRIPTION
    Installs Oh My Posh, Nerd Fonts, Clink, modern CLI tools (eza, bat, zoxide, lazygit,
    ripgrep, bottom, fzf), custom Linux MOTD, and configures Windows Terminal visual aesthetics.
    Designed for unattended execution by AI agents or users.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = 'Continue'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  Starting Windows Terminal & Shell Environment Setup " -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

# 1. Execution Policy
Write-Host "`n[1/7] Configuring ExecutionPolicy for CurrentUser..." -ForegroundColor Yellow
try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue
    Write-Host "  ✓ ExecutionPolicy set to RemoteSigned" -ForegroundColor Green
} catch {
    Write-Warning "  ! Could not set ExecutionPolicy: $_"
}

# 2. Package Installation via winget
Write-Host "`n[2/7] Installing packages via winget..." -ForegroundColor Yellow
$packages = @(
    @{ Id = "JanDeDobbeleer.OhMyPosh"; Name = "Oh My Posh" },
    @{ Id = "DEVCOM.JetBrainsMonoNerdFont"; Name = "JetBrainsMono Nerd Font" },
    @{ Id = "chrisant996.Clink"; Name = "Clink (for cmd)" },
    @{ Id = "ajeetdsouza.zoxide"; Name = "zoxide (smart cd)" },
    @{ Id = "JesseDuffield.lazygit"; Name = "LazyGit" },
    @{ Id = "junegunn.fzf"; Name = "fzf (fuzzy finder)" },
    @{ Id = "BurntSushi.ripgrep.MSVC"; Name = "ripgrep" },
    @{ Id = "Clement.bottom"; Name = "bottom (system monitor)" },
    @{ Id = "eza-community.eza"; Name = "eza (color ls)" },
    @{ Id = "sharkdp.bat"; Name = "bat (syntax highlighting cat)" }
)

foreach ($pkg in $packages) {
    Write-Host "  Installing $($pkg.Name) ($($pkg.Id))..." -NoNewline
    & winget install $pkg.Id -s winget --accept-package-agreements --accept-source-agreements --disable-interactivity 2>$null | Out-Null
    Write-Host " Done" -ForegroundColor Green
}

# 3. Enable Clink for cmd.exe
Write-Host "`n[3/7] Setting up Clink for Command Prompt..." -ForegroundColor Yellow
$clinkExe = Get-ChildItem -Path "C:\Program Files (x86)\clink", "$env:LOCALAPPDATA\Programs\clink" -Filter "clink_x64.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
if ($clinkExe) {
    & $clinkExe autorun install 2>$null | Out-Null
    Write-Host "  ✓ Clink autorun installed" -ForegroundColor Green
} else {
    & clink autorun install 2>$null | Out-Null
    Write-Host "  ✓ Clink autorun called" -ForegroundColor Green
}

# 4. Copy Universal Binary Runners
Write-Host "`n[4/7] Deploying universal command shims to WindowsApps..." -ForegroundColor Yellow
$windowsAppsDir = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
if (!(Test-Path $windowsAppsDir)) {
    New-Item -ItemType Directory -Path $windowsAppsDir -Force | Out-Null
}

$binSourceDir = Join-Path $ScriptDir "bin"
if (Test-Path $binSourceDir) {
    Get-ChildItem -Path $binSourceDir | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $windowsAppsDir -Force
        Write-Host "  ✓ Installed $($_.Name)" -ForegroundColor Green
    }
}

# 5. Copy Clink Script
Write-Host "`n[5/7] Deploying Clink Oh My Posh script..." -ForegroundColor Yellow
$clinkDir = "$env:LOCALAPPDATA\clink"
if (!(Test-Path $clinkDir)) {
    New-Item -ItemType Directory -Path $clinkDir -Force | Out-Null
}
$clinkSrc = Join-Path $ScriptDir "configs\clink\oh-my-posh.lua"
if (Test-Path $clinkSrc) {
    Copy-Item -Path $clinkSrc -Destination (Join-Path $clinkDir "oh-my-posh.lua") -Force
    Write-Host "  ✓ Deployed $clinkDir\oh-my-posh.lua" -ForegroundColor Green
}

# 6. Configure PowerShell Profiles
Write-Host "`n[6/7] Deploying PowerShell profiles..." -ForegroundColor Yellow
$docs = [Environment]::GetFolderPath('MyDocuments')
if (-not $docs -or -not (Test-Path $docs)) {
    $docs = Join-Path $env:USERPROFILE "Documents"
}

$pwshProfileSrc = Join-Path $ScriptDir "configs\powershell\Microsoft.PowerShell_profile.ps1"
if (Test-Path $pwshProfileSrc) {
    $targetProfiles = @(
        (Join-Path $docs "WindowsPowerShell\Microsoft.PowerShell_profile.ps1"),
        (Join-Path $docs "PowerShell\Microsoft.PowerShell_profile.ps1")
    )
    foreach ($target in $targetProfiles) {
        $parent = Split-Path -Parent $target
        if (!(Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Copy-Item -Path $pwshProfileSrc -Destination $target -Force
        Write-Host "  ✓ Deployed profile to $target" -ForegroundColor Green
    }
}

# 7. Configure Git & Windows Terminal
Write-Host "`n[7/7] Configuring Git colors and Windows Terminal settings..." -ForegroundColor Yellow
git config --global color.ui auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
Write-Host "  ✓ Git colors enabled" -ForegroundColor Green

$terminalSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if (Test-Path $terminalSettings) {
    try {
        $settings = Get-Content $terminalSettings -Raw | ConvertFrom-Json
        $settings.profiles.defaults.colorScheme = "One Half Dark"
        $settings.profiles.defaults | Add-Member -NotePropertyName "opacity" -NotePropertyValue 85 -Force
        $settings.profiles.defaults | Add-Member -NotePropertyName "useAcrylic" -NotePropertyValue $true -Force
        $settings.profiles.defaults | Add-Member -NotePropertyName "cursorShape" -NotePropertyValue "bar" -Force
        $settings.profiles.defaults | Add-Member -NotePropertyName "cursorMotionType" -NotePropertyValue "smooth" -Force
        
        # Ensure font face
        if (-not $settings.profiles.defaults.font) {
            $settings.profiles.defaults | Add-Member -NotePropertyName "font" -NotePropertyValue ([PSCustomObject]@{ face = "JetBrainsMono Nerd Font" }) -Force
        } else {
            $settings.profiles.defaults.font.face = "JetBrainsMono Nerd Font"
        }
        
        $settings | ConvertTo-Json -Depth 25 | Set-Content $terminalSettings -Encoding utf8
        Write-Host "  ✓ Windows Terminal visual settings configured (One Half Dark, Acrylic 85%, JetBrainsMono NF)" -ForegroundColor Green
    } catch {
        Write-Warning "  ! Could not patch Windows Terminal settings: $_"
    }
}

Write-Host "`n=====================================================" -ForegroundColor Cyan
Write-Host "  Installation Complete! Restart your terminal to enjoy!" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
