$Config = @{
    appVendor = "Microsoft"
    appName = "Azure Information Protection"
    appVersion = "2.12.62.0"
    appDetectionVersion = "2.12.62.0"
    appDetectionName = "Azure Information Protection"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "" #"outlook", "excel", "winword", "POWERPNT"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\AzInfoProtection_UL.msi" -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Azure Information Protection'
    }
}
