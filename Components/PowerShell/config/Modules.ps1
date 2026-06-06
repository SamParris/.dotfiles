<#
.SYNOPSIS
    Imports PowerShell modules.
.DESCRIPTION
    Imports PowerShell modules used by the dotfiles environment.
    Installation is handled by bootstrap/Install-Modules.ps1.
#>
$Modules = @(
    @{
        Name = 'Terminal-Icons'
    }
)

foreach ($Module in $Modules) {
    if (Get-Module -ListAvailable -Name $Module.Name) {
        Import-Module -Name $Module.Name
    }
}