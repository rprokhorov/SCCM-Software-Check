$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "kViewer"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = Execute-MSI -Action "Install" -Path "$dirFiles\x64\%FileName_x64%" -Parameters "/QN /norestart"
		}
		else {
			$mainExitCode = Execute-MSI -Action "Install" -Path "$dirFiles\x86\%FileName_x86%" -Parameters "/QN /norestart"
		}
        
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name '%appDetectionName%'
    }
}