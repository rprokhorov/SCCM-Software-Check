$Config = @{
    appVendor = "devicelock"
    appName = "DeviceLock Service"
    appVersion = "8.1.14.66453"
    appDetectionVersion = "8.1.14.66453"
    appDetectionName = "DeviceLock"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $Name_msi = "DeviceLock Service_ x64.msi"
        if ($Is64Bit)
        {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\DeviceLock Service_ x64.msi" -Parameters '/QN /norestart'
        }
        else {
            $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\DeviceLock Service_ x86.msi" -Parameters '/QN /norestart'
        }

    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name $appDetectionName
    }
}
