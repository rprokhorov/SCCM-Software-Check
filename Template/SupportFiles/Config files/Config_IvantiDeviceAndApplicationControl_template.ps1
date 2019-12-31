$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = Execute-Process -Path "$dirFiles\x64\%FileName_x64%"  -Parameters "/exenoui /qn /norestart TRANSFORMS=Client.x64.mst /L*v ""C:\Windows\Logs\Software\Ivanti Device and Application Control - %appVersion%.log"""
		}
		else {
			$mainExitCode = Execute-Process -Path "$dirFiles\x86\%FileName_x86%"  -Parameters "/exenoui /qn /norestart TRANSFORMS=Client.mst /L*v ""C:\Windows\Logs\Software\Ivanti Device and Application Control - %appVersion%.log"""
		}
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'Ivanti'
    }
}