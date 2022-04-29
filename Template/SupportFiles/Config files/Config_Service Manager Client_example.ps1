$Config = @{
    appVendor = "он Micro Focus"
    appName = "Service Manager Client"
    appVersion = "9.70.25.0"
    appDetectionVersion = "9.70.25.0"
    appDetectionName = "Service Manager 9.70 Client"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\ServiceManagerClient.exe" -ArgumentList "-i silent -f $dirfiles\setupclient.prop" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Start-Process -FilePath "C:\Program Files\Micro Focus\Service Manager 9.70\Client\_uninstall\uninstaller.exe" -ArgumentList "-i silent" -Wait
        
    }
}