function Get-ChuckNorrisRandomJoke {
    <#
  .SYNOPSIS
  Gets a random Chuck Norris Joke

  .PARAMETER Name
  Get-ChuckNorrisRandomJoke

  .EXAMPLE
  Get-ChuckNorrisRandomJoke
  #>
    [CmdletBinding()]
    param (
        [bool]$RawOutput = $false
    )
    #https://api.chucknorris.io/jokes/random
    Write-Verbose -Message "Getting Chuck Norris Random Joke..."
    $Output = (Invoke-WebRequest -Uri "https://api.chucknorris.io/jokes/random" -Verbose: $false | ConvertFrom-Json)

    if ($RawOutput) {
        Write-Output $Output
    }
    else {
        New-ChuckNorrisObject -Output $Output
    }
}

function Get-ChuckNorrisCategories {
    <#
  .SYNOPSIS
  Gets a list of categories

  .PARAMETER Name
  Get-ChuckNorrisCategories

  .EXAMPLE
  Get-ChuckNorrisCategories
  #>
    [CmdletBinding()]
    param (
        [bool]$RawOutput = $false
    )
    #https://api.chucknorris.io/jokes/random
    Write-Verbose -Message "Getting Chuck Norris Categories..."
    $Output = (Invoke-WebRequest -Uri "https://api.chucknorris.io/jokes/categories" -Verbose: $false | ConvertFrom-Json)

    Write-Verbose -Message "Categories: $($Output -join ", ")"
    if ($RawOutput) {
        Write-Output $Output
    }
    else {
        $ObjectFinal = @()
        foreach ($Item in $Output) {

            $Object = [PSCustomObject]@{
                Category = $Item
            }
            $ObjectFinal += $Object
            $Item = $null
        }
        Write-Output $ObjectFinal
    }
}

function Get-ChuckNorrisJokeFromCategory {
    <#
  .SYNOPSIS
  Gets a joke from a specific category

  .PARAMETER Name
  Get-ChuckNorrisJokeFromCategory

  .EXAMPLE
  Get-ChuckNorrisJokeFromCategory -Category food
  #>
    [CmdletBinding()]
    param(
        $Category,
        [bool]$RawOutput = $false
    )
    $Categories = Get-ChuckNorrisCategories

    if ($Category -in $Categories.Category) {
        Write-Verbose -Message "$Catogory is in list of categories"
        $Output = (Invoke-WebRequest -Uri "https://api.chucknorris.io/jokes/random?category=$Category" -Verbose: $false | ConvertFrom-Json)

        if ($RawOutput) {
            Write-Output $Output 
        }
        else {
            New-ChuckNorrisObject -Output $Output
        }
    }
    else {
        Write-Error -Message "$Category is not in list of Categories, the categories are... $($Categories.Category -join ", ")"
    }
}

function Get-ChuckNorrisFreeTextSearch {
    <#
  .SYNOPSIS
  Searches through the Chuck Norris API for specific text

  .PARAMETER Name
  Get-ChuckNorrisFreeTextSearch

  .EXAMPLE
  Get-ChuckNorrisFreeTextSearch -Query "Windows 7"
  #>
    param(
        $Query,
        [bool]$RawOutput = $false
    )
    #https://api.chucknorris.io/jokes/search?query={query}
    Write-Verbose -Message "Getting Chuck Norris Jokes from Text Search..."
    $Output = (Invoke-WebRequest -Uri "https://api.chucknorris.io/jokes/search?query=$Query" -Verbose: $false | ConvertFrom-Json)
    if ($RawOutput) {
        Write-Output $Output
    }
    else {
        New-ChuckNorrisObject -Output $Output.result
    }
}

function New-ChuckNorrisObject {
    <#
  .SYNOPSIS
  Creates a PowerShell Object out of a API call

  .PARAMETER Name
  New-ChuckNorrisObject

  .EXAMPLE
  New-ChuckNorrisObject -Object $Object
  #>

    param (
        $Output
    )

    $ObjectFinal = @()

    foreach ($Item in $Output) {
        $Object = [PSCustomObject]@{
            Category  = $Item.categories
            CreatedAt = [datetime]$Item.created_at 
            IconUrl   = $Item.icon_url   
            Id        = $Item.id         
            UpdatedAt = [datetime]$Item.updated_at 
            URL       = $Item.url        
            Value     = $Item.value      
        }

        $ObjectFinal += $Object        
    }
    Write-Output $ObjectFinal
}