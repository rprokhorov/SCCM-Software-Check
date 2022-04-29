$Config = @{
    appVendor = "The pgAdmin Development Team"
    appName = "pgAdmin"
    appVersion = "5.6"
    appDetectionVersion = "5.6"
    appDetectionName = "pgAdmin 4 version 5.6"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\pgadmin4-5.6-x64.exe" -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /ALLUSERS" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Start-Process -FilePath "C:\Program Files\pgAdmin 4\v5\unins000.exe" -ArgumentList "/VERYSILENT /NORESTART" -Wait
    }
}