$Config = @{
    appVendor = "Autodesk"
    appName = "Autodesk Design Review"
    appVersion = "14.0.2.191"
    appDetectionVersion = "14.0.2.191"
    appDetectionName = "Autodesk Design Review"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "DesignReview"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] установка MSI файла с трансформацией..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path 'SetupDesignReview.msi' -Parameters '/QN /norestart'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] установка последней версии программы..."
        $mainExitCode = Execute-MSI -Action 'Patch' -Path 'ADR2018SP2.msp' -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Autodesk Design Review'
    }
}