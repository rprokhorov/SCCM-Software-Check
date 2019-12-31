$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "Transneft Technology, LLC"
    close_app = "git-bash","wish"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        if ($envOSArchitecture = '64-bit'){
            $mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x64%"  -Parameters "/VERYSILENT"
        }
        else {
            $mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x86%"  -Parameters "/VERYSILENT"
        }
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Execute-Process -Path "C:\Program Files\Git\unins000.exe" -Parameters "/VERYSILENT"
    }
}