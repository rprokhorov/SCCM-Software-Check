$Config = @{
    appVendor = "VMware Inc."
    appName = "VMware Horizon Client"
    appVersion = "8.4.1.26410"
    appDetectionVersion = "8.4.1.26410"
    appDetectionName = "VMware Horizon Client"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\VMware-Horizon-Client-2111.1-8.4.1-19480429.exe" -ArgumentList "/silent /norestart" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'VMware Horizon Client'
    }
}