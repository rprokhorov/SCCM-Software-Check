$Config = @{
    appVendor = "Security Code"
    appName = 'ПАК "Соболь"'
    appVersion = "2.0.113"
    appDetectionVersion = "2.0.113"
    appDetectionName = 'ПАК "Соболь"' 
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "" #
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Import-Certificate -FilePath $dirfiles\sobol.cer -CertStoreLocation Cert:\LocalMachine\TrustedPublisher
        $mainExitCode = Execute-MSI -Action "Install" -Path "$dirfiles\Sobol-2.0.113-x64.msi" -Parameters "/qb"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        
    }
}