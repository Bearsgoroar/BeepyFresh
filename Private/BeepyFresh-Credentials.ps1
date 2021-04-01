function BeepyFresh-Credentials {
    begin { 
        $Username = $BeepyFreshSettings.Username
        $Password = $BeepyFreshSettings.Password
        $TrackingID = $BeepyFreshSettings.TrackingID
    }

    process {
        ## TrackingID / API Key
        $Global:BeepyFreshAPIKey = $TrackingID
        
        ## Credentials
        $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $Credentials = New-Object -typename System.Management.Automation.PSCredential($Username, $SecurePassword)

        Return $Credentials
    }
}