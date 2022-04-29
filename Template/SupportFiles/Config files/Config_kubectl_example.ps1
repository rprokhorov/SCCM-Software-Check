$Config = @{
    appVendor = "kubernetes" #"Dominik Reichl"
    appName = "kubectl" #"KeePass"
    appVersion = "1.23.0" #"2.42.1"
    appDetectionVersion = "1.23.0" #"2.42.1"
    appDetectionName = "kubectl" # "KeePass"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProkhorov"
    close_app = "" #
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        
        if (!(Test-Path -Path "C:\Program Files\kubectl\" -ErrorAction SilentlyContinue))
        {
            New-Item "C:\Program Files\kubectl" -ItemType Directory
        }
        $mainExitCode = Copy-Item "$dirfiles\kubectl.exe" -Destination "C:\Program Files\kubectl\" -Force
        
        [string]$installPhase = 'Post-Installation'
        #Copy-File -Path "$dirSupportFiles\KeePass.config.xml" -Destination "C:\Program Files (x86)\KeePass2x\KeePass.config.xml" -ContinueOnError $false
        $path = [Environment]::GetEnvironmentVariable('PSModulePath', 'Machine')
        $newpath = $path + ';C:\Program Files\kubectl'
        [Environment]::SetEnvironmentVariable("PSModulePath", $newpath, 'Machine')
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Remove-Item -Path "C:\Program Files\kubectl\" -Force -Recurse
    }
}