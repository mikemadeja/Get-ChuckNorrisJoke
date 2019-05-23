[CmdletBinding()]
Param (
    [ValidateSet('explicit','nerdy')]
    $JokeType
)

Function Get-RandomJokeType {
    Write-Verbose -Message "Joke type not selected, random one being chosen..."
    $JokeTypes = Invoke-WebRequest -Uri "http://api.icndb.com/categories" | ConvertFrom-Json
    $JokeType = $JokeTypes.Value | Get-Random
    Write-Output $JokeType
}

Function Get-RandomJoke {
    Param (
        $JokeType
    )
    $Data = Invoke-WebRequest -Uri "http://api.icndb.com/jokes/random?limitTo=[$JokeType]" | ConvertFrom-Json
    Write-Output ($Data.value.joke -replace "&quot;", "`"") 
}

If (!$JokeType) {
    $JokeType = Get-RandomJokeType
}

Write-Verbose -Message "Joke Type: $JokeType"
Get-RandomJoke -JokeType $JokeType 
