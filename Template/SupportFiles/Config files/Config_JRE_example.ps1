$Config = @{
    appVendor = "Oracle Corporation"
    appName = "Java Runtime Environment"
    appVersion = "8 Update 201 (8.0.2010.9)"
    appDetectionVersion = "8.0.2010.9"
    appDetectionName = "Java 8 Update"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        if ($Is64Bit)
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\jre-8u201-windows-x64.exe"  -Parameters '/s AUTO_UPDATE=Disable /L C:\Windows\Logs\Software\JavaRuntimeEnvironment-x64-8.0.2010.9_Install.log'
            $mainExitCode = Execute-Process -Path "$dirFiles\jre-8u201-windows-i586.exe"  -Parameters '/s AUTO_UPDATE=Disable /L C:\Windows\Logs\Software\JavaRuntimeEnvironment-x86-8.0.2010.9_install.log'
        }
        else 
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\jre-8u201-windows-i586.exe"  -Parameters '/s AUTO_UPDATE=Disable /L C:\Windows\Logs\Software\JavaRuntimeEnvironment-x86-8.0.2010.9_install.log'
        }
		
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name "Java 8 Update"
    }
}
