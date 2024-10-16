<#
.SYNOPSIS
.DESCRIPTION
.NOTES
#>

#Custom Variables
$DotfilesDir = "$HOME\.dotfiles"

#Aliases
Set-Alias -Name Ping -Value Test-NetConnection
Set-Alias -Name VS -Value code
Set-Alias -Name Push -Value Push-Location
Set-Alias -Name Pop -Value Pop-Location
Set-Alias -Name WhatIs -Value Get-Help

#PSReadLineKeyHandler
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

#PSReadLineOption
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionViewStyle ListView

#Prompt & Shell Configurations
Start-ThreadJob -ScriptBlock {
    Set-Location -Path $DotfilesDir
    $GitUpdates = git fetch && git status

    If ($GitUpdates -match "behind") {
        $ENV:DOTFILES_UPDATE_AVAILABLE = $true
    }
} | Out-Null

Start-ThreadJob -ScriptBlock {
    $WingetUpdatesString = Start-Job -ScriptBlock { winget list --upgrade-available | Out-String } | Wait-Job | Receive-Job

    If ($WingetUpdatesString -match "upgrades available") {
        $ENV:SOFTWARE_UPDATE_AVAILABLE = $true
    }
} | Out-Null

#Import Modules.
Import-Module -Name 'Terminal-Icons' -ErrorAction Stop

# Custom Functions
# ----------------------------------------------------------------------------------------------------------------------