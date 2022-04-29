$Config = @{
    appVendor = "ООО Такском"
    appName = "Такском-Мастер"
    appVersion = "1.9.269"
    appDetectionVersion = "1.9.269"
    appDetectionName = "Такском-Мастер выпуска сертификатов x86"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\CertEnrollSetup(Taxcom).msi" -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Такском-Мастер выпуска сертификатов x86'
    }
}
