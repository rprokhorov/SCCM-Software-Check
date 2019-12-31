$Config = @{
    appVendor = "www.pdf24.org"
    appName = "PDF24 Creator"
    appVersion = "9.0.1"
    appDetectionVersion = "9.0.1"
    appDetectionName = "PDF24 Creator"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "pdf24","pdf24-Launcher"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..." #-WindowLocation 'BottomRight'
        $mainExitCode = Execute-MSI -Action "Install" -Path "$dirFiles\pdf24-creator-9.0.1.msi" -Parameters "/QN /norestart"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'PDF24 Creator'
    }
}