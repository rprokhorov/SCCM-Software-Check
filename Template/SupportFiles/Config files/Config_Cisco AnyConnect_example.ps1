$Config = @{
    appVendor = "Cisco Systems, Inc."
    appName = "Cisco AnyConnect"
    appVersion = "4.8.0352"
    appDetectionVersion = "4.8.0352"
    appDetectionName = "Cisco AnyConnect"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $count = 0
        $CleanInstall = 0
        
        # Проверяем хэш файла конфигурации и подменяем его.
        Write-Log -Message "Sleep 5 sec" -Source 'Config files' -LogType 'CMTrace'
        Start-Sleep -Seconds 5
        Write-Log -Message "Check configuration files" -Source 'Config files' -LogType 'CMTrace'
        $ConfigHash = Get-FileHash -Path "$dirFiles\nam\configuration.xml"
        if ((Get-FileHash -Path "$env:ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Network Access Manager\system\configuration.xml" -ErrorAction SilentlyContinue).Hash -ne $ConfigHash.hash)
        {
            Write-Log -Message "File hash is not right" -Source 'Config files' -LogType 'CMTrace'
            New-Item -ItemType Directory "$env:ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Network Access Manager\newConfigFiles" -ErrorAction SilentlyContinue
            Copy-Item -Path "$dirFiles\nam\configuration.xml" -Destination "$env:ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Network Access Manager\newConfigFiles\" -Force
            Write-Log -Message "Rastart service 'nam'" -Source 'Config files' -LogType 'CMTrace'
            Restart-Service nam -Force -ErrorAction SilentlyContinue
            Start-Sleep 10
        }
        else
        {
            Write-Log -Message "File hash is right" -Source 'Config files' -LogType 'CMTrace'
        }


        # Если не убить процесс vpnUI, то обнолвение будет падать с ошибкой 1603 из-за заблокированного каталога C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Help, но можножно что и другие каталоги выше тоже заблокированы.
        Stop-Process -Name 'vpnUI' -Force
        # Устанавливаем софт и проверяем был ли он установлен заранее (для подсчёта обнолвение или чистая установка)
        # 1. Cisco AnyConnect Secure Mobility Client
        if (Get-InstalledApplication -Name "Cisco AnyConnect Secure Mobility Client")
        {
            $CleanInstall++
        }
        Execute-MSI -Action "Install" -Path "anyconnect-win-4.8.03052-core-vpn-predeploy-k9.msi" -Transform 'COREVPN_Disable_CustExpFeedback_VPNGUI.mst' -Parameters "/qn /norestart PRE_DEPLOY_DISABLE_VPN=1"

        # 2. Cisco AnyConnect Network Access Manager
        if (Get-InstalledApplication -Name "Cisco AnyConnect Network Access Manager")
        {
            $CleanInstall++ 
        }
        Execute-MSI -Action "Install" -Path "anyconnect-win-4.8.03052-nam-predeploy-k9.msi" -Parameters "/qn /norestart "
        
        # 3. Cisco AnyConnect Diagnostics and Reporting Tool
        if (Get-InstalledApplication -Name "Cisco AnyConnect Diagnostics and Reporting Tool")
        {
            $CleanInstall++
        }
        Execute-MSI -Action "Install" -Path "anyconnect-win-4.8.03052-dart-predeploy-k9.msi" -Parameters "/qn /norestart "
        
        
        # Проверем, что есть папка для новой конфигурации
        if (!(test-path "$env:ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Network Access Manager\newConfigFiles" -ErrorAction SilentlyContinue))
        {
            New-Item -Path "$env:ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Network Access Manager\" -ItemType Directory  -Name "newConfigFiles" -force
        }
        
        # Создаём ключ в реестре для отлючения EnforceSingleLogon (отключаем, чтобы могли быть залогинены более 1го пользователя).
        if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{B12744B8-5BB7-463a-B85E-BB7627E73002}').EnforceSingleLogon -ne 0)
        {
            Set-RegistryKey -Key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{B12744B8-5BB7-463a-B85E-BB7627E73002}' -Name 'EnforceSingleLogon' -Type 'Dword' -Value '0'
        }
        
        
        

        # Если был процесс обнолвения с одной версии на другую, то нужно перезапустить службу.
        if ($CleanInstall -eq 0)
        {
            # Clean Install
        }
        else 
        {
            # Update application
        }
        Write-Log -Message "Show restart window" -Source 'Restart' -LogType 'CMTrace'
        $message = "Уважаемый коллега, в течение 10 минут ваш компьютер будет перезагружен. Пожалуйста, сохраните все документы к этому времени. Приносим извинения за доставленные неудобства."
        shutdown.exe /r /t 600 /f /c "$message" /d p:4:1
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-MSIApplications -Name 'Cisco AnyConnect Network Access Manager'
        Remove-MSIApplications -Name 'Cisco AnyConnect Secure Mobility Client'
        Remove-MSIApplications -Name 'Cisco AnyConnect Diagnostics and Reporting Tool'
        Stop-Process -Name 'vpnUI' -Force
        Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{B12744B8-5BB7-463a-B85E-BB7627E73002}' -Recurse -Force
        Remove-Item -Path "$env:ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client" -Recurse -Force
        Remove-Item -Path "$env:ProgramData\Cisco\Cisco AnyConnect VPN Client" -Recurse -Force
        gpupdate /force
        $message = "Уважаемый коллега, в течение 10 минут ваш компьютер будет перезагружен. Пожалуйста, сохраните все документы к этому времени. Приносим извинения за доставленные неудобства."
        shutdown.exe /r /t 600 /f /c "$message" /d p:4:1
    }
}