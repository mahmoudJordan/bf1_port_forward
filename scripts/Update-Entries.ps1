$elapsed = [System.Diagnostics.Stopwatch]::StartNew()
write-host "Started at $(get-date)"

Set-Location (Split-Path $MyInvocation.MyCommand.Path)

$json = Get-Content -Path ..\ports.json -Raw | ConvertFrom-Json

$jobs = @()

Write-Host "Start Mapping Games..."

foreach ($entry in $json) {
    $jobs += Start-Job -ScriptBlock {
        param (
            [int[]]$tcp,
            [int[]]$udp,
            [string]$name
        )

        # Import the Set-Mappings function
        . .\Set-Mappings.ps1

        Write-Host "Start mapping $($name) entries"
        Set-Mappings -tcp $tcp -udp $udp -name $name
    } -ArgumentList $entry.tcp, $entry.udp, $entry.name -Init ([ScriptBlock]::Create("Set-Location '$pwd'"))
}

# Wait for all jobs to finish
$jobs | Wait-Job

# Receive job results if needed
$jobs | Receive-Job

write-host "Finished adding all at $(get-date)"
write-host "Total Elapsed Time: $($elapsed.Elapsed.ToString())"
