$Config = @{
    appVendor = "Zabbix SIA"
    appName = "Zabbix Agent"
    appVersion = "4.4.1.2400"
    appDetectionVersion = "4.4.1.2400"
    appDetectionName = "Zabbix Agent"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RPRokhorov"
    close_app = "zabbix_agentd"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии..."
        if ($Is64Bit)
        {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\zabbix_agent-4.4.1-win-amd64-openssl.msi" -Parameters "/qn ENABLEREMOTECOMMANDS=1 SERVER=ServerZabbix.contoso.com SERVERACTIVE=ServerZabbix.contoso.com HOSTNAME=""$env:COMPUTERNAME"" TIMEOUT=30 INSTALLFOLDER=""C:\Program Files\Zabbix Agent"""
        }
        else 
        {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\zabbix_agent-4.4.1-win-i386-openssl.msi" -Parameters "/qn ENABLEREMOTECOMMANDS=1 SERVER=ServerZabbix.contoso.com SERVERACTIVE=ServerZabbix.contoso.com HOSTNAME=""$env:COMPUTERNAME"" TIMEOUT=30 INSTALLFOLDER=""C:\Program Files\Zabbix Agent"""
        }
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'Zabbix Agent'
    }
}