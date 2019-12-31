$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Ssms"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
		Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode = Execute-Process -Path "$dirFiles\%FileName%"  -Parameters "/install /quiet /norestart /log C:\Windows\Logs\Software\SQLManagementStudio_%appVersion%_(%appDetectionVersion%)_install.log"
        
        
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "$dirFiles\%FileName%"  -Parameters "/uninstall /quiet /norestart /log C:\Windows\Logs\Software\SQLManagementStudio_%appVersion%_(%appDetectionVersion%)_uninstall.log"
    }
}