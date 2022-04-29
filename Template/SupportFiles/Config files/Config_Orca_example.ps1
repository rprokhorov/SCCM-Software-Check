$Config = @{
    appVendor = "Microsoft Corporation"
    appName = "Orca"
    appVersion = "10.1.19041.1"
    appDetectionVersion = "10.1.19041.1"
    appDetectionName = "Orca"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Orca"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����� ������ ��..."
        Execute-MSI -Action 'Install' -Path "$dirFiles\Orca-10.1.19041.1-x86.msi" -Parameters '/QN /norestart'

    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Orca' '/QN'
    }
}
#ORCA � ������� ��� ��������� ��� ������ � ������� ������� � �������� �������� � ����� Windows Installer

