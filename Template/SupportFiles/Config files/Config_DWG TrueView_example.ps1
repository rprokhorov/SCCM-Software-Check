$Config = @{
    appVendor = "Autodesk"
    appName = "DWG TRUEVIEW"
    appVersion = "24.1.51.0"
    appDetectionVersion = "24.1.51.0"
    appDetectionName = "DWG TRUEVIEW"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "DWG TRUEVIEW"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode =Execute-MSI -Action 'Install' -Path "$dirFiles\dwgviewr.msi" -Parameters 'ADSK_SETUP_EXE=1 /QN'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-MSI -Action 'Uninstall' -Path '{28B89EEF-5128-0409-0100-CF3F3A09B77D}'
    }
}
