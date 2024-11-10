param (
    [string]$toCombi = "frames"
)

$rootPath = "F:\lancer_lcp\json"
$outputFilePath = "F:\lancer_lcp\combi\$toCombi.json"

$combinedFrames = @()

Get-ChildItem -Path $rootPath -Recurse -Filter "$toCombi.json" | ForEach-Object {
    $jsonContent = Get-Content -Path $_.FullName -Raw | ConvertFrom-Json
    
    if ($jsonContent -is [System.Collections.IEnumerable]) {
        $combinedFrames += $jsonContent
    }
    else {
        $combinedFrames += @($jsonContent)
    }
}

$combinedFrames | ConvertTo-Json -Depth 10 | Set-Content -Path $outputFilePath