$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "punto","ps64ldr"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode = Execute-Process -Path "$dirFiles\%FileName%"  -Parameters '/quiet /msicl "MSIFASTINSTALL=7 ILIGHT=0 YABROWSER="n" YBSENDSTAT="n" YBDEFAULT="n" YAHOMEPAGE="n" YAQSEARCH="n"'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Punto Switcher'
    }
}