$Config = @{
    appVendor = "SmartBear Software"
    appName = "SoapUI"
    appVersion = "5.6.0"
    appDetectionVersion = "5.6.0"
    appDetectionName = "SoapUI 5.6.0"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = ""
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����� ������ ��..."
        $mainExitCode = Start-Process -FilePath "$dirFiles\SoapUI-x64-5.6.0.exe"  -ArgumentList "-q" -wait

    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Start-Process -FilePath "C:\Program Files\SmartBear\SoapUI-5.6.0\uninstall.exe" -ArgumentList "-q" -Wait
    }
}
