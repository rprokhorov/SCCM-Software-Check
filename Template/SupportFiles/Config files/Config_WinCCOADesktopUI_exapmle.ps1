$Config = @{
    appVendor = "ETM Professional Control GmbH"
    appName = "WinCC OA Desktop UI"
    appVersion = "3.15.020"
    appDetectionVersion = "3.15.020"
    appDetectionName = "WinCC OA Desktop UI"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "WCCOAui"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии..."
        if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = Execute-Process -Path "$dirFiles\WinCC_OA_Desktop_UI_3.15.20-64.exe" -Parameters '/install /quiet /suppressboot /suppressresult /log C:\Windows\Logs\Software\WinCC_OA_Desktop_UI_3.15.20.log /lang:1049'
		}
		else {
			$mainExitCode = Execute-Process -Path "$dirFiles\WinCC_OA_Desktop_UI_3.15.20-86.exe" -Parameters '/install /quiet /suppressboot /suppressresult /log C:\Windows\Logs\Software\WinCC_OA_Desktop_UI_3.15.20.log /lang:1049'
		}
        
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'WinCC OA Desktop UI'
    }
}