$Config = @{
    appVendor = ""
    appName = "GreenShot"
    appVersion = "1.2.10.6"
    appDetectionVersion = "1.2.10.6"
    appDetectionName = "GreenShot"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "GreenShot"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка новой версии ПО..."
        $mainExitCode = Start-Process -FilePath  "$dirFiles\Greenshot-1.2.10.6.exe"  -ArgumentList "/SP- /VERYSILENT  /NORESTART /CLOSEAPPLICATIONS /NORUN"
        Get-Process * -IncludeUserName|where  {(($_.ProcessName -like '*firefox*') -or ($_.ProcessName -like '*chrome*')-or ($_.ProcessName -like '*iexplore*')-or ($_.ProcessName -eq 'OpenWith')) -and($_.UserName -like '*SYSTEM*')} |Stop-Process -Force -ErrorAction SilentlyContinue       
     
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Get-Process Greenshot* | Stop-Process -Force -ErrorAction SilentlyContinue
		$mainExitCode = Start-Process -FilePath "C:\Program Files\Greenshot\unins000.exe" -ArgumentList "/verysilent /NORESTART"
    }
}
       