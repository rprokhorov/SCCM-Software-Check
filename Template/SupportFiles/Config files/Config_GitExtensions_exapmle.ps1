$Config = @{
    appVendor = "Git Extensions Team"
    appName = "Git Extensions"
    appVersion = "3.3"
    appDetectionVersion = "3.3.0.7719"
    appDetectionName = "Git Extensions"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "GitExtensions"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
		Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\Git-Extensions-3.3.msi" -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Git Extensions'
    }
}
