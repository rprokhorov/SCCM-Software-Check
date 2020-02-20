$Config = @{
    appVendor = "ABBYY"
    appName = "ABBYY FineReader"
    appVersion = "10.0501.154"
    appDetectionVersion = "10.0501.154"
    appDetectionName = "ABBYY FineReader"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "FineReader", "HotFolder"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\setup.exe"  -Parameters "/qn /L1049 /v STATISTICS_ALLOWED=0 INTEGRATION=0 SHCTDESKTOP=0 SSR_AUTORUN=0 CHECK_UPDATES=0 TIPS_ALLOWED=0 DONT_ASK_ABOUT_DEFAULT=1"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-MSI -Action 'Uninstall' -Path '{F1000000-0001-0000-0000-074957833700}'
    }
}