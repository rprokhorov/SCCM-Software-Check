$Config = @{
    appVendor = "JetBrains"
    appName = "PyCharm Community"
    appVersion = "221.5080.212"
    appDetectionVersion = "221.5080.212"
    appDetectionName = "PyCharm Community Edition 2022.1"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        $mainExitCode = Start-Process -FilePath "$dirfiles\pycharm-community-2022.1.exe" -ArgumentList "/CONFIG=$dirfiles\silent.config /S" -Wait  
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        if (Test-Path -Path "C:\Program Files\JetBrains\PyCharm Community Edition 2022.1\bin" -ErrorAction SilentlyContinue)
        {
            $mainExitCode = Start-Process -FilePath "C:\Program Files\JetBrains\PyCharm Community Edition 2022.1\bin\Uninstall.exe" -ArgumentList "/S" -Wait
        }
        if (Test-Path -Path "C:\Program Files (x86)\JetBrains\PyCharm Community Edition 2022.1\bin" -ErrorAction SilentlyContinue)
        {
            $mainExitCode = Start-Process -FilePath "C:\Program Files (x86)\JetBrains\PyCharm Community Edition 2022.1\bin\Uninstall.exe" -ArgumentList "/S" -Wait
        }
    }
}