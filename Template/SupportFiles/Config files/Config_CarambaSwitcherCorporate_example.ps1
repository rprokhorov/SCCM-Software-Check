$Config = @{
    appVendor = "Caramba Tech"
    appName = "Caramba Switcher Corporate"
    appVersion = "2019.12.05"
    appDetectionVersion = "2019.12.05"
    appDetectionName = "Caramba Switcher Corporate"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "CarambaSwitcher"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\CarambaSwitcherCorporate-2019.12.05.exe"  -Parameters "/VERYSILENT /SUPPRESSMSGBOXES /LOG=`"C:\Windows\Logs\Software\Caramba Switcher Corporate_2019.12.05_install.log`" /NOICON /NORESTART /LANG=1049 /DIR=`"C:\Program Files\Caramba\Switcher`""
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-Process -Path 'C:\Program Files\Caramba\Switcher\unins000.exe' -Parameters "/VERYSILENT /LOG=`"C:\Windows\Logs\Software\Caramba Switcher Corporate_2019.12.05_uninstall.log`""
    }
}
