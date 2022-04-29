    $Config = @{
    appVendor = "JetBrains"
    appName = "PhpStorm"
    appVersion = "2021.2.1"
    appDetectionVersion = "2021.2.1"
    appDetectionName = "PhpStorm"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        #Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����������..."
        $mainExitCode = Start-Process -FilePath "$dirfiles\PhpStorm-2021.2.1.exe" -ArgumentList "/CONFIG=$dirfiles\silent_PhpStorm.config /S" -Wait  
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Start-Process -FilePath "C:\Program Files (x86)\JetBrains\PhpStorm 2021.2.1\bin\Uninstall.exe" -ArgumentList "/S" -Wait
    }
}