$Config = @{
    appVendor = "Fiddler"
    appName = "Fiddler"
    appVersion = "3.2.1.6628"
    appDetectionVersion = "3.2.1.6628"
    appDetectionName = "Fiddler"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Fiddler"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\Fiddler.exe"  -Parameters "/S /D=C:\Program Files\Fiddler"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-Process -Path "C:\Program Files\Fiddler\uninst.exe"  -Parameters "/S"
    }
}