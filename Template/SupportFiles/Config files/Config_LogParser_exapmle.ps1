$Config = @{
    appVendor = "Microsoft"
    appName = "Log Parser"
    appVersion = "2.2"
    appDetectionVersion = "2.2"
    appDetectionName = "Log Parser"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\LogParser-2.2.msi" -Parameters "/qn"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		Remove-MSIApplications -Name 'Log Parser'
    }
}