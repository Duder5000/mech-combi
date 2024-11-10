Set-Location -Path "F:\lancer_lcp"

Remove-Item -Path "F:\lancer_lcp\combi\*" -Recurse -Force

$lcp = "F:\lancer_lcp\combi.lcp"
if (Test-Path -Path $lcp) {
    Remove-Item -Path $lcp -Force
    Write-Output "Deleted old lcp"
} else {
    Write-Output "Old lcp ALREADY deleted"
}
Start-Sleep -Seconds 1

Copy-Item -Path "F:\lancer_lcp\lcp_manifest.json" -Destination "F:\lancer_lcp\combi" -Force
Copy-Item -Path "F:\lancer_lcp\lcp_list.txt" -Destination "F:\lancer_lcp\combi" -Force

Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "frames"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "core_bonuses"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "environments"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "npc_features"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "npc_templates"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "pilot_gear"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "reserves"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "systems"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "talents"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "weapons"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "statuses"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "mods"
Start-Sleep -Seconds 1
.\combi.ps1 -toCombi "actions"
Start-Sleep -Seconds 1

Copy-Item -Path "F:\lancer_lcp\json\ktb-data-1.2.3\tags.json" -Destination "F:\lancer_lcp\combi" -Force
Start-Sleep -Seconds 1

Compress-Archive -Path "F:\lancer_lcp\combi\*" -DestinationPath "F:\lancer_lcp\combi.zip"
Start-Sleep -Seconds 1

Rename-Item -Path "F:\lancer_lcp\combi.zip" -NewName "combi.lcp"
Start-Sleep -Seconds 1