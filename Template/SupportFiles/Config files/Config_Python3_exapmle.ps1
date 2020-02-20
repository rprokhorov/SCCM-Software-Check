$Config = @{
    appVendor ="Python Software Foundation"
    appName = "Python"
    appVersion = "3.8.0"
    appDetectionVersion = "3.8.150.0"
    appDetectionName = "Python*Core Interpreter"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Python"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode = Execute-Process -Path "$dirFiles\python-3.8.0-amd64.exe" -Parameters '/quiet InstallAllUsers=1 PrependPath=1'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Python*Core Interpreter'
        $mainExitCode = Remove-MSIApplications -Name 'Python Launcher'
    }
}