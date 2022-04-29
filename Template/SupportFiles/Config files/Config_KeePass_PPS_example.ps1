$Config = @{
    appVendor = "Dominik Reichl"
    appName = "KeePass for Pleasant Password Server"
    appVersion = "7.10.4"
    appDetectionVersion = "7.10.4"
    appDetectionName = "KeePass for Pleasant Password Server"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "KeePass"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\PleasantKeePassClient.exe" -ArgumentList "/install /quiet /norestart /log c:\windows\Logs\PleasantKeePass_install.log" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Start-Process -FilePath "C:\ProgramData\Package Cache\{a6aef200-222a-41b5-b466-1d5fcd475859}\Pleasant KeePass Client.exe" -ArgumentList "/uninstall /quiet /norestart /log c:\windows\Logs\PleasantKeePass_uninstall.log" -Wait
    }
}
 

