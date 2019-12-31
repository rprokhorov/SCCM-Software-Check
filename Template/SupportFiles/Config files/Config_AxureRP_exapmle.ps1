$Config = @{
    appVendor = "Axure Software Solutions, Inc."
    appName = "Axure RP"
    appVersion = "8.1.0.3388"
    appDetectionVersion = "8.0.0.3388"
    appDetectionName = "Axure RP"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "AxureRP8"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] удаление старой версии приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\AxureRP-8.1.0.3388.exe"  -Parameters "/S /l=""C:\Windows\Logs\Software\AxureRP_8.1.0.3388_install.log""" 
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $appName = "Axure RP"
        $appVersion = "8.1.0.3388"
        $appDetectionVersion = "8.0.0.3388"
        $appDetectionName = "Axure RP"
        #$LogName = "Detection Method $appName - $appVersion.log" -replace '\*', ' '
        $Version = "$appDetectionVersion"
        [array]$Products = Get-InstalledApplication -Name "*$appDetectionName*" -WildCard #-LogName $LogName
        $mainExitCode = Execute-Process -Path ($Products |? {$_.InstallDate -ne $null}).UninstallString -Parameters "REMOVE=TRUE MODIFY=FALSE /S /l=""C:\Windows\Logs\Software\AxureRP_8.1.0.3388_uninstall.log""" 
    }
}
