$Config = @{
    appVendor = "Adobe"
    appName = "Adobe Flash Player PPAPI"
    appVersion = "32.0.0.223"
    appDetectionVersion = "32.0.0.223"
    appDetectionName = "Adobe Flash Player*PPAPI"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path 'install_flash_player_32_ppapi.msi' -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Adobe Flash Player*PPAPI'
    }
}