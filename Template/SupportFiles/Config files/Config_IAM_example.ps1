$Config = @{
    appVendor = "One Identity LLC." #"Dominik Reichl"
    appName = "One Identity Manager" #"KeePass"
    appVersion = "8.1" #"2.42.1"
    appDetectionVersion = "8.1" #"2.42.1"
    appDetectionName = "One Identity Manager" # "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "" #
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\setup\InstallManager.Cli.exe" -ArgumentList "-m install -r $dirfiles -i `"C:\Program Files\Dell\One Identity Manager`" -mod EX0 NDO ATT RMB POL CPL CAP RPS RMS -d Client Client\Administration" -Wait
    }
    UninstallScriptBlock = {
        #[string]$installPhase = 'Uninstall'
        #Remove-MSIApplications -Name 'KeePass'
    }
}