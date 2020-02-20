$Config = @{
    appVendor = "Microsoft"
    appName = "LAPS"
    appVersion = "6.2.0.0"
    appDetectionVersion = "6.2.0.0"
    appDetectionName = "LAPS"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        
        if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\LAPS.x64.msi" -Parameters '/QN ADDLOCAL=Management.UI,Management,Management.PS'
		}
		else {
			$mainExitCode = $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\LAPS.x86.msi" -Parameters '/QN ADDLOCAL=Management.UI,Management,Management.PS'
		}
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'Local Administrator Password Solution'
    }
}