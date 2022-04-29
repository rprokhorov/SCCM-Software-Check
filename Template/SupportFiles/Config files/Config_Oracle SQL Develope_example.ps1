$Config = @{
    appVendor = "Oracle Corporation"
    appName = "Oracle SQL Developer"
    appVersion = "21.4.1.349.1822"
    appDetectionVersion = "21.4.1.349.1822"
    appDetectionName = "Oracle SQL Developer"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "NVladimirov"
    close_app = ""
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        if (Test-Path -Path 'C:\Program Files\Oracle' -ErrorAction SilentlyContinue) 
        {
            New-Item -ItemType Directory -Path 'C:\Program Files\Oracle'
        }
        if (Test-Path -Path 'C:\Program Files\Oracle\sqldeveloper' -ErrorAction SilentlyContinue) 
        {
            New-Item -ItemType Directory -Path 'C:\Program Files\Oracle\sqldeveloper'
        }
        Copy-Item -Path $dirFiles -Destination 'C:\Program Files\Oracle\sqldeveloper\' -Recurse | Out-Null
        New-Shortcut -Path "$envProgramData\Microsoft\Windows\Start Menu\SQL Developer.lnk" -TargetPath "C:\Program Files\Oracle\sqldeveloper\sqldeveloper.exe" -IconLocation "C:\Program Files\Oracle\sqldeveloper\sqldeveloper.exe" -Description 'SQL Developer' -WorkingDirectory "C:\Program Files\Oracle\sqldeveloper"
        New-Shortcut -Path "$env:PUBLIC\Desktop\SQL Developer.lnk" -TargetPath "C:\Program Files\Oracle\sqldeveloper\sqldeveloper.exe" -IconLocation "C:\Program Files\Oracle\sqldeveloper\sqldeveloper.exe" -Description 'SQL Developer' -WorkingDirectory "C:\Program Files\Oracle\sqldeveloper"
        # Set ACL to 'C:\Program Files\Oracle'
        $acl = Get-Acl 'C:\Program Files\Oracle\sqldeveloper'
        $ace = New-Object system.security.AccessControl.FileSystemAccessRule('Authenticated Users', 'ReadAndExecute','ContainerInherit,ObjectInherit', 'None', 'Allow') 
        $acl.AddAccessRule($ace)
        $acl | Set-Acl 
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-Item -Path "$envProgramData\Microsoft\Windows\Start Menu\SQL Developer.lnk"
        Remove-Item -Path "$env:PUBLIC\Desktop\SQL Developer.lnk"
        $mainExitCode = Remove-Item -Recurse -Force -Path 'C:\Program Files\Oracle\sqldeveloper\'

    }
}