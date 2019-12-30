$Config = @{
    appVendor ="VideoLAN"
    appName = "VLC"
    appVersion = "3.0.7.1"
    appDetectionVersion = "3.0.7.1"
    appDetectionName = "VLC"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "vlc"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] установка приложения..." 
        if ($Is64Bit)
        {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\vlc-3.0.7.1-win64.msi" -Parameters '/qn' -Transform "$dirFiles\diff.mst"
        }
        else 
        {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\vlc-3.0.7.1-win86.msi" -Parameters '/qn' -Transform "$dirFiles\diff.mst"
        }
        [string]$installPhase = 'Post-Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] удаления ярлыка с рабочего стола..."
        Remove-Item "$env:SystemDrive\Users\Public\Desktop\VLC media player.lnk" -Force
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'VLC'
    }
}