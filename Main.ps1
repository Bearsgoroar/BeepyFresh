## API now requires TLS1.2 otherwise it won't work. This forces Powershell to use that
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

## Ensures environment is clean when restarting script
Get-Module | Where {$_.name -match "BeepyFresh"} | Remove-Module

## Import Modules
foreach($Module in $(GCI -r "$PSScriptRoot\Private")) {
    Write-Host "Importing" $Module
    Import-Module $Module.FullName
}

## Import Settings JSON
$Global:BeepyFreshSettings = Get-Content "$PSScriptRoot\Settings.json" | ConvertFrom-Json

## Load Credentials
$AutotaskCredentials = BeepyFresh-Credentials

## Imports required Modules
Import-Module Autotask -RequiredVersion 1.6.14 -ArgumentList $AutoTaskCredentials, $BeepyFreshAPIKey

## Connects to the WebAPI
Connect-AutotaskWebAPI -Credential $AutotaskCredentials -ApiTrackingIdentifier $BeepyFreshAPIKey

## Loops every PollInterval from Settings
while($i -ne 1) {
    
    ## Timer Start
    ## Uses PollInterval in Settings.json to keep things on  time
    ## Math: Time it took to run the loop minus PollInterval. See BeepyFresh-Clock for more
    BeepyFresh-Clock -Start
    
    ## Sets fields to blank and preps it
    $Fields = @()

    ## Gets our relevant tickets
    $Results = Get-AtwsTicket -Filter { AssignedResourceID -isnull -and (Status -eq 1 -or Status -eq 8 -or Status -eq 19)}

    ## If there are no results then there are no tickets and this bit is skipped
    if($Results -ne $Null) {
        
        ## Loops through all our results, filtering tickets, correcting time, etc etc
        foreach($Result in $Results) {
            ## Setting Skip to false for the below matches
            $Skip = $False

            ## Skipping the below results if the title matches one of the below
            switch($Result.Title) {
                {$_ -match 'PLACEHOLDER TEXT INCASE YOU WANT TO SKIP A TICKET BY SUBJECT LINE'} { $Skip = $True }
            }

            ## The actual skip if the above is true. Allows you to add multiple skip scenarios
            if($Skip -eq $True) { Continue }

            ## Formating our results
            $Field = $Null
            $Field = [pscustomobject]@{
                    TicketID = $($Result.TicketNumber)
                    Created  = $(($Result.CreateDate).addhours($BeepyFreshSettings.TimeOffset))
                    Subject  = $($Result.Title) -replace "^(.{0,$($BeepyFreshSettings.TruncateLength)}).*",'$1'
            }

            ## Builds the list of our tickets
            $Fields += $Field
        }

        ## Dashboard True
        if($Fields -ne $Null) {
            ## Create Dashboard
            BeepyFresh-Dashboard -Data $Fields -Tickets $True 
            
            ## Beeps
            BeepyFresh-Beep -Data $Fields[0]
        }
    }

    ## Dashboard False
    else {
        ## Create Dashboard
        BeepyFresh-Dashboard -Data $Fields -Tickets $False 
    }
    
    ## Timer Stop
    BeepyFresh-Clock -Stop
}


