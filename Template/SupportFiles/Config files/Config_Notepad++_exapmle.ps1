$Config = @{
    appVendor = "Notepad++ Team"
    appName = "Notepad++"
    appVersion = "7.7"
    appDetectionVersion = "7.7"
    appDetectionName = "Notepad++"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Notepad++"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        if ($Is64Bit)
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\nnp-7.7-x64.exe"  -Parameters "/S"
        }
        else 
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\nnp-7.7-x86.exe"  -Parameters "/S"
        }
		
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files\Notepad++\uninstall.exe" -Parameters "/S"
    }
}