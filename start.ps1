. .\scripts\Set-Mappings.ps1

$json = Get-Content -Path .\ports.json -Raw | ConvertFrom-Json

foreach ( $entry in $json)
{
    Write-Host "Start mapping $($entry.name) entries"
    Set-Mappings -tcp $entry.tcp -udp $entry.udp -name $entry.name
}


Write-Host "Finished adding all"