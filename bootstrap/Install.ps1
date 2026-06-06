<#
.SYNOPSIS
    Installs the dotfiles environment.
.DESCRIPTION
    Runs selected bootstrap installers for the dotfiles repository.
#>

[CmdletBinding()]
param(
    [switch] $PSProfile,
    [switch] $WezTerm,
    [switch] $Modules,
    [switch] $Backup
)

$BootstrapRoot = $PSScriptRoot

if (-not ($PSProfile -or $WezTerm -or $Modules)) {
    $PSProfile = $true
    $WezTerm = $true
    $Modules = $true
}

if ($Modules) {
    & (Join-Path $BootstrapRoot 'Install-Modules.ps1') -Verbose:$VerbosePreference
}

if ($PSProfile) {
    & (Join-Path $BootstrapRoot 'Install-Profile.ps1') -Backup:$Backup -Verbose:$VerbosePreference
}

if ($WezTerm) {
    & (Join-Path $BootstrapRoot 'Install-WezTerm.ps1') -Backup:$Backup -Verbose:$VerbosePreference
}