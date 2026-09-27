function New-DotfilesBackup {
<#
.SYNOPSIS
    Creates a timestamped backup of a file.
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    if (-not (Test-Path $Path)) {
        Write-Verbose "No backup needed. File does not exist: $Path"
        return
    }

    $BackupPath = "$Path.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"

    Write-Verbose "Creating backup: $BackupPath"

    Copy-Item -Path $Path -Destination $BackupPath -Force

    return $BackupPath
}