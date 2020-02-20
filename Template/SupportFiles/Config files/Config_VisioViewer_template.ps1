$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "%FileName_x64%"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] удаление предыдущих версий..." #-WindowLocation 'BottomRight'
        Remove-MSIApplications -Name 'Visio Viewer'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] установка приложения..." #-WindowLocation 'BottomRight'
		if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x64%"  -Parameters "/quiet /norestart /log:""C:\Windows\Logs\Software\Visio Viewer - %appVersion%.log"""
		}
		else {
			$mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x86%"  -Parameters "/quiet /norestart /log:""C:\Windows\Logs\Software\Visio Viewer - %appVersion%.log"""
		}
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Visio Viewer'
    }
}