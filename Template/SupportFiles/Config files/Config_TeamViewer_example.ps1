$Config = @{
    appVendor = "TeamViewer"
    appName = "TeamViewer"
    appVersion = "15.20.8" 
    appDetectionVersion = "15.20.8"
    appDetectionName = "TeamViewer" # "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "TeamViewer_Service". "TeamViewer" #
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        
        $mainExitCode = Start-Process -FilePath "$dirfiles\TeamViewer_Host_Setup.exe" -ArgumentList '/S' -Wait
        reg import "$dirfiles\Teamviewer10.reg"
        Start-Sleep -Seconds 10
        Stop-Process -Name 'TeamViewer' -Force
        #[string]$installPhase = 'Post-Installation'
        #Copy-File -Path "$dirSupportFiles\KeePass.config.xml" -Destination "C:\Program Files (x86)\KeePass2x\KeePass.config.xml" -ContinueOnError $false
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Start-Process -FilePath "C:\Program Files (x86)\TeamViewer\uninstall.exe" -ArgumentList '/S' -Wait
    }
}