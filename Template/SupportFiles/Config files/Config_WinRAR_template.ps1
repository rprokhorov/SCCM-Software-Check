$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "winrar"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
		Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] установка WinRAR..." 
        if($envOSArchitecture -eq '64-bit')
		{
			$mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x64%"  -Parameters "/s"
		}
		else {
			$mainExitCode = Execute-Process -Path "$dirFiles\%FileName_x86%"  -Parameters "/s"
		}
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] копирование файла лицензий..."
        $Domain = (Get-WmiObject Win32_ComputerSystem).Domain
        $LicenceFileName = @{
            'A.CORP' = 'A.CORP'
            'B.CORP' = 'A.CORP'
            'C.CORP' = 'C.CORP'
            'D.CORP' = 'D.CORP'
            'E.CORP' = 'E.CORP'
       }
        Copy-File -Path "$dirFiles\rarreg_$($LicenceFileName[$Domain]).key" -Destination "C:\Program Files\WinRAR\rarreg.key" -ContinueOnError $false
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files\WinRAR\uninstall.exe"  -Parameters "/s"
    }
}