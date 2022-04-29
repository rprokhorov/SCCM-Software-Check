$Config = @{
    appVendor = "Microsoft Corporation"
    appName = "Microsoft Edge"
    appVersion = "99.0.1150.46"
    appDetectionVersion = "99.0.1150.46"
    appDetectionName = "Microsoft Edge"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\MicrosoftEdgeEnterpriseX64.msi" -Parameters '/QN /norestart'

    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Microsoft Edge'
    }
}
