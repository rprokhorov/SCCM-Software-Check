$Config = @{
    appVendor ="Ghisler Software GmbH"
    appName = "Total Commander"
    appVersion = ""
    appDetectionVersion = "9.22a"
    appDetectionName = "Total Commander"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "TOTALCMD", 'TOTALCMD64'
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
		Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/4] установка приложения..." #-WindowLocation 'BottomRight'
		# Установка MSI файла с параметрами
        $mainExitCode = Execute-Process -Path "$dirFiles\tcmd922ax32_64.exe" -Parameters "/A1H1L4M1D1U1K1G1"
        [string]$installPhase = 'Post-Installation'
        
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/4] Перемещение файлов..." #-WindowLocation 'BottomRight'
        New-Item -ItemType Directory -Path 'C:\Program Files\Total Commander' -ErrorAction SilentlyContinue
        Get-ChildItem -Path C:\totalcmd\* | Move-Item -Destination 'C:\Program Files\Total Commander' -ErrorAction SilentlyContinue
        Remove-Item C:\totalcmd -Force -ErrorAction SilentlyContinue

        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [3/4] Создание ярлыка" #-WindowLocation 'BottomRight'
        #New-Item "$env:SystemDrive\Users\Public\Desktop\VLC media player.lnk" -Force
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$env:SystemDrive\Users\Public\Desktop\Total Commander.lnk")
        $Shortcut.TargetPath = "C:\Program Files\Total Commander\TOTALCMD.EXE"
        $Shortcut.Save()
        
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [4/4] Создание ярлыка" #-WindowLocation 'BottomRight'
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Ghisler\Total Commander\' -Name InstallDir -Value 'C:\Program Files\Total Commander'
        if($envOSArchitecture -eq '64-bit')
        {
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Totalcmd64\' -Name UninstallString -Value 'C:\Program Files\Total Commander\tcunin64.exe'
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Totalcmd64\' -Name DisplayIcon -Value 'C:\Program Files\Total Commander\tcunin64.exe'
        }
        else 
        {
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Totalcmd\' -Name UninstallString -Value 'C:\Program Files\Total Commander\tcunin.exe'
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Totalcmd\' -Name DisplayIcon -Value 'C:\Program Files\Total Commander\tcunin.exe'
        }
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        if($envOSArchitecture -eq '64-bit')
        {
            $mainExitCode = Execute-Process -Path "'C:\Program Files\Total Commander\tcunin64.exe'" -Parameters "/7"
        }
        else
        {
            $mainExitCode = Execute-Process -Path "'C:\Program Files\Total Commander\tcunin.exe'" -Parameters "/7"
        }
    }
}