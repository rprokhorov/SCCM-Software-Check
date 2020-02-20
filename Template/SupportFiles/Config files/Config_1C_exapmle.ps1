$Config = @{
    appVendor = "1С-Софт"
    appName = "1C:Предприятие 8"
    appVersion = "8.3.14.1565"
    appDetectionVersion = "8.3.14.1565"
    appDetectionName = "1C:Предприятие 8"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "1cv8s"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..." #-WindowLocation 'BottomRight'
        $mainExitCode = Execute-MSI -Action "Install" -Path "$dirFiles\1CEnterprise 8.msi" -Transform "$dirFiles\1049.mst" -Parameters "/QN /norestart"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name '1C:Предприятие 8'
    }
}