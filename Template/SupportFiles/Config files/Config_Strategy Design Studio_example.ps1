$Config = @{
    appVendor = "Design Strategy"
    appName = "Strategy Design Studio v1.4 SP1"
    appVersion = "1.4 SP1"
    appDetectionVersion = "1.4 SP1"
    appDetectionName = "Strategy Design Studio v1.4 SP1"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����������..."
        $mainExitCode = Execute-Process -Path "$dirfiles\setupwin32.exe"  -Parameters "-options ""$dirfiles\silent.cfg"" -silent" -Wait
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
    }
}
