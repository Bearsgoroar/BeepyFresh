function BeepyFresh-Dashboard {
    param(
        $Data,
        [bool]$Tickets = $False
    )

    begin { 
        ## HTML Location
        $FilePath = $BeepyFreshSettings.OutputLocation

        ## Import CSS Formating
        ## Note, if statements are work around for me being unable to store $PSScriptRoot in JSON file
        if($BeepyFreshSettings.CSSTicketsTrue -match '$PSScriptRoot') {
            $CSSTicketsTrue  = @{ head = Get-Content "$PSScriptRoot\$($BeepyFreshSettings.CSSTicketsTrue -replace '$PSScriptRoot')" }
        }

        if($BeepyFreshSettings.CSSTicketsFalse -match '$PSScriptRoot') {
            $CSSTicketsFalse = @{ head = Get-Content "$PSScriptRoot\$($BeepyFreshSettings.CSSTicketsFalse -replace '$PSScriptRoot')" }
        }

        else {
            $CSSTicketsTrue  = @{ head = Get-Content $($BeepyFreshSettings.CSSTicketsTrue) }
            $CSSTicketsFalse = @{ head = Get-Content $($BeepyFreshSettings.CSSTicketsFalse) }
        }
    }

    process {
        switch($Tickets) {
            $True  { $Data | ConvertTo-Html @CSSTicketsTrue | Out-File -FilePath $FilePath -force }
            $False { $Data | ConvertTo-Html @CSSTicketsFalse | Out-File -FilePath $FilePath -force }
            
            ## This should never happen
            Default { Write-Host "Something went wrong" }
        }
    }
}