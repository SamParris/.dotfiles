<#
.SYNOPSIS
    Configures Oh My Posh.
#>
$ThemePath = Join-Path $HOME '.dotfiles\components\ohmyposh\theme.omp.json'

if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    if (Test-Path $ThemePath) {
        oh-my-posh init pwsh --config $ThemePath | Invoke-Expression
    }
}