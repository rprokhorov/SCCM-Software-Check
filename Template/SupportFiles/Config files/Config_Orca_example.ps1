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
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        Execute-MSI -Action 'Install' -Path "$dirFiles\Orca-10.1.19041.1-x86.msi" -Parameters '/QN /norestart'

    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
		$mainExitCode = Remove-MSIApplications -Name 'Orca' '/QN'
    }
}
#ORCA — Браузер для просмотра баз данных и легкого доступа к таблицам входящих в пакет Windows Installer

