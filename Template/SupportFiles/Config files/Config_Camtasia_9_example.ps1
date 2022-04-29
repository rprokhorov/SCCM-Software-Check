$Config = @{
    appVendor = "TechSmith"
    appName = "Camtasia"
    appVersion = "9.0.4.1684"
    appDetectionVersion = "9.0.4.1684"
    appDetectionName = "Camtasia"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "camtasia", "CamtasiaStudio"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\CamtasiaInstaller_9.msi" -Parameters '/qn /norestart TSC_DESKTOP_LINK=1 TSC_INST_MEDIA_LIBRARY=1 TSC_UPDATE_ENABLE=0 TSC_SOFTWARE_KEY="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"'
        
          
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Camtasia'
    }
}