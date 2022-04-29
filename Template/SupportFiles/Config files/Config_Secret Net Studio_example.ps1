$Config = @{
    appVendor = "Security Code"
    appName = "Secret Net Studio"
    appVersion = "8.5.5329.0"
    appDetectionVersion = "8.5.5329.0"
    appDetectionName = "Secret Net Studio"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $counter = 0
        $Starttime = Get-Date
        # Edit config file, becouse it use abolute path :(
        (Get-Content "$dirFiles\SnInst.rsp").replace('%dirfiles%', "$dirFiles") | Set-Content "$dirFiles\SnInst.rsp"
        #$scriptblock = {Execute-MSI -Action 'Install' -Path "$dirFiles\Setup\Client\x64\InstAgent.msi" -Parameters '/QN /norestart'}
        $scriptblock = {& "$dirFiles\Setup\Client\x64\InstAgent.msi"  /l*v "C:\Windows\Logs\Software\InstAgent_Install.log" /qn}
        Invoke-Command -ScriptBlock $scriptblock  -ErrorAction SilentlyContinue
        while((Get-WmiObject -Class Win32_product  -Filter {Name like 'Secret Net Studio%'}).Count -lt 3)
        {
            # Search by events in Windows Event log
            #$Secret_1 = Get-EventLog -LogName Application -Source MsiInstaller -Newest 120 | ? {$_.Message -eq "Product: Secret Net Studio - Базовая защита -- Configuration completed successfully." -and $_.TimeGenerated -ge $Starttime}
            #$Secret_2 = Get-EventLog -LogName Application -Source MsiInstaller -Newest 120 | ? {$_.Message -eq "Product: Secret Net Studio - Локальная защита -- Configuration completed successfully." -and $_.TimeGenerated -ge $Starttime}
            #if($Secret_1 -and $Secret_2)
            #{
            #    $counter = 2
                #$mainExitCode = 0
            #}
            #else
            #{
                Start-Sleep 5
            #}
        }
        if ((Get-WmiObject -Class Win32_product  -Filter {Name like 'Secret Net Studio%'}).Count -ge 3)
        {
            Start-Sleep -Seconds 60
            $mainExitCode = 0
        }
        
        
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
    }
}
