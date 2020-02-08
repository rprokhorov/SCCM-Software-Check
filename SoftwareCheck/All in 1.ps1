Start-Transcript -Path $PSScriptRoot\Logs\transcript_"$((Get-Date -Format 'yyyy-MM').ToString())".log -Append -Force
#& "$PSScriptRoot\Get-NewestSoftwareVersion-7zip.ps1"
& "$PSScriptRoot\Get-NewestSoftwareVersion-AdobeFlashPlayer_ActiveX.ps1"# work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-AdobeFlashPlayer_NPAPI.ps1"# work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-AdobeFlashPlayer_PPAPI.ps1"# work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-AdobeReaderDC_CleanInstall.ps1"# work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-AxureRP.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-FarManager.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-Fiddler.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-FileZilla.ps1" # Work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-git.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-GitExtensions.ps1" # Work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-KeePass.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-KLite.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-MozillaESR.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-mRemoteNG.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-Nmap.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-Notepad++.ps1" # work!
#& "$PSScriptRoot\Get-NewestSoftwareVersion-Paint.Net.ps1"
& "$PSScriptRoot\Get-NewestSoftwareVersion-Putty.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-SQLManagementStudio.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-TotalCommander.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-VisualStudioCode.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-VLC.ps1" # work!
#& "$PSScriptRoot\Get-NewestSoftwareVersion-VMWareTools.ps1"
& "$PSScriptRoot\Get-NewestSoftwareVersion-WinRAR.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-Wireshark.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-XMind.ps1" # work!
& "$PSScriptRoot\Get-NewestSoftwareVersion-XnView.ps1" # work!
#& "$PSScriptRoot\Get-NewestSoftwareVersion-Yandex.Browser.ps1"
Stop-Transcript