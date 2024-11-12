param (
    [string]$toCombi = "frames"
)

$rootPath = "F:\git\mech-combi\json"
$outputFilePath = "F:\git\mech-combi\combi\$toCombi.json"

# Find all matching files
$matchingFiles = Get-ChildItem -Path $rootPath -Recurse -Filter "$toCombi.json"

# Check if there's only one matching file
if ($matchingFiles.Count -eq 1) {
    # Only one file, copy it directly to the output path
    Copy-Item -Path $matchingFiles[0].FullName -Destination $outputFilePath
} 
else {
    # More than one matching file, proceed with combining
    $combinedFrames = @()
    
    $matchingFiles | ForEach-Object {
        $jsonContent = Get-Content -Path $_.FullName -Raw | ConvertFrom-Json
        
        if ($jsonContent -is [System.Collections.IEnumerable]) {
            $combinedFrames += $jsonContent
        }
        else {
            $combinedFrames += @($jsonContent)
        }
    }

    $combinedFrames | ConvertTo-Json -Depth 10 | Set-Content -Path $outputFilePath
}