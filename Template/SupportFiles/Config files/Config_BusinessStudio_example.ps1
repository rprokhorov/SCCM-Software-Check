$Config = @{
    appVendor = "ГК СТУ"
    appName = "Business Studio"
    appVersion = "4.2.6400"
    appDetectionVersion = "4.2.6400"
    appDetectionName = "Business Studio"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Business Studio Enterprise"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии приложения..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\package\package.msi" -Parameters '/q CFG_CLIENT=1 CFG_ENT=1'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'Business Studio'
    }
}