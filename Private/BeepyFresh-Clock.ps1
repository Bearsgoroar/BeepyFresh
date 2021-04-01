function BeepyFresh-Clock {
    param(
        [switch]$Start,
        [switch]$Stop
    )

    begin { 
        $DateTime = Get-Date
    }

    process {
        if($Start) {
            $Global:BeepyFreshStopwatch = $DateTime
            
            ## So you know where in the loop it's at and it's alive
            Write-Host "$(Get-Date -format yyyyMMddhhmmss) Ping" -ForegroundColor Green
        }

        if($Stop) {
            ## Using the different between StopwatchStart and StopwatchStop we can then substract that from our PollInterval to always keep it on time
            $StopwatchInterval = ($DateTime - $BeepyFreshStopwatch).Seconds
            $Timer             = $($BeepyFreshSettings.PollInterval - $StopwatchInterval)
            
            if($Timer -gt 0) {
                Start-Sleep $Timer
            }
            
            ## So you know where in the loop it's at and it's alive
            Write-Host "$(Get-Date -format yyyyMMddhhmmss) Pong - Loop time $StopwatchInterval seconds" -ForegroundColor Cyan
        }
    }
}