$Config = @{
    appVendor = "WinMerge Development Team"
    appName = "WinMerge"
    appVersion = "2.16.10"
    appDetectionVersion = "2.16.10"
    appDetectionName = "WinMerge"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "WinMerge"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "��������� ���������� $appName `n��� [1/1] ��������� ����� ������ ��..."
        if ($Is64Bit)
        {
            $mainExitCode = Execute-Process -Path  "$dirFiles\WinMerge-2.16.10-x64.exe" -Parameters "/VERYSILENT /SP- /NORESTART"
        }
        else 
        {
            $mainExitCode = Execute-Process -Path  "$dirFiles\WinMerge-2.16.10-x86.exe" -Parameters "/VERYSILENT /SP- /NORESTART"
        }
       
     
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		   if ($Is64Bit)
           {
                $mainExitCode = Execute-Process -Path "C:\Program Files\WinMerge\unins000.exe"  -Parameters "/verysilent /NORESTART"
           }
           else 
           {
                $mainExitCode = Execute-Process -Path "C:\Program Files(x86)\WinMerge\unins000.exe"  -Parameters "/verysilent /NORESTART"
           }
    }
}