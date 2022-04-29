$Config = @{
    appVendor = "SmartBear Software"
    appName = "SoapUI"
    appVersion = "5.6.0"
    appDetectionVersion = "5.6.0"
    appDetectionName = "SoapUI 5.6.0"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = ""
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode = Start-Process -FilePath "$dirFiles\SoapUI-x64-5.6.0.exe"  -ArgumentList "-q" -wait

    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Start-Process -FilePath "C:\Program Files\SmartBear\SoapUI-5.6.0\uninstall.exe" -ArgumentList "-q" -Wait
    }
}
