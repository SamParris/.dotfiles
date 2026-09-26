<#
.SYNOPSIS
    PSReadLine configurations.
#>

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key Tab -Function Complete