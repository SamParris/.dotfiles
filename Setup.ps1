<#
.SYNOPSIS
.DESCRIPTION
.NOTES
#>

# Colour Codes
$Success_Colour = 'Green'
$Warning_Colour = 'DarkYellow'
$Changed_Colour = 'DarkYellow'
$Skipped_Colour = 'Cyan'
$Failure_Colour = 'DarkRed'

# Emoji Codes
$Checkmark_Emoji = "`u{2714} "
$Failure_Emoji = "`u{274c}"

# Status Counts
$Success_Count = 0
$Warning_Count = 0
$Changed_Count = 0
$Skipped_Count = 0
$Failure_Count = 0

#Functions required for Setup.ps1
Function Find-SymLink {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$FileName,

        [Parameter()]
        [System.String]$Path
    )
    Process {
        Get-ChildItem -Path $Path | Where-Object { $_.Name -eq "$FileName" -and $_.LinkType -eq 'SymbolicLink' }
    }

}

Function New-SymLink {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$Path,

        [Parameter(Mandatory)]
        [System.String]$Target
    )
    Begin {
        $ParamHash = @{
            Path   = $Path
            Target = $Target
            Type   = 'SymbolicLink'
        }
    }
    Process {
        New-Item @ParamHash -Force
    }
}

Function Find-InstalledSoftware {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$Software
    )
    Begin {
        $InstalledSoftware = (winget list | Out-String)
    }
    Process {
        If ($InstalledSoftware -match $Software) {
            Return $true
        }
        Else {
            Return $false
        }
    }
}

Write-Host "Running Dotfiles Setup ..."
Write-Host '--------------------------------------------------------'
Write-Host ' Checking Admin Rights ... ' -ForegroundColor Cyan -NoNewline
Try {
    $CurrentUser = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    If ($CurrentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "OK" -ForegroundColor $Success_Colour
    }
    Else {
        Write-Host "FAIL" -ForegroundColor $Failure_Colour
        Write-Host "Please rerun Setup.ps1 as an Administrator." -ForegroundColor $Failure_Colour
        Break
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host ' Checking Internet Connection ... ' -ForegroundColor Cyan -NoNewline
Try {
    If ((Test-Connection 'GitHub.com' -Quiet -Count 1) -eq $true) {
        Write-Host "OK" -ForegroundColor $Success_Colour
        $InternetConnection = $true
    }
    Else {
        Write-Host "WARNING (Some configurations will be skipped)." -ForegroundColor $Warning_Colour
        $InternetConnection = $false
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host '--------------------------------------------------------'

Write-Host "AutoHotKey | Detect Installation"
Try {
    If (Find-InstalledSoftware -Software AutoHotKey) {
        Write-Host "$Checkmark_Emoji [OK]" -ForegroundColor $Success_Colour
        $Success_Count ++
    }
    Else {
        $AHK_Installed = $false
        Write-Host "[WARNING] AutoHotKey Installed: False" -ForegroundColor $Warning_Colour
        $Warning_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "AutoHotKey | Install AutoHotKey"
Try {
    If ($AHK_Installed -eq $false) {
        winget install AutoHotKey.AutoHotKey -s winget --silent | Out-Null
        Write-Host "[CHANGED]" -ForegroundColor $Changed_Colour
        $Changed_Count ++
    }
    Else {
        Write-Host "[SKIPPED]" -ForegroundColor $Skipped_Colour
        $Skipped_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "AutoHotKey | Detect Symlink"
Try {
    $StartUpFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
    Push-Location  $StartUpFolder

    If (Find-SymLink -FileName UltimateKeyboard.ahk) {
        Write-Host "$Checkmark_Emoji [OK]" -ForegroundColor $Success_Colour
        Pop-Location
        $Success_Count ++
    }
    Else {
        $AHK_Symlink = $false
        Write-Host "[WARNING] AutoHotKey Symlink: False" -ForegroundColor $Warning_Colour
        Pop-Location
        $Warning_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "AutoHotKey | Setup Symlink"
Try {
    If ($AHK_Symlink -eq $false) {
        New-SymLink -Path $StartUpFolder\UltimateKeyboard.ahk -Target $PSScriptRoot\Components\AutoHotKey\UltimateKeyboard.ahk | Out-Null
        Write-Host "[CHANGED] AutoHotKey Symlink Setup" -ForegroundColor $Changed_Colour
        $Changed_Count ++
    }
    Else {
        Write-Host "[SKIPPED]" -ForegroundColor $Skipped_Colour
        $Skipped_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "Neovim | Detect Installation"
Try {
    If (Find-InstalledSoftware -Software Neovim) {
        Write-Host "$Checkmark_Emoji [OK]" -ForegroundColor $Success_Colour
        $Success_Count ++
    }
    Else {
        $Neovim_Installed = $false
        Write-Host "[WARNING] Neovim Installed: False" -ForegroundColor $Warning_Colour
        $Warning_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "Neovim | Install Neovim"
Try {
    If ($Neovim_Installed -eq $false) {
        winget install Neovim.Neovim -s winget --silent | Out-Null
        Write-Host "[CHANGED]" -ForegroundColor $Changed_Colour
        $Changed_Count ++
    }
    Else {
        Write-Host "[SKIPPED]" -ForegroundColor $Skipped_Colour
        $Skipped_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "Neovim | Detect Symlink"
Try {
    Push-Location  $ENV:LOCALAPPDATA

    If (Find-SymLink -FileName nvim) {
        Write-Host "$Checkmark_Emoji [OK]" -ForegroundColor $Success_Colour
        Pop-Location
        $Success_Count ++
    }
    Else {
        $Neovim_Symlink = $false
        Write-Host "[WARNING] Neovim Symlink: False" -ForegroundColor $Warning_Colour
        Pop-Location
        $Warning_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "Neovim | Setup Symlink"
Try {
    If ($Neovim_Symlink -eq $false) {
        New-SymLink -Path $ENV:LOCALAPPDATA\nvim -Target $PSScriptRoot\Components\nvim\ | Out-Null
        Write-Host "[CHANGED] Neovim Symlink Setup" -ForegroundColor $Changed_Colour
        $Changed_Count ++
    }
    Else {
        Write-Host "[SKIPPED]" -ForegroundColor $Skipped_Colour
        $Skipped_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "OhMyPosh | Detect Installation"
Try {
    If (Find-InstalledSoftware -Software OhMyPosh) {
        Write-Host "$Checkmark_Emoji [OK]" -ForegroundColor $Success_Colour
        $Success_Count ++
    }
    Else {
        $OhMyPosh_Installed = $false
        Write-Host "[WARNING] OhMyPosh Installed: False" -ForegroundColor $Warning_Colour
        $Warning_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host "OhMyPosh | Install OhMyPosh"
Try {
    If ($OhMyPosh_Installed -eq $false) {
        winget install JanDeDobbeleer.OhMyPosh -s winget --silent | Out-Null
        Write-Host "[CHANGED]" -ForegroundColor $Changed_Colour
        $Changed_Count ++
    }
    Else {
        Write-Host "[SKIPPED]" -ForegroundColor $Skipped_Colour
        $Skipped_Count ++
    }
}
Catch {
    $Error.Exception.Message
}

Write-Host '--------------------------------------------------------'
Write-Host '--------------------------------------------------------'
[PSCustomObject]@{

    Success = $Success_Count
    Warning = $Warning_Count
    Changed = $Changed_Count
    Skipped = $Skipped_Count
    Failed  = $Failure_Count
    Total   = $Success_Count + $Warning_Count + $Changed_Count + $Skipped_Count + $Error_Count

} | Format-Table