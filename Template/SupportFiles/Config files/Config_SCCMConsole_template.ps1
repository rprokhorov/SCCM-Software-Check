$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Microsoft.ConfigurationManagement"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        Execute-Process -Path "ConsoleSetup.exe"  -Parameters '/q TargetDir="C:\Program Files\ConfigMgr Console" DefaultSiteServerName=SCCMServer.contoso.com'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Execute-Process -Path "ConsoleSetup.exe"  -Parameters "/uninstall /q" 
    }
}