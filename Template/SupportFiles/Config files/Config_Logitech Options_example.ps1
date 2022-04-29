$Config = @{
    appVendor = "Logitech"
    appName = "Logitech Options"
    appVersion = "9.40.86"
    appDetectionVersion = "9.40.86"
    appDetectionName = "Logitech Options"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "" #
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\options_installer.exe" -ArgumentList "/quiet /norestart" -Wait
        Start-Sleep -Seconds 300 # installer start another process and parameter -Wait doesn't work
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Start-Process -FilePath "$env:ProgramFiles\Logitech\LogiOptions\uninstaller.exe" -ArgumentList "/S" -Wait
    }
}