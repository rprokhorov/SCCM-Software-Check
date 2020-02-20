$Config = @{
    appVendor = "Acronis"
    appName = "Acronis Backup Agent"
    appVersion = "12.5.9010"
    appDetectionVersion = "12.5.9010"
    appDetectionName = "Acronis Backup"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "acronis"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\AB64.msi" -Transform "$dirFiles\AB64.msi.mst" -Parameters '/qn /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-MSI -Action 'Uninstall' -Path '{9C384BEC-0F65-4B03-9FE8-766FB537DB1C}'
    }
}