<#
.SYNOPSIS
    Installs the WezTerm configuration.
.DESCRIPTION
    Creates a symbolic link from the user's WezTerm configuration file
    to the dotfiles repository.
.PARAMETER Backup
    Creates a timestamped backup of the existing configuration.
.EXAMPLE
    .\Install-WezTerm.ps1
.EXAMPLE
    .\Install-WezTerm.ps1 -Backup -Verbose
#>

[CmdletBinding()]
param(
    [switch] $Backup
)

. "$PSScriptRoot\Helpers\Backup.ps1"

$RepoRoot = Split-Path -Parent $PSScriptRoot

$SourceConfig = Join-Path $RepoRoot 'components\wezterm\wezterm.lua'
$TargetConfig = Join-Path $HOME '.wezterm.lua'

if (-not (Test-Path $SourceConfig)) {
    throw "Source configuration not found: $SourceConfig"
}

if (Test-Path $TargetConfig) {
    if ($Backup) {
        New-DotfilesBackup -Path $TargetConfig | Out-Null
    }

    Write-Verbose "Removing existing WezTerm configuration: $TargetConfig"
    Remove-Item -Path $TargetConfig -Force
}

Write-Verbose "Creating WezTerm symbolic link: $TargetConfig -> $SourceConfig"

New-Item `
    -ItemType SymbolicLink `
    -Path $TargetConfig `
    -Target $SourceConfig `
    -Force | Out-Null

Write-Verbose "WezTerm configuration installed"