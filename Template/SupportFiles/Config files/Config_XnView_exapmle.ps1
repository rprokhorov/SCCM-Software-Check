$Config = @{
    appVendor ="Gougelet Pierre-e"
    appName = "XnView"
    appVersion = "2.49.2"
    appDetectionVersion = "2.49.2"
    appDetectionName = "XnView"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "XnView"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Execute-Process -Path "$dirFiles\XnView-full-2.49.2.exe" -Parameters "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NOCANCEL /NOICONS /LOG=""C:\Windows\Logs\Software\XNView-2.49.2_Install.log"""
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Execute-Process -Path "C:\Program Files (x86)\XnView\unins000.exe" -Parameters "/VERYSILENT"
    }
}