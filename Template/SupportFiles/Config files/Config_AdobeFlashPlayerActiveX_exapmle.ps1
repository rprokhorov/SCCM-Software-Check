$Config = @{
    appVendor = "Adobe"
    appName = "Adobe Flash Player ActiveX"
    appVersion = "32.0.0.223"
    appDetectionVersion = "32.0.0.223"
    appDetectionName = "Adobe Flash Player*ActiveX"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path 'install_flash_player_32_active_x.msi' -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Adobe Flash Player*ActiveX'
    }
}