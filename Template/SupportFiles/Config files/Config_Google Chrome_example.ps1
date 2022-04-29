$Config = @{
    appVendor = "Google LLC"
    appName = "Google Chrome"
    appVersion = "100.0.4896.127"
    appDetectionVersion = "100.0.4896.127"
    appDetectionName = "Google Chrome"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Execute-MSI -Action "Install" -Path "GoogleChromeStandaloneEnterprise_100.0.4896.127.msi" -Parameters "/quiet /norestart /l*v `"%WINDIR%\Logs\Software\GoogleChrome_install.log`""
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Google Chrome'
    }
}