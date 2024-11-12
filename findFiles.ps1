param (
    [string]$folderPath = "F:\git\mech-combi\json"
)

$uniqueJsonFileNames = New-Object System.Collections.Generic.HashSet[string]

Get-ChildItem -Path $folderPath -Recurse -Filter "*.json" | ForEach-Object {
    $fileName = $_.Name
    $uniqueJsonFileNames.Add($fileName) | Out-Null
}

$uniqueJsonFileNames | Sort-Object