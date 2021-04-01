# BeepyFresh
## Requirements
#### Autotask PowerShell module version 1.6.14
    Install-Module -Name Autotask -RequiredVersion 1.6.14 -Force
	
#### Fonts
Install the two fonts in the CSS folder to the device that will be displaying the webpage
	
## Deployment
####
1. Download repository to device
2. Modify settings.json to fit your requirements
3. Run Main.ps1

## Settings file
- PollInterval - The controls how often the API is polled and how often a new html file is created
- StartOfDay - Can be in the format of 8:30pm, 08:00 but not 0800
- EndOfDay - Same as StartOfDay
- TimeOffset - For setting daylight savings or if the source from the API has the wrong time
- WarningBeep - Value is in minutes. If you have a 2 hour SLA and want to to beep 10 minutes before you would set it as 110
- BeepPitch - Minimum value 190 and Maximum value 8500
- BeepDuration - Minimum value 1 and Maximum value 10000
- TruncateLength - This controls the maximum length a Ticket Title/Subject can be on the Dashboard. If things are going offscreen adjust length accordingly.
- OutputLocation - Export loction of the html file
- CSSTicketsTrue - CSS location
- CSSTicketsFalse - CSS location

## Troubleshooting
**No beep sound is heard**
Beeps are generated from the PowerShell script, not the html page. The device running the script needs to be able to produce sound.
