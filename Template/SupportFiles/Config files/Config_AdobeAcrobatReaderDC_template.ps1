$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "AcroRd32"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] установка MSI файла с трансформацией..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\AcroRead.msi" -Transform 'AcroRead.mst' -Parameters '/QN /norestart'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] установка последней версии программы..."
        $mainExitCode = Execute-MSI -Action 'Patch' -Path "$dirFiles\%FileName%" -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Adobe Acrobat Reader DC'
    }
}