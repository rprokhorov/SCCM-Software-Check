$Config = @{
    appVendor = "SAS Insitute Inc." #"Dominik Reichl"
    appName = "SAS Enterprise Guide" #"KeePass"
    appVersion = "8.1.0" #"2.42.1"
    appDetectionVersion = "8.1.0" #"2.42.1"
    appDetectionName = "SAS Enterprise Guide 8.1 (64-bit)" # "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "" #
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode =  Start-Process -FilePath "$dirfiles\SASEnterpriseGuide81_x86_x64.exe" -ArgumentList "/verysilent -- -loglevel 2 -responsefile `"$dirfiles\saseg.properties`"" -Wait
    }
    UninstallScriptBlock = {
        #[string]$installPhase = 'Uninstall'
        #Remove-MSIApplications -Name 'KeePass'
    }
}