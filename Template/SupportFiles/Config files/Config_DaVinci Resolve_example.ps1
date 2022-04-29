$Config = @{
    appVendor = "Blackmagic Design" #"Dominik Reichl"
    appName = "DaVinci Resolve" #"KeePass"
    appVersion = "17.4.10004" #"2.42.1"
    appDetectionVersion = "17.4.10004" #"2.42.1"
    appDetectionName = "DaVinci Resolve" # "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "" #
    InstallScriptBlock = {
       [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action "Install" -Path "ResolveInstaller.msi" -Parameters "ALLUSERS=1 REBOOT=ReallySuppress /qn"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-MSI -Action 'Uninstall' -Path '{6E40D3ED-077B-45C4-90FF-222CC65C199C}'
    }
}