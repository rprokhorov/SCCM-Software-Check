$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "CarambaSwitcher"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\%FileName%"  -Parameters "/VERYSILENT /SUPPRESSMSGBOXES /LOG=`"C:\Windows\Logs\Software\%appName%_%appVersion%_install.log`" /NOICON /NORESTART /LANG=1049 /DIR=`"C:\Program Files\Caramba\Switcher`""
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-Process -Path 'C:\Program Files\Caramba\Switcher\unins000.exe' -Parameters "/VERYSILENT /LOG=`"C:\Windows\Logs\Software\%appName%_%appVersion%_uninstall.log`""
    }
}