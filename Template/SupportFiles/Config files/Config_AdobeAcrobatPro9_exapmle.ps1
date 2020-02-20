$Config = @{
    appVendor = "Adobe"
    appName = "Adobe Acrobat Professional"
    appVersion = "9.0.0"
    appDetectionVersion = "9.0.0"
    appDetectionName = "Adobe acrobat*9 Pro*"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Acrobat"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка MSI файла с трансформацией..."
        $mainExitCode = Execute-Process -Path "Setup.exe"  -Parameters '/sl "1049" /sAll'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-MSI -Action Uninstall -Path 'AcroPro.msi'
    }
}