$Config = @{
    appVendor = "GIMP Team"
    appName = "GIMP"
    appVersion = "2.10.30"
    appDetectionVersion = "2.10.30"
    appDetectionName = "GIMP"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "GIMP"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����� ������ ��..."
        $mainExitCode = Start-Process -FilePath  "$dirFiles\gimp-2.10.22.exe"  -ArgumentList "/VERYSILENT /NORESTART /RESTARTEXITCODE=3010 /SUPPRESSMSGBOXES /SP-"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Start-Process -FilePath "C:\Program Files\GIMP 2\uninst\unins000.exe"  -ArgumentList "/verysilent /NORESTART"
    }
}