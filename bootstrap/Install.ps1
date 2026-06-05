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
    [switch] $Backup
)

$BootstrapRoot = $PSScriptRoot

if (-not ($PSProfile -or $WezTerm)) {
    $PSProfile = $true
    $WezTerm = $true
}

if ($Profile) {
    & (Join-Path $BootstrapRoot 'Install-Profile.ps1') -Backup:$Backup -Verbose:$VerbosePreference
}

if ($WezTerm) {
    & (Join-Path $BootstrapRoot 'Install-WezTerm.ps1') -Backup:$Backup -Verbose:$VerbosePreference
}