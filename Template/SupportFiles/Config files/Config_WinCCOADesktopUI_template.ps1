$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "WCCOAui"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии..."
        if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x64%" -Parameters '/install /quiet /suppressboot /suppressresult /log C:\Windows\Logs\Software\%appDetectionName% - %appVersion%.log /lang:1049'
		}
		else {
			$mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x86%" -Parameters '/install /quiet /suppressboot /suppressresult /log C:\Windows\Logs\Software\%appDetectionName% - %appVersion%.log /lang:1049'
		}
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name '%appDetectionName%'
    }
}