$e = [char]27
$c1 = "$e[38;2;97;175;239m"   # Soft Blue
$c2 = "$e[38;2;86;182;194m"   # Cyan
$c3 = "$e[38;2;122;136;207m"  # Indigo
$c4 = "$e[38;2;157;124;216m"  # Purple
$c5 = "$e[38;2;198;120;221m"  # Magenta
$c6 = "$e[38;2;224;108;117m"  # Coral

$label = "$e[1;38;2;86;182;194m"
$val = "$e[38;2;220;223;228m"
$dim = "$e[38;2;92;99;112m"
$rst = "$e[0m"

# OS info
$reg = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue
$osName = if ($reg) { "Windows 11 ($($reg.DisplayVersion), Build $($reg.CurrentBuildNumber))" } else { "Windows 11" }

# CPU info
$cpu = (Get-ItemProperty "HKLM:\HARDWARE\DESCRIPTION\System\CentralProcessor\0" -ErrorAction SilentlyContinue).ProcessorNameString.Trim()
$cores = $env:NUMBER_OF_PROCESSORS

# Memory & Uptime from OperatingSystem (fast single query)
$ramStr = "N/A"
$uptime = "N/A"
$os = Get-CimInstance -ClassName Win32_OperatingSystem -Property TotalVisibleMemorySize, FreePhysicalMemory, LastBootUpTime -ErrorAction SilentlyContinue
if ($os) {
    # Memory
    $totGB = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
    $freeGB = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
    $usedGB = [math]::Round($totGB - $freeGB, 1)
    $memPct = [math]::Round(($usedGB / $totGB) * 100)
    $ramStr = "${usedGB} GB / ${totGB} GB (${memPct}% used)"

    # Uptime
    if ($os.LastBootUpTime) {
        $ts = (Get-Date) - $os.LastBootUpTime
        $days = [math]::Floor($ts.TotalDays)
        $hours = $ts.Hours
        $mins = $ts.Minutes
        if ($days -gt 0) {
            $uptime = "$days days, $hours hours, $mins mins"
        } elseif ($hours -gt 0) {
            $uptime = "$hours hours, $mins mins"
        } else {
            $uptime = "$mins mins"
        }
    }
}

# Fallback uptime if CIM failed
if ($uptime -eq "N/A") {
    $tick = [System.Environment]::TickCount
    if ($tick -lt 0) { $tick = [long]$tick + 0x100000000L }
    $ts = [System.TimeSpan]::FromMilliseconds($tick)
    $days = [math]::Floor($ts.TotalDays)
    $hours = $ts.Hours
    $mins = $ts.Minutes
    if ($days -gt 0) {
        $uptime = "$days days, $hours hours, $mins mins"
    } else {
        $uptime = "$hours hours, $mins mins"
    }
}

# Disk C:
try {
    $drive = [System.IO.DriveInfo]::new('C')
    $dFree = [math]::Round($drive.AvailableFreeSpace / 1GB, 1)
    $dTot = [math]::Round($drive.TotalSize / 1GB, 1)
    $dPct = [math]::Round((($dTot - $dFree) / $dTot) * 100)
    $diskStr = "${dFree} GB free / ${dTot} GB (${dPct}% used)"
} catch {
    $diskStr = "N/A"
}

$dateStr = Get-Date -Format "ddd MMM dd HH:mm:ss yyyy"

Write-Host ""
Write-Host "$c1 ██╗  ██╗███████╗██╗     ██╗      ██████╗     ██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗ $rst"
Write-Host "$c2 ██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗$rst"
Write-Host "$c3 ███████║█████╗  ██║     ██║     ██║   ██║    ██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║$rst"
Write-Host "$c4 ██╔══██║██╔══╝  ██║     ██║     ██║   ██║    ██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║$rst"
Write-Host "$c5 ██║  ██║███████╗███████╗███████╗╚██████╔╝    ╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝$rst"
Write-Host "$c6 ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝      ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ $rst"
Write-Host ""
Write-Host "   $dim System information as of $dateStr $rst"
Write-Host ""
Write-Host "   $label   OS:       $val $osName$rst"
Write-Host "   $label   CPU:      $val $cpu $dim($cores threads)$rst"
Write-Host "   $label 󰘚  Memory:   $val $ramStr$rst"
Write-Host "   $label 󰋊  Disk (C): $val $diskStr$rst"
Write-Host "   $label   Uptime:   $val $uptime$rst"
Write-Host ""
