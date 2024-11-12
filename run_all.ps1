Set-Location -Path "F:\git\mech-combi"

Remove-Item -Path "F:\git\mech-combi\combi\*" -Recurse -Force

$lcp = "F:\git\mech-combi\combi.lcp"
if (Test-Path -Path $lcp) {
    Remove-Item -Path $lcp -Force
    Write-Output "Deleted old lcp"
} else {
    Write-Output "Old lcp ALREADY deleted"
}

$uniqueJsonFileNames = New-Object System.Collections.Generic.HashSet[string]
$jsonPath = "F:\git\mech-combi\json"

Get-ChildItem -Path $jsonPath -Recurse -Filter "*.json" | ForEach-Object {
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    $uniqueJsonFileNames.Add($fileName) | Out-Null
}
$uniqueJsonFileNames | Sort-Object

foreach ($fileName in $uniqueJsonFileNames) {
    Write-Verbose "Processing file name: $fileName" -Verbose
    & .\combi.ps1 -toCombi $fileName -Verbose
}

# Change these to be generated
Copy-Item -Path "F:\git\mech-combi\lcp_manifest.json" -Destination "F:\git\mech-combi\combi" -Force -Verbose
Copy-Item -Path "F:\git\mech-combi\lcp_list.txt" -Destination "F:\git\mech-combi\combi" -Force -Verbose 

Compress-Archive -Path "F:\git\mech-combi\combi\*" -DestinationPath "F:\git\mech-combi\combi.zip" -Verbose

Rename-Item -Path "F:\git\mech-combi\combi.zip" -NewName "combi.lcp"

Write-Output "Done!"