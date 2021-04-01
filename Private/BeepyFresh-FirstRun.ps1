function BeepyFresh-FirstRun {
    param()

    begin {
        Write-Output "Checking for Autotask and SecretManagement Modules"
    }

    process {
        ## Test for Autotask module
        $AutotaskModule = Get-InstalledModule -name Autotask | Where { $_.version -eq "1.6.14" }

        if($AutotaskModule -ne $Null) {
            Install-Module -Name Autotask -RequiredVersion 1.6.14 -Force -Scope CurrentUser
        }

        ## Test for SecretManangement module
        $SecretManagementModule = Get-InstalledModule -name Microsoft.PowerShell.SecretManagement
         
        if($SecretManagementModule -ne $Null) {
            Install-Module -Name Microsoft.PowerShell.SecretManagement
        }
    }
}