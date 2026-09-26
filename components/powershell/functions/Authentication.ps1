function Connect-Admin {
<#
.SYNOPSIS
    Stores an administrative credential for the current PowerShell session.
.DESCRIPTION
    Prompts for administrative credentials and stores them in memory for use by other helper functions during the current PowerShell session.
.PARAMETER TimeoutHours
    The number of hours before the stored credential expires.
.EXAMPLE
    Connect-Admin
.EXAMPLE
    admin
.EXAMPLE
    Connect-Admin -TimeoutHours 2
#>
    [CmdletBinding()]
    [Alias('admin')]

    param(
        [int] $TimeoutHours = 4
    )

    $Script:AdminCredential = Get-Credential
    $Script:AdminCredentialExpires = (Get-Date).AddHours($TimeoutHours)

    Write-Verbose "Administrative credential stored until $Script:AdminCredentialExpires."
}

function Disconnect-Admin {
<#
.SYNOPSIS
    Removes the stored administrative credential.
.DESCRIPTION
    Clears the stored administrative credential from the current PowerShell session.
.EXAMPLE
    Disconnect-Admin
.EXAMPLE
    adminoff
#>
    [CmdletBinding()]

    param()

    Remove-Variable -Name AdminCredential -Scope Script -ErrorAction SilentlyContinue
    Remove-Variable -Name AdminCredentialExpires -Scope Script -ErrorAction SilentlyContinue

    Write-Verbose 'Administrative credential removed.'
}

function Test-AdminCredential {
<#
.SYNOPSIS
    Tests whether an administrative credential is available.
.DESCRIPTION
    Returns true if an administrative credential exists and has not expired.
    Returns false if no credential exists or the stored credential has expired.
.EXAMPLE
    Test-AdminCredential
#>
    [CmdletBinding()]
    param()

    if (-not $Script:AdminCredential) {
        return $false
    }

    if ($Script:AdminCredentialExpires -and (Get-Date) -gt $Script:AdminCredentialExpires) {
        Disconnect-Admin
        return $false
    }

    return $true
}

function Get-AdminCredential {
<#
.SYNOPSIS
    Gets the stored administrative credential.
.DESCRIPTION
    Returns the stored administrative credential if one exists and has not expired.
    If no valid credential exists, an error is thrown.
.EXAMPLE
    Get-AdminCredential
#>
    [CmdletBinding()]
    param()

    if (-not (Test-AdminCredential)) {
        throw 'No valid administrative credential found. Run Connect-Admin first.'
    }

    return $Script:AdminCredential
}