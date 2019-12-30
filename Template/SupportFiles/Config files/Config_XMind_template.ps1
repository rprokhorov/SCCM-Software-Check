$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "XMind"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\%FileName%" -Parameters "/VERYSILENT /NOCLOSEAPPLICATION /NORESTART"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files (x86)\XMind\unins000.exe" -Parameters "/VERYSILENT"
    }
}