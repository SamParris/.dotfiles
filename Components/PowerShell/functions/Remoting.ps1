function Connect-PSSession {
<#
.SYNOPSIS
    Starts a PowerShell remoting session.
.DESCRIPTION
    Starts an interactive PowerShell remoting session using Enter-PSSession.
.PARAMETER ComputerName
    The remote computer to connect to.
.PARAMETER Credential
    The credential to use for the remoting session.
.EXAMPLE
    Connect-PSSession -ComputerName SERVER01
    Prompts for credentials and connects to SERVER01.
.EXAMPLE
    pss SERVER01
    Prompts for credentials and connects to SERVER01.
.EXAMPLE
    pss SERVER01 -Credential $Credential
    Connects to SERVER01 using the supplied credential.
#>
    [CmdletBinding()]
    [Alias('pss')]

    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $ComputerName,

        [System.Management.Automation.PSCredential] $Credential
    )

    if (-not $Credential) {
        $Credential = Get-Credential
    }

    Enter-PSSession -ComputerName $ComputerName -Credential $Credential
}