$Config = @{
    appVendor = "SAP BusinessObjects"
    appName = "BusinessObjcts Client Tools"
    appVersion = "4.2 SP 7"
    appDetectionVersion = "14.2.7.3069"
    appDetectionName = "SAP BusinessObjects BI platform 4.2 Client Tools SP7"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = ""
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        cd $dirFiles
        $mainExitCode = Start-Process -FilePath "setup.exe" -ArgumentList "-r fullupg.ini" -wait
        
    }
    UninstallScriptBlock = {
       # [string]$installPhase = 'Uninstall'
       # Remove-MSIApplications -Name 'BusinessObjcts Client Tools'
    }
}