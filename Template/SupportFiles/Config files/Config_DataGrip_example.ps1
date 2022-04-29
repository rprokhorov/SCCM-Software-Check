$Config = @{
    appVendor = "JetBrains"
    appName = "DataGrip 2022.1"
    appVersion = "221.5080.155"
    appDetectionVersion = "221.5080.155"
    appDetectionName = "DataGrip 2022.1"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $mainExitCode = Start-Process -FilePath "$dirfiles\datagrip-2022.1.exe" -ArgumentList "/S /CONFIG=$dirfiles\silent_DataGrip.config" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        if (Test-Path -Path "C:\Program Files (x86)\JetBrains\DataGrip 2022.1\bin\Uninstall.exe" -ErrorAction SilentlyContinue) 
        {
            $mainExitCode = Start-Process -FilePath "C:\Program Files (x86)\JetBrains\DataGrip 2022.1\bin\Uninstall.exe" -ArgumentList "/S" -Wait
        }
        if (Test-Path -Path "C:\Program Files\JetBrains\DataGrip 2022.1\bin\Uninstall.exe" -ErrorAction SilentlyContinue)
        {
            $mainExitCode = Start-Process -FilePath "C:\Program Files\JetBrains\DataGrip 2022.1\bin\Uninstall.exe" -ArgumentList "/S" -Wait
        }
    }
}