$Config = @{
    appVendor = "Tensor Company Ltd"
    appName = "СБИС3 Плагин"
    appVersion = "21.1281.10"
    appDetectionVersion = "21.1281.10"
    appDetectionName = "СБИС3 Плагин"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\sbis3plugin-setup-full.msi" -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'СБИС3 Плагин'
    }
}
