$Config = @{
    appVendor = "Nmap Project"
    appName = "Nmap"
    appVersion = "7.70"
    appDetectionVersion = "7.70"
    appDetectionName = "Nmap"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "zenmap"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
		Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
		$mainExitCode = Execute-Process -Path "$dirFiles\Nmap-7.70.exe"  -Parameters "/S"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files (x86)\Nmap\uninstall.exe"   -Parameters "/S" 
    }
}