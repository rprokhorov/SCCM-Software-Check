$Config = @{
    appVendor = "Security Code"
    appName = "ContinentAP"
    appVersion = "3.7.7.651"
    appDetectionVersion = "3.7.7.651"
    appDetectionName = "ContinentAP"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-Process -Path "$dirFiles\Continent_AP_3.7.7.651.exe"  -Parameters "/DO=INSTALL /LANG=RU /NMSE /S /NR"
       
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
    }
}
