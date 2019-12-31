$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "far"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] удаление старой версии приложения..."
        Remove-MSIApplications -Name 'Far Manager'
        if ($envOSArchitecture = '64-bit'){
            Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] установка новой версии приложения..."
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\%FileName_x64%" -Parameters '/QN /norestart'
        }
        else {
            Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] установка новой версии приложения..."
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\%FileName_x86%" -Parameters '/QN /norestart'
        }
        
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'Far Manager'
    }
}