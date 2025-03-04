<#
.SYNOPSIS

Get a random Chuck Norris joke from an API

.EXAMPLE

PS> .\Get-ChuckNorrisJoke.ps1

.EXAMPLE

PS> .\Get-ChuckNorrisJoke.ps1 -JokeType dev
#>

[CmdletBinding()]
Param (
)


. .\Functions.ps1

Get-ChuckNorrisRandomJoke

Get-ChuckNorrisCategories

Get-ChuckNorrisFreeTextSearch -Query "Computer"