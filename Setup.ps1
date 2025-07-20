<#
.SYNOPSIS
.DESCRIPTION
.NOTES
#>
# --- Load XML Configuration ---
$ConfigPath = (Join-Path $PSScriptRoot 'Config.xml')
$ComponentsPath = (Join-Path $PSScriptRoot\Components\ 'Components.xml')

Function Import-XmlFile {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$Path
    )
    Begin {
        If (-Not (Test-Path $Path)) {
            Write-Host "Configuration XML file not found at: $Path" -ForegroundColor DarkRed
            exit 1
        }
    }
    Process {
        Try {
            [xml]$Xml = (Get-Content -Path $Path -ErrorAction Stop)
            Write-Host "Loaded xml configuration file: $Path" -ForegroundColor Green
            Return $Xml
        }
        Catch {
            Write-Host "Failed to parse Config.xml. Error: $_" -ForegroundColor DarkRed
            exit 1
        }
    }
}

$ConfigXml = (Import-XmlFile -Path $ConfigPath)
$ComponentsXml = (Import-XmlFile -Path $ComponentsPath)

If (-Not $ConfigXml.Configuration.Display.Colours -or -not $ConfigXml.Configuration.Display.Emoji) {
    Write-Host "Config.xml is missing required <Display> section." -ForegroundColor DarkRed
    exit 1
}

If (-Not $ComponentsXml.Configuration.Components.Component) {
    Write-Host "Components.xml is missing <Components><Component> entries." -ForegroundColor DarkRed
    exit 1
}

Function Expand-EnvVars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$Inputs
    )
    Try {
        $Expanded = $Inputs `
            -replace '%APPDATA%', $env:APPDATA `
            -replace '%LOCALAPPDATA%', $env:LOCALAPPDATA `
            -replace '%SCRIPTROOT%', $PSScriptRoot `
            -replace '%TEMP%', $env:TEMP

        Return $Expanded
    }
    Catch {
        Write-Verbose "Expand-EnvVars: Failed to expand input '$Inputs'. Error: $_"
        Return $Inputs  # Fallback: return unmodified input
    }
}

Function Find-SymLink {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$FileName,

        [Parameter(Mandatory)]
        [System.String]$Path
    )
    Begin {
        If (-Not (Test-Path -Path $Path)) {
            Write-Verbose "Find-SymLink: Path not found: $Path"
            Return $null
        }
    }
    Process {
        $Match = (Get-ChildItem -Path $Path -Force -ErrorAction Stop |
            Where-Object { $_.Name -eq $FileName -and $_.LinkType -eq 'SymbolicLink' })

        Try {
            If ($Match) {
                Write-Verbose "Find-SymLink: Found symlink '$FileName in $Path'"
                Return $Match
            }
            Else {
                Write-Verbose "Find-SymLink: No matching symlink found for '$FileName'"
                Return $null
            }
        }
        Catch {
            Write-Verbose "Find-SymLink: Error $_"
            Return $null
        }

    }
}

Function New-SymLink {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$Path,

        [Parameter(Mandatory)]
        [System.String]$Target
    )
    Begin {
        $LinkDir = (Split-Path $Path)
        $LinkFile = (Split-Path $Path -Leaf)
    }
    Process {
        Try {
            $ExistingLink = (Find-SymLink -FileName $LinkFile -Path $LinkDir)
            If ($ExistingLink) {
                If ($ExistingLink.Target -eq $Target) {
                    Write-Verbose "New-SymLink: Symlink already exists and points to the correct target."
                    Return $ExistingLink
                }
                Else {
                    Write-Verbose "New-SymLink: Symlink exists but points to a different target. Removing."
                    Remove-Item -Path $Path -Force -ErrorAction Stop
                }
            }
            ElseIf (Test-Path -Path $Path) {
                Write-Verbose "New-SymLink: Existing item at path is not a symlink. Removing."
                Remove-Item -Path $Path -Force -ErrorAction Stop
            }

            Write-Verbose "New-SymLink: Creating symlink from `"$Path`" to `"$Target`""
            $newLink = New-Item -ItemType SymbolicLink -Path $Path -Target $Target -Force -ErrorAction Stop
            Return $newLink
        }
        catch {
            Write-Warning "New-SymLink: Failed to create symbolic link. Error: $_"
            return $null
        }
    }
}

Function Find-InstalledSoftware {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String]$Software
    )
    Try {
        Write-Verbose "Checking if '$Software' is installed via winget..."
        $InstalledList = (winget list | Out-String)
        If ($InstalledList -match "(?i)$Software") {
            Write-Verbose "'$Software' appears to be installed."
            Return $true
        }
        Else {
            Write-Verbose "'$Software' was not found in installed packages."
            Return $false
        }
    }
    Catch {
        Write-Verbose "Error while checking software: $_"
        Return $false
    }
}

# --- Startup Checks ---
Write-Host " Checking Admin Rights " -ForegroundColor Cyan -NoNewline

$CurrentUser = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
If (-Not $CurrentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "FAIL" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Failure
    Write-Host "Please run as Administrator." -ForegroundColor $ConfigXml.Configuration.Display.Colours.Failure
    Exit 1
}
Else {
    Write-Host "OK" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Success
}

Write-Host " Checking Internet Connection " -ForegroundColor Cyan -NoNewline
If (-Not (Test-Connection 'github.com' -Quiet -Count 1)) {
    Write-Host "WARNING (Software installs will be skipped)" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Warning
    $InternetConnection = $false
}
Else {
    Write-Host "OK" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Success
    $InternetConnection = $true
}

# --- Components Setup ---
ForEach ($Component in $ComponentsXml.Configuration.Components.Component) {
    $Name = $Component.Name
    $WingetId = $Component.WingetId
    $HasSymlink = [Bool]$Component.HasSymlink

    Write-Host $Name
    $Installed = $false

    Try {
        $Installed = (Find-InstalledSoftware -Software $Name)
        If ($Installed) {
            Write-Host "Install Detected [OK]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Success
            $SuccessCounter ++
        }
        Else {
            Write-Host "Install Detected [WARNING]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Warning
            $WarningCounter ++
        }
    }
    Catch {
        Write-Host "ERROR: $_" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Failure
        $FailureCounter ++
    }

    Try {
        If (-Not $Installed -and $InternetConnection -eq $true) {
            winget install $WingetId -s winget --silent | Out-Null
            Write-Host "Software Installed [CHANGED]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Changed
            $ChangedCounter ++
        }
        Else {
            Write-Host "Software Installed [SKIPPED]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Skipped
            $SkippedCounter ++
        }
    }
    Catch {
        Write-Host "ERROR: $_" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Failure
        $FailureCounter ++
    }

    # Start of symlink checks and setup
    If ($HasSymlink) {
        $SymlinkNode = $ComponentsXml.Configuration.Symlinks.Symlink | Where-Object { $_.Component -eq $Name }

        If ($SymlinkNode) {
            $LinkPath = Expand-EnvVars $SymlinkNode.Path
            $TargetPath = Expand-EnvVars $SymlinkNode.Target
            $LinkDir = Split-Path $LinkPath
            $LinkFile = Split-Path $LinkPath -Leaf

            Try {
                $SymlinkExists = (Find-SymLink -FileName $LinkFile -Path $LinkDir)

                If ($SymlinkExists) {
                    Write-Host "Existing Symlink [OK]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Success
                    $SuccessCounter ++
                }
                Else {
                    Write-Host "Existing Symlink [WARNING]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Warning
                    $WarningCounter ++
                }
            }
            Catch {
                Write-Host "ERROR: $_" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Failure
                $FailureCounter ++
            }

            If (-Not $SymlinkExists) {
                Try {
                    New-SymLink -Path $LinkPath -Target $TargetPath | Out-Null
                    Write-Host "Existing Symlink [CHANGED]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Changed
                    $ChangedCounter ++
                }
                Catch {
                    Write-Host "ERROR: $_" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Failure
                    $FailureCounter ++
                }
            }
        }
    }
    Else {
        Write-Host "Symlink Not Required [SKIPPED]" -ForegroundColor $ConfigXml.Configuration.Display.Colours.Skipped
        $SkippedCounter ++
    }
}

Write-Host "--------------------------------------------------------"
[PSCustomObject]@{
    Success = $SuccessCounter
    Warning = $WarningCounter
    Changed = $ChangedCounter
    Skipped = $SkippedCounter
    Failed  = $FailureCounter
    Total   = $SuccessCounter + $WarningCounter + $ChangedCounter + $SkippedCounter + $FailureCounter
} | Format-Table -AutoSize