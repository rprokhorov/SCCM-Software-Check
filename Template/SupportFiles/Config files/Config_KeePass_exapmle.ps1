$Config = @{
    appVendor = "Dominik Reichl"
    appName = "KeePass"
    appVersion = "2.42.1"
    appDetectionVersion = "2.42.1"
    appDetectionName = "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "keepass"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        Remove-MSIApplications -Name "KeePass"
        $mainExitCode = Execute-MSI -Action "Install" -Path "KeePass-2.42.1.msi" -Parameters "/QN /norestart"
        [string]$installPhase = 'Post-Installation'
        Copy-File -Path "\\srv0101-sccm01.ak.tn.corp\Sources\Applications\KeePass\Config files\KeePass.config.xml" -Destination "C:\Program Files (x86)\KeePass2x\KeePass.config.xml" -ContinueOnError $false
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'KeePass'
    }
}