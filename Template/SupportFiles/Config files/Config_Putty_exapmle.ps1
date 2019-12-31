$Config = @{
    appVendor ="Simon Tatharm"
    appName = "PuTTY"
    appVersion = "0.73"
    appDetectionVersion = "0.73"
    appDetectionName = "PuTTY"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "Rprokhorov"
    close_app = "putty"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        if ($Is64Bit)
        {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\PuTTY-x64-0.73.msi" -Parameters '/QN /norestart'
        }
        else 
        {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\PuTTY-x86-0.73.msi" -Parameters '/QN /norestart'
        }
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'PuTTY'
    }
}