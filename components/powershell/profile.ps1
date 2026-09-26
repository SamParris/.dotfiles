<#
.SYNOPSIS
    Loads my custom PowerShell environment.

.DESCRIPTION
    Loads aliases, configuration files, and custom functions from the
    PowerShell components folder.
#>

$PowerShellRoot = $PSScriptRoot

# Config
Get-ChildItem -Path (Join-Path $PowerShellRoot 'config') -Filter '*.ps1' -File |
    Sort-Object Name |
    ForEach-Object { . $_.FullName }

# Functions
Get-ChildItem -Path (Join-Path $PowerShellRoot 'functions') -Filter '*.ps1' -File |
    Sort-Object Name |
    ForEach-Object { . $_.FullName }