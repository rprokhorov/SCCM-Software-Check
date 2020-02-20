$Config = @{
    appVendor = "Microsoft"
    appName = "Visio Viewer 2016"
    appVersion = "16.0.4339.1001"
    appDetectionVersion = "16.0.4339.1001"
    appDetectionName = "Visio Viewer"
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
			$mainExitCode = Execute-Process -Path "$dirFiles\visioviewer_4339-1001_x64_en-us.exe"  -Parameters "/quiet /norestart /log:""C:\Windows\Logs\Software\Visio Viewer - 2016.log"""
		}
		else {
			$mainExitCode = Execute-Process -Path "$dirFiles\visioviewer_4339-1001_x86_en-us.exe"  -Parameters "/quiet /norestart /log:""C:\Windows\Logs\Software\Visio Viewer - 2016.log"""
		}
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Visio Viewer'
    }
}