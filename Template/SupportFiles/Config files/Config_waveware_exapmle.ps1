$Config = @{
    appVendor ="Loy & Hutz Development GmbH"
    appName = "waveware"
    appVersion = "11.170.1912.250"
    appDetectionVersion = "11.170.1912.250"
    appDetectionName = "waveware"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "waveware"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии..."
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\waveware.msi" -Parameters '/qn'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'waveware'
    }
}