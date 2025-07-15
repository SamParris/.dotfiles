<#
.SYNOPSIS
  Cross-platform PowerShell 7+ profile for productivity and fast startup.

.DESCRIPTION
  Loads environment variables, aliases, prompt, key bindings, and background update checks.
  Heavy tasks run in background jobs to avoid slowing shell startup.

.NOTES
#>

# ─── Prompt and Shell ────────────────────────────────────────────────────────
$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent)
$OhMyPoshTheme = Join-Path $RootPath "Components\OhMyPosh\OhMyPoshTheme.json"
If (Test-Path $OhMyPoshTheme) {
    oh-my-posh init pwsh --config $OhMyPoshTheme | Invoke-Expression
}
Else {
    Write-Warning "Oh-My-Posh theme not found at $OhMyPoshTheme"
}

# ─── Aliases ────────────────────────────────────────────────────────────────
Set-Alias -Name ping -Value Test-NetConnection
Set-Alias -Name whatis -Value Get-Help

# ─── PSReadLine Settings ────────────────────────────────────────────────────
Import-Module PSReadLine -ErrorAction SilentlyContinue

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab       -Function MenuComplete

# ─── Background Update Check (Winget) ───────────────────────────────────────
If ($IsWindows) {
    Start-ThreadJob -ScriptBlock {
        Try {
            $Updates = winget list --upgrade-available | Out-String
            If ($Updates -match "upgrades available") {
                $env:SOFTWARE_UPDATE_AVAILABLE = $true
            }
        }
        Catch {
            $env:SOFTWARE_UPDATE_AVAILABLE = $false
        }
    } | Out-Null
}

# ─── Import Custom Functions ────────────────────────────────────────────────
$FunctionLibrary = Join-Path $PSScriptRoot 'Functions.psm1'
If (Test-Path $FunctionLibrary) {
    Import-Module $FunctionLibrary -Force
}
Else {
    Write-Warning "Functions.psm1 not found at $FunctionLibrary"
}

# ─── Optional Modules ──────────────────────────────────────────────────────
ForEach ($Module in @('Terminal-Icons')) {
    Try {
        Import-Module $Module -ErrorAction Stop
    }
    Catch {
        Write-Warning "Optional module '$Module' not found. Run 'Install-Module $Module -Scope CurrentUser'"
    }
}