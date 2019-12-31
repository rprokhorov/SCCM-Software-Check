$Config = @{
    appVendor = "KLCP"
    appName = "K-Lite Codec Pack Standard"
    appVersion = "14.9.8"
    appDetectionVersion = "14.9.8"
    appDetectionName = "K-Lite Codec Pack*Standard"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\K-Lite_Codec_Pack_Standard.exe"  -Parameters "/verysilent /LOG=""C:\Windows\Logs\Software\K-Lite Codec Pack Standard-14.9.8-Install.log"""
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files (x86)\K-Lite Codec Pack\unins000.exe"  -Parameters "/verysilent LOG=""C:\Temp\Logs\Software\Uninstall-K-Lite Codec Pack Standard-14.9.8.log"""
    }
}