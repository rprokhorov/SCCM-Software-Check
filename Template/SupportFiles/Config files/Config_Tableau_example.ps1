$Config = @{
    appVendor = "Tableau Software"
    appName = "Tableau Desktop"
    appVersion = "2021.4.3"
    appDetectionVersion = "21.4.1708.0"
    appDetectionName = "Tableau"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "tableau"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\TableauDesktop-64bit-2021-4-3.exe" -ArgumentList "/quiet /norestart /log ""C:\Windows\Logs\Software\TableauDesktop-2021.4.3-install.log"" ACCEPTEULA=1 DESKTOPSHORTCUT=1 REMOVEINSTALLEDAPP=1 RECLAIMLICENSE=1" -Wait
        
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        
    }
}