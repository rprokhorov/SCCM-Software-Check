$Config = @{
    appVendor = "Dominik Reichl"
    appName = "KeePass"
    appVersion = "2.50"
    appDetectionVersion = "2.50"
    appDetectionName = "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "keepass"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����������..."
        Remove-MSIApplications -Name "KeePass"
        $mainExitCode = Execute-MSI -Action "Install" -Path "$dirFiles\KeePass-2.50.msi" -Parameters "/QN /norestart"
        [string]$installPhase = 'Post-Installation'
        Copy-File -Path "\\ServerName\Sources\Applications\KeePass\Config files\KeePass.config.xml" -Destination "C:\Program Files (x86)\KeePass2x\KeePass.config.xml" -ContinueOnError $false
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'KeePass'
    }
}
