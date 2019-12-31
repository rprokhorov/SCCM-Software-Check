$Config = @{
    appVendor ="Microsoft"
    appName = "SQL Server Management Studio"
    appVersion = "18.4"
    appDetectionVersion = "15.0.18206.0"
    appDetectionName = "SQL Server Management Studio"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Ssms"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
		Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode = Execute-Process -Path "$dirFiles\SSMS-Setup-ENU-18.4.exe"  -Parameters "/install /quiet /norestart /log C:\Windows\Logs\Software\SQLManagementStudio_%appVersion%_()_install.log"        
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'SQL Server Management Studio'
    }
}