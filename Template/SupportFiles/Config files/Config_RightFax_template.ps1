$Config = @{
    appVendor = "%Publisher%"
    appName = "%appName%"
    appVersion = "%appVersion%"
    appDetectionVersion = "%appDetectionVersion%"
    appDetectionName = "%appDetectionName%"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "FAXCTRL"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        $Domain = (Get-WmiObject Win32_ComputerSystem).Domain
        $FaxServer = @{
            'a.contoso.com' = 'srv.a.contoso.com'
            'b.contoso.com' = 'srv.b.contoso.com'
        }
        # Описание параметров ADDLOCAL="FaxUtil,FaxCtrl,EFM,Outlook"
        # FaxUtil -основаня утилита для пользователя
        # FaxCtrl - утилита администратора
        # EFM - хз
        # Outlook - плагин
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения ..."
        $mainExitCode = Execute-Process -Path "$dirFiles\%FileName%" -Parameters "/unattended=true /allowShutdown=true /add=FaxCtrl /drop=Outlook /rightFaxServer=$($FaxServer[$Domain])"
        # Так как инсталятор сразу возвращает код 0, то нужно сделать задержку на время установки
        Start-Sleep 60
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-Process -Path "$dirFiles\%FileName%" -Parameters "/remove /unattended=true /allowShutdown=true"
        # Так как инсталятор сразу возвращает код 0, то нужно сделать задержку на время установки
        Start-Sleep 60
    }
}
