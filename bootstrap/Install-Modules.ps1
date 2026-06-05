<#
.SYNOPSIS
    Installs required PowerShell modules.
.DESCRIPTION
    Installs PowerShell modules used by the dotfiles environment.
    Modules are installed for the current user only.
.EXAMPLE
    .\Install-Modules.ps1
.EXAMPLE
    .\Install-Modules.ps1 -Verbose
#>
[CmdletBinding()]
param()

$Modules = @(
    @{
        Name       = 'Terminal-Icons'
        Repository = 'PSGallery'
        Scope      = 'CurrentUser'
    }
)

foreach ($Module in $Modules) {
    if (Get-Module -ListAvailable -Name $Module.Name) {
        Write-Verbose "Module already installed: $($Module.Name)"
        continue
    }

    Write-Verbose "Installing module: $($Module.Name)"

    Install-Module -Name $Module.Name -Repository $Module.Repository -Scope $Module.Scope -Force
}