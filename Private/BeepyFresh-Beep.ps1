function BeepyFresh-Beep {
    param(
        $Data
    )

    begin { 
        ## Date
        $CurrentTime = Get-Date

        ## Settings
        $StartOfDay  = Get-Date $BeepyFreshSettings.StartOfDay
        $EndOfDay    = Get-Date $BeepyFreshSettings.EndOfDay
                
    }

    process { 
        ## Gives us our work hours
        if(($CurrentTime -ge $StartOfDay) -and ($CurrentTime -le $EndOfDay)) { 

            switch($Data[0].Created) {
                ## WarningBeep1
                { $($Data[0].Created).AddMinutes($BeepyFreshSettings.WarningBeep) -lt $CurrentTime } {
                    [console]::beep($BeepyFreshSettings.BeepPitch,$BeepyFreshSettings.BeepDuration)
                    Break
                }

                <# WarningBeep2
                { $($Data[0].Created).AddMinutes(55) -lt $DateTime } {
                    [console]::beep($BeepyFreshSettings.BeepPitch,$BeepyFreshSettings.BeepDuration)
                    Break
                }
                #>
            }
        }
    }
}
