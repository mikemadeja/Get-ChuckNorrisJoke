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
    [ValidateSet(
    'animal', 'career', 'celebrity', 'dev', 'explicit', 'fashion', 'food', 'history', 'money', 'movie', 'music', 'political', 'religion', 'science', 'sport', 'travel')]
    $JokeType
)

function Get-RandomJokeType {
    <#
    .Description
    #If JokeType parameter is not used, then pick a random one...
    #>
    Write-Verbose -Message "Joke type not selected, random one being chosen..."
    $JokeTypes = Invoke-WebRequest -Uri "https://api.chucknorris.io/jokes/categories" | ConvertFrom-Json
    [System.Collections.ArrayList]$JokeTypes = $JokeTypes
    #Remove explicit to keep it PG...
    $JokeTypes.Remove("explicit")
    $JokeType = $JokeTypes | Get-Random
    Write-Verbose "Joke Type: $JokeType"
    Write-Output $JokeType
}

function Get-RandomJoke {
    <#
    .Description
    #Get the random joke...
    #>
    param (
        $JokeType
    ) 
    $Data = Invoke-WebRequest -Uri "https://api.chucknorris.io/jokes/random?category=$JokeType"  | ConvertFrom-Json
    Write-Output $Data.value
}

if (!$JokeType) {
    $JokeType = Get-RandomJokeType
}

Get-RandomJoke -JokeType $JokeType 
