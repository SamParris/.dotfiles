function New-File {
<#
.SYNOPSIS
    Creates a new file.
.DESCRIPTION
    Creates a new file at the specified path. If the file already exists, it is left unchanged.
.PARAMETER Path
    The path of the file to create.
.EXAMPLE
    New-File -Path 'test.txt'
    Creates a file named test.txt in the current directory.
.EXAMPLE
    nf 'test.txt'
    Creates a file named test.txt in the current directory.
.EXAMPLE
    New-File -Path '.\docs\roadmap.md'
    Creates a file named roadmap.md in the docs directory.
#>
    [CmdletBinding()]
    [Alias('nf')]

    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    New-Item -Path $Path -ItemType File -Force
}

function New-Directory {
<#
.SYNOPSIS
    Creates a new directory.
.DESCRIPTION
    Creates a new directory at the specified path. If the directory already exists, it is left unchanged.
.PARAMETER Path
    The path of the directory to create.
.EXAMPLE
    New-Directory -Path 'test'
    Creates a directory named test in the current directory.
.EXAMPLE
    nd 'test'
    Creates a directory named test in the current directory.
.EXAMPLE
    New-Directory -Path '.\components\oh-my-posh'
    Creates an oh-my-posh directory under the components directory.
#>
    [CmdletBinding()]
    [Alias('nd')]

    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    New-Item -Path $Path -ItemType Directory -Force
}