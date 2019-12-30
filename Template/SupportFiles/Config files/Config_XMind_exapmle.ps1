$Config = @{
    appVendor ="XMind Ldt."
    appName = "XMind"
    appVersion = "3.7.8.201807240049"
    appDetectionVersion = "3.7.8.201807240049"
    appDetectionName = "XMind"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "XMind"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\XMind-3.7.8.201807240049.exe" -Parameters "/VERYSILENT /NOCLOSEAPPLICATION /NORESTART"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files (x86)\XMind\unins000.exe" -Parameters "/VERYSILENT"
    }
}