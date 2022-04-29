$Config = @{
    appVendor = "Marek Jasinski"
    appName = "FreeCommander XE"
    appVersion = "19.0.790"
    appDetectionVersion = "19.0.790"
    appDetectionName = "FreeCommander XE"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "FreeCommander"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����� ������ ��..."
        $mainExitCode = Start-Process -FilePath  "$dirFiles\FreeCommanderXE-32-public_setup.exe"  -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /NORUN" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Start-Process -FilePath  "C:\Program Files (x86)\FreeCommander XE\unins000.exe" -ArgumentList "/VERYSILENT" -Wait
    }
}
       