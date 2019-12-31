$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "AxureRP8"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] удаление старой версии приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\%FileName%"  -Parameters "/S /l=""C:\Windows\Logs\Software\AxureRP_%appVersion%_install.log"""
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $appName = "%appName%"
        $appVersion = "%appVersion%"
        $appDetectionVersion = "%appDetectionVersion%"
        $appDetectionName = "%appDetectionName%"
        #$LogName = "Detection Method $appName - $appVersion.log" -replace '\*', ' '
        $Version = "$appDetectionVersion"
        [array]$Products = Get-InstalledApplication -Name "*$appDetectionName*" -WildCard #-LogName $LogName
        $mainExitCode = Execute-Process -Path ($Products |? {$_.InstallDate -ne $null}).UninstallString -Parameters "REMOVE=TRUE MODIFY=FALSE /S /l=""C:\Windows\Logs\Software\AxureRP_%appVersion%_uninstall.log"""
    }
}