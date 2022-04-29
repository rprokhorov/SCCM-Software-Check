$Config = @{
    appVendor = "Anaconda, Inc" 
    appName = "Anaconda" 
    appVersion = "2021.05" 
    appDetectionVersion = "2021.05" 
    appDetectionName = "Anaconda" 
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\Anaconda3-2021.05-Windows-x86_64.exe" -ArgumentList "/S /InstallationType=AllUsers /RegisterPython=1 /AddToPath=1 /D=C:\Program Files\Anaconda" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Start-Process -FilePath "C:\Program Files\Anaconda\Uninstall-Anaconda3.exe" -ArgumentList "/S" -Wait 
    }
}