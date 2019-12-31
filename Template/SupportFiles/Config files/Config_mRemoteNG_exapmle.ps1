$Config = @{
    appVendor = "Next Generation Software"
    appName = "mRemoteNG"
    appVersion = "1.76.20.24615"
    appDetectionVersion = "1.76.20.24615"
    appDetectionName = "mRemoteNG"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "mRemoteNG"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
		Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
		$mainExitCode = Execute-MSI -Action 'Install' -Path 'mRemoteNG-1.76.20.24615.msi' -Parameters '/QN /norestart'
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'mRemoteNG'
    }
}