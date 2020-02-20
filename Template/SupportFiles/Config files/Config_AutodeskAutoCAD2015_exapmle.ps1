$Config = @{
    appVendor = "Autodesk"
    appName = "AutoCAD"
    appVersion = "20.0.51.0"
    appDetectionVersion = "20.0.51.0"
    appDetectionName = "AutoCAD"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "AutoCAD"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии..."
        $mainExitCode = Execute-Process -Path "$dirFiles\Img\Setup.exe"  -Parameters "/W /Q /I Img\AutoCAD15DeploymentX64.ini /Lang ru-ru" 
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-MSI -Action 'Uninstall' -Path '{5783F2D7-E001-0000-0102-0060B0CE6BBA}'
    }
}