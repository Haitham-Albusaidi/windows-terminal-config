# Show Linux-style MOTD banner on startup
if (Test-Path "$env:LOCALAPPDATA\Microsoft\WindowsApps\motd.ps1") {
    & "$env:LOCALAPPDATA\Microsoft\WindowsApps\motd.ps1"
}
function motd { & "$env:LOCALAPPDATA\Microsoft\WindowsApps\motd.ps1" }

# Ensure winget portable packages and apps are in PATH
$extraPaths = @(
    "$env:LOCALAPPDATA\Microsoft\WindowsApps",
    "C:\Program Files\fzf\bin",
    "$env:LOCALAPPDATA\Apps\bottom\bin"
)
foreach ($p in $extraPaths) {
    if ((Test-Path $p) -and ($env:PATH -notlike "*$p*")) {
        $env:PATH = "$p;$env:PATH"
    }
}

# Oh My Posh initialization (uses built-in default theme)
oh-my-posh init pwsh | Invoke-Expression

# Predictive autocomplete (for PSReadLine 2.2.0+)
Import-Module PSReadLine -ErrorAction SilentlyContinue
$psrl = Get-Module PSReadLine
if ($psrl -and $psrl.Version -ge [Version]'2.2.0') {
    Set-PSReadLineOption -PredictionSource History -ErrorAction SilentlyContinue
    Set-PSReadLineOption -PredictionViewStyle InlineView -ErrorAction SilentlyContinue
    Set-PSReadLineKeyHandler -Key Tab -Function Complete -ErrorAction SilentlyContinue
    Set-PSReadLineKeyHandler -Key RightArrow -Function AcceptSuggestion -ErrorAction SilentlyContinue
}

# Zoxide smart directory jumping (z and zi)
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# Modern colorful CLI replacements (eza, bat, lazygit)
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Remove-Item alias:ls -ErrorAction SilentlyContinue
    Remove-Item alias:dir -ErrorAction SilentlyContinue
    function ls { eza --icons=auto $args }
    function dir { eza --icons=auto $args }
    function ll { eza -la --icons=auto --git $args }
    function tree { eza --tree --icons=auto $args }
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Remove-Item alias:cat -ErrorAction SilentlyContinue
    function cat { bat $args }
}

if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-Alias -Name lg -Value lazygit -Option AllScope -Scope Global -Force
}
