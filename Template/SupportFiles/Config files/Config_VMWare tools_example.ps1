$Config = @{
    appVendor = "VMWare"
    appName = "VMWare tools"
    appVersion = "11.1.1.16303738"
    appDetectionVersion = "11.1.1.16303738"
    appDetectionName = "VMWare tools"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\VMware Tools64.msi" -Parameters '/Qn /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'VMWare tools'
    }
}
