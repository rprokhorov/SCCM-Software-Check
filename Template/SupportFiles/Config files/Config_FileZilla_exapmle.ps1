$Config = @{
    appVendor = "Tim Kosse"
    appName = "FileZilla"
    appVersion = "3.43.0"
    appDetectionVersion = "3.43.0"
    appDetectionName = "FileZilla"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "filezilla"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..." #-WindowLocation 'BottomRight'
        $mainExitCode = Execute-Process -Path "$dirFiles\FileZilla-3.43.0.msi"  -Parameters "/S /user=all"
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        $mainExitCode = Execute-Process -Path "C:\Program Files\FileZilla FTP Client\uninstall.exe"  -Parameters "/S"
    }
}