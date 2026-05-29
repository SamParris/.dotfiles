<#
.SYNOPSIS
    Installs the dotfiles PowerShell profile.
.DESCRIPTION
    Adds the dotfiles PowerShell profile loader to the current user's PowerShell profile.

    By default, this appends a dot-source line to the existing profile.

    Use -Backup to create a timestamped backup of the existing profile before changes.
.PARAMETER Backup
    Creates a timestamped backup of the existing PowerShell profile before modifying it.
.EXAMPLE
    .\bootstrap\Install-Profile.ps1
.EXAMPLE
    .\bootstrap\Install-Profile.ps1 -Backup -Verbose
#>

[CmdletBinding()]
param(
    [switch] $Backup
)

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SourceProfile = Join-Path $RepoRoot 'components/powershell/Profile.ps1'
$TargetProfile = $PROFILE

if (-not (Test-Path $SourceProfile)) {
    throw "Source profile not found: $SourceProfile"
}

$TargetProfileFolder = Split-Path -Parent $TargetProfile

if (-not (Test-Path $TargetProfileFolder)) {
    Write-Verbose "Creating profile folder: $TargetProfileFolder"
    New-Item -Path $TargetProfileFolder -ItemType Directory -Force | Out-Null
}

if ((Test-Path $TargetProfile) -and $Backup) {
    $BackupPath = "$TargetProfile.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Verbose "Backing up existing profile to: $BackupPath"
    Copy-Item -Path $TargetProfile -Destination $BackupPath -Force
}

$ProfileLine = ". '$SourceProfile'"

if (-not (Test-Path $TargetProfile)) {
    Write-Verbose "Creating profile file: $TargetProfile"
    New-Item -Path $TargetProfile -ItemType File -Force | Out-Null
}

$ExistingContent = Get-Content -Path $TargetProfile -Raw -ErrorAction SilentlyContinue

if ([string]::IsNullOrWhiteSpace($ExistingContent)) {
    $ExistingContent = ''
}

if (-not $ExistingContent.Contains($ProfileLine)) {
    Write-Verbose "Adding dotfiles profile loader to: $TargetProfile"

    Add-Content -Path $TargetProfile -Value ''
    Add-Content -Path $TargetProfile -Value '# Load dotfiles PowerShell profile'
    Add-Content -Path $TargetProfile -Value $ProfileLine
}
else {
    Write-Verbose "Dotfiles profile loader already exists in: $TargetProfile"
}

Write-Verbose "Profile install complete."