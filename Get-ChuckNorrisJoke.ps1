<#
.SYNOPSIS

Get a random Chuck Norris joke from an API

.EXAMPLE

PS> .\Get-ChuckNorrisJoke.ps1

#>

[CmdletBinding()]
Param (
)


. .\Functions.ps1

Get-ChuckNorrisRandomJoke

Get-ChuckNorrisCategories

Get-ChuckNorrisFreeTextSearch -Query "Computer"