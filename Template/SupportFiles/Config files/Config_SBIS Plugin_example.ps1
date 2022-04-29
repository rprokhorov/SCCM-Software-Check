$Config = @{
    appVendor = "Tensor Company Ltd"
    appName = "����3 ������"
    appVersion = "21.1281.10"
    appDetectionVersion = "21.1281.10"
    appDetectionName = "����3 ������"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\sbis3plugin-setup-full.msi" -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name '����3 ������'
    }
}
