function Unlock-AdUser {
<#
.SYNOPSIS
    Unlocks Active Directory user accounts.
.DESCRIPTION
    Unlocks a specific Active Directory user account when an identity is supplied.
    If no identity is supplied, all currently locked Active Directory user accounts are found and unlocked.
    This function uses the administrative credential stored by Connect-Admin.
.PARAMETER Identity
    The specific user account to unlock. If omitted, all locked accounts are unlocked.
.EXAMPLE
    Unlock jsmith
    Unlocks the jsmith account.
.EXAMPLE
    Unlock
    Finds and unlocks all currently locked Active Directory user accounts.
.EXAMPLE
    Unlock -Verbose
    Finds and unlocks all locked accounts, displaying each account as it is unlocked.
.EXAMPLE
    Unlock -WhatIf
    Shows which accounts would be unlocked without making changes.
#>
    [CmdletBinding(SupportsShouldProcess)]
    [Alias('unlock')]
    param(
        [Parameter(Position = 0)]
        [string] $Identity
    )

    if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
        throw 'ActiveDirectory module is not available.'
    }

    Import-Module ActiveDirectory

    $Credential = Get-AdminCredential

    $AdParameters = @{
        Credential = $Credential
    }

    if ($Identity) {
        Write-Verbose "Unlocking AD account: $Identity"

        if ($PSCmdlet.ShouldProcess($Identity, 'Unlock AD account')) {
            Unlock-ADAccount -Identity $Identity @AdParameters
        }

        return
    }

    $LockedUsers = Search-ADAccount -LockedOut -UsersOnly @AdParameters

    foreach ($User in $LockedUsers) {
        Write-Verbose "Unlocking AD account: $($User.SamAccountName)"

        if ($PSCmdlet.ShouldProcess($User.SamAccountName, 'Unlock AD account')) {
            Unlock-ADAccount -Identity $User.SamAccountName @AdParameters
        }
    }
}