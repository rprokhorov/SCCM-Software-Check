$Config = @{
    appVendor ="The Wireshark developer community"
    appName = "Wireshark"
    appVersion = "3.0.6"
    appDetectionVersion = "3.0.6"
    appDetectionName = "Wireshark"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "Wireshark"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        if ($envOSArchitecture = '64-bit'){
            $mainExitCode = Execute-Process -Path "$dirFiles\Wireshark_3.0.6_x64.exe"  -Parameters "/S /desktopicon=yes"
        }
        else {
            $mainExitCode = Execute-Process -Path "$dirFiles\Wireshark_3.0.6_x86.exe"  -Parameters "/S /desktopicon=yes"
        }
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files\Wireshark\uninstall.exe"  -Parameters "/S"
    }
}