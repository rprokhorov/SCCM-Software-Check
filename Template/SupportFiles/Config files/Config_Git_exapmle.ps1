$Config = @{
    appVendor = "The Git Development Community"
    appName = "Git"
    appVersion = "2.20.1"
    appDetectionVersion = "2.20.1"
    appDetectionName = "git"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "Transneft Technology, LLC"
    close_app = "git-bash","wish"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        if ($envOSArchitecture = '64-bit'){
            $mainExitCode = Execute-Process -Path "$dirFiles\Git-2.20.1-64-bit.exe"  -Parameters "/VERYSILENT"
        }
        else {
            $mainExitCode = Execute-Process -Path "$dirFiles\Git-2.20.1-32-bit.exe"  -Parameters "/VERYSILENT"
        }
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Execute-Process -Path "C:\Program Files\Git\unins000.exe" -Parameters "/VERYSILENT"
    }
}