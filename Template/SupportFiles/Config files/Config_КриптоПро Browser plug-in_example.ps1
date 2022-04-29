$Config = @{
    appVendor = "Компания КриптоПро"
    appName = "КриптоПро Browser plug-in"
    appVersion = "2.0.14459"
    appDetectionVersion = "2.0.14459"
    appDetectionName = "КриптоПро ЭЦП Browser plug-in"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\cadesplugin.exe" -ArgumentList "-silent -norestart -cadesargs `"/quiet`"" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Remove-MSIApplications -Name 'КриптоПро ЭЦП Browser plug-in'
    }
}