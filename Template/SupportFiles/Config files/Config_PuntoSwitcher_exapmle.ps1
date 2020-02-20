$Config = @{
    appVendor ="Яндекс"
    appName = "Punto Switcher"
    appVersion = "4.4.4.489"
    appDetectionVersion = "4.4.4.489"
    appDetectionName = "Punto Switcher"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "punto","ps64ldr"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode = Execute-Process -Path "$dirFiles\PuntoSwitcherSetup.exe"  -Parameters '/quiet /msicl "MSIFASTINSTALL=7 ILIGHT=0 YABROWSER="n" YBSENDSTAT="n" YBDEFAULT="n" YAHOMEPAGE="n" YAQSEARCH="n"'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Punto Switcher'
    }
}