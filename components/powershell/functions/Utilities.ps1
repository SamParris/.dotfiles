function Open-Dotfiles {
<#
.SYNOPSIS
    Edit the main dotfiles folder.
.DESCRIPTION
    Simple function to open VSCode to edit the main dotfiles folder.
#>
    [CmdletBinding()]
    [Alias("dot")]
    Param(
    )

    code "$Home\.dotfiles"
}

function Update-Profile {
<#
.SYNOPSIS
    Reloads my current PowerShell profile.
.DESCRIPTION
    Reloads my current PowerShell profile into the running session.
#>
    [CmdletBinding()]
    [Alias("reload")]
    Param(
    )

    . $PROFILE
}

function Open-WezTermConfig {
<#
.SYNOPSIS
    Opens the WezTerm configuration.
.DESCRIPTION
    Opens the WezTerm configuration within VSCode
#>
    [CmdletBinding()]
    [Alias('wtconfig')]

    param(
    )

    code "$HOME\.dotfiles\components\wezterm\wezterm.lua"
}