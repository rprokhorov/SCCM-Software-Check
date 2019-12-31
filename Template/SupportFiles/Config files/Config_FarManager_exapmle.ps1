$Config = @{
    appVendor = "Eugene Roshal & Far Group"
    appName = "Far Manager"
    appVersion = "3.0.5400"
    appDetectionVersion = "3.0.5400"
    appDetectionName = "Far Manager"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "far"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] удаление старой версии приложения..."
        Remove-MSIApplications -Name 'Far Manager'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] установка новой версии приложения..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path 'far-3.0.5400.msi' -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'Far Manager'
    }
}