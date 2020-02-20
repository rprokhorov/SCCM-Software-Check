$Config = @{
    appVendor = "Simon Tatharm"
    appName = "Postman"
    appVersion = "7.18.0"
    appDetectionVersion = "7.18.0"
    appDetectionName = "Postman"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "Postman"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..."
        if ($envOSArchitecture = '64-bit'){
            Copy-Item "$dirFiles\x64\" -Destination 'C:\Program Files\' -Recurse
            $mainExitCode = Execute-Process -Path "C:\Program Files\x64\Update.exe"  -Parameters '--install="C:\Program Files\x64" -s'
            Remove-Item 'C:\Program Files\x64\' -Force -Recurse
        }
        else {
            Copy-Item "$dirFiles\x86\" -Destination 'C:\Program Files\' -Recurse
            $mainExitCode = Execute-Process -Path "C:\Program Files\x86\Update.exe"  -Parameters '--install="C:\Program Files\x86" -s'
            Remove-Item 'C:\Program Files\x86\' -Force -Recurse
        }
        New-Shortcut -Path "$envProgramData\Microsoft\Windows\Start Menu\Postman.lnk" -TargetPath "C:\Program Files\Postman\Postman.exe" -IconLocation "C:\Program Files\Postman\Postman.exe" -Description 'Postman' #-WorkingDirectory "$envHomeDrive\$envHomePath"
        Stop-Process -Name "Postman" -Force
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-Process -Path "C:\Program Files\Postman\Update.exe" -Parameters "--uninstall -s"
        Remove-Item 'C:\Program Files\Postman\' -Force -Recurse
    }
}
