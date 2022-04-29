$Config = @{
    appVendor = "Joachim Marder e.K."
    appName = "TreeSize Free"
    appVersion = "4.4.2"
    appDetectionVersion = "4.4.2"
    appDetectionName = "TreeSize Free"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "WinMerge"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����� ������ ��..."
        $mainExitCode = Execute-Process -Path  "$dirFiles\TreeSizeFree-4.42.exe" -Parameters "/VERYSILENT /SP- /NORESTART"   
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        If (([environment]::Is64BitOperatingSystem) -match 'True'){$path = (Get-ItemProperty 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\TreeSize Free_is1\').InstallLocation}
        Else {$path = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TreeSize Free_is1').InstallLocation}   
        $mainExitCode = Execute-Process -Path ($path+"unins000.exe")  -Parameters "/VERYSILENT /SUPPRESSMSGBOXES"
          
    }
}