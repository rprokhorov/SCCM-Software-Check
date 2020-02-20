$Config = @{
    appVendor = "ABBYY"
    appName = "ABBYY FineReader"
    appVersion = "11.11.194"
    appDetectionVersion = "11.11.194"
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
        Execute-MSI -Action 'Uninstall' -Path '{F14000FE-0001-6400-0000-074957833700}'
    }
}