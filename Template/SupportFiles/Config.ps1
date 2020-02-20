$Config = @{
    appVendor = "%appVendor%" #"Dominik Reichl"
    appName = "%appName%" #"KeePass"
    appVersion = "%appVersion%" #"2.42.1"
    appDetectionVersion = "%appDetectionVersion%" #"2.42.1"
    appDetectionName = "%appDetectionName%" # "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "%close_app%" #
    InstallScriptBlock = {
        #[string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        #Remove-MSIApplications -Name "KeePass"
        #$mainExitCode = Execute-MSI -Action "Install" -Path "KeePass-2.42.1.msi" -Parameters "/QN /norestart"
        #[string]$installPhase = 'Post-Installation'
        #Copy-File -Path "$dirSupportFiles\KeePass.config.xml" -Destination "C:\Program Files (x86)\KeePass2x\KeePass.config.xml" -ContinueOnError $false
    }
    UninstallScriptBlock = {
        #[string]$installPhase = 'Uninstall'
        #Remove-MSIApplications -Name 'KeePass'
    }
}