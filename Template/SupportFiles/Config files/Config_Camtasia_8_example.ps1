$Config = @{
    appVendor = "TechSmith"
    appName = "Camtasia"
    appVersion = "8.0.2.918"
    appDetectionVersion = "8.0.2.918"
    appDetectionName = "Camtasia"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "camtasia", "CamtasiaStudio"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\CamtasiaStudio8.msi" -Parameters '/qn /norestart ALLUSERS=2 TSC_SOFTWARE_KEY="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-MSI -Action 'Uninstall' -Path "$dirFiles\CamtasiaStudio8.msi" -Parameters '/qn TSC_KEEP_LIBRARY=1 '
    }
}