$Config = @{
    appVendor = "Oracle Corporation"
    appName = "Java SE Development Kit"
    appVersion = "8 Update 201 (8.0.2010.9)"
    appDetectionVersion = "8.0.2010.9"
    appDetectionName = "Java SE Development Kit"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        if ($Is64Bit)
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\jdk-8u201-windows-x64.exe"  -Parameters '/s'
        }
        else 
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\jdk-8u201-windows-i586.exe"  -Parameters '/s'
        }
		
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Java SE Development Kit'
    }
}
