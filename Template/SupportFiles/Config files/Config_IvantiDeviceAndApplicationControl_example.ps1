$Config = @{
    appVendor = "Ivanti"
    appName = "Device and Application Control"
    appVersion = "5.1.403"
    appDetectionVersion = "5.1.403"
    appDetectionName = "Device and Application Control"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = Execute-Process -Path "$dirFiles\x64\Client.exe"  -Parameters "/exenoui /qn /norestart TRANSFORMS=Client.x64.mst /L*v ""C:\Windows\Logs\Software\Ivanti Device and Application Control - 5.1.403.log"""
		}
		else {
			$mainExitCode = Execute-Process -Path "$dirFiles\x86\Client.exe"  -Parameters "/exenoui /qn /norestart TRANSFORMS=Client.mst /L*v ""C:\Windows\Logs\Software\Ivanti Device and Application Control - 5.1.403.log"""
		}
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'Ivanti'
    }
}