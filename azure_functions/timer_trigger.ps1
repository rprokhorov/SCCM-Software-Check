# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format.
$currentUTCtime = (Get-Date).ToUniversalTime()

if ($env:MSI_SECRET) {
    Disable-AzContextAutosave -Scope Process | Out-Null
    Connect-AzAccount -Identity
}

# The 'IsPastDue' property is 'true' when the current function invocation is later than scheduled.
#if ($Timer.IsPastDue) {
#    Write-Host "PowerShell timer is running late!"
#}

# Write an information log with the current time.
#Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
Function Send-Telegram {
Param([Parameter(Mandatory=$true)][String]$Message)
$Telegramtoken = $Env:telegram_bot_api
$Telegramchatid = $Env:Telegram_chat_id
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$($Telegramtoken)/sendMessage?chat_id=$($Telegramchatid)&text=$($Message)"
}

$application_list = @(
                    '7zip',
                    'AxurePR',
                    'FarManager',
                    'Fiddler',
                    'FileZilla',
                    'Git',
                    'GitExtensions',
                    'KLiteStandard',
                    'KeePass',
                    'MozillaFirefoxESR',
                    'mRemoteNG',
                    'Nmap',
                    'Notepadplusplus',
                    'Postman',
                    'PuTTY',
                    'RDCMan',
                    'RDTabs',
                    'SQLManagementStudio',
                    'TotalCommander',
                    'VLC',
                    'VisualStudioCode',
                    'WinRAR',
                    'WinSCP',
                    'Wireshark' 
                    )
Write-Host "Ping"

Foreach ($application in $application_list)
{
    $application = $application.ToLower()
    Write-Host $application
    switch ($application)
    {
        '7zip' {$body = Get-7zip  | ConvertTo-Json}
        'AxurePR' {$body = Get-AxurePR | ConvertTo-Json}
        #'CarambaSwitcherCorporate' {$body = Get-CarambaSwitcherCorporate | ConvertTo-Json} # Problems with DDoS protection from CloudFlare
        'FarManager' {$body = Get-FarManager | ConvertTo-Json}
        'Fiddler' {$body = Get-Fiddler | ConvertTo-Json}
        'FileZilla' {$body = Get-FileZilla | ConvertTo-Json}
        'Git' {$body = Get-Git | ConvertTo-Json}
        'GitExtensions' {$body = Get-GitExtensions | ConvertTo-Json}
        'KLiteStandard' {$body = Get-KLiteStandard | ConvertTo-Json}
        'KeePass' {$body = Get-KeePass | ConvertTo-Json}
        'MozillaFirefoxESR' {$body = Get-MozillaFirefoxESR | ConvertTo-Json}
        'mRemoteNG' {$body = Get-mRemoteNG | ConvertTo-Json}
        'Nmap' {$body = Get-Nmap | ConvertTo-Json}
        'Notepadplusplus' {$body = Get-Notepadplusplus | ConvertTo-Json}
        'Postman' {$body = Get-Postman | ConvertTo-Json}
        'PuTTY' {$body = Get-PuTTY | ConvertTo-Json}
        'RDCMan' {$body = Get-RDCMan | ConvertTo-Json}
        'RDTabs' {$body = Get-RDTabs | ConvertTo-Json}
        'SQLManagementStudio' {$body = Get-SQLManagementStudio | ConvertTo-Json}
        'TotalCommander' {$body = Get-TotalCommander | ConvertTo-Json}
        'VLC' {$body = Get-VLC | ConvertTo-Json}
        'VisualStudioCode' {$body = Get-VisualStudioCode | ConvertTo-Json}
        'WinRAR' {$body = Get-WinRAR | ConvertTo-Json}
        'WinSCP' {$body = Get-WinSCP | ConvertTo-Json}
        'Wireshark' {$body = Get-Wireshark | ConvertTo-Json}
        
        
        'All' {$body = @(
                            Get-7zip 
                            Get-AxurePR
                            #Get-CarambaSwitcherCorporate # не прогружаются версия и ссылки
                            Get-FarManager
                            Get-Fiddler
                            Get-FileZilla
                            Get-GitExtensions #fix version
                            Get-KLiteStandard
                            Get-KeePass
                            Get-MozillaFirefoxESR
                            Get-Nmap
                            Get-Notepadplusplus
                            Get-Postman
                            Get-PuTTY
                            Get-RDCMan
                            Get-RDTabs
                            Get-SQLManagementStudio
                            Get-TotalCommander
                            Get-VLC
                            Get-VisualStudioCode
                            Get-WinRAR
                            Get-WinSCP # fix download link
                            Get-Wireshark
                            Get-Git
                            Get-mRemoteNG
                            ) | ConvertTo-Json}
    }

    $version = $body | ConvertFrom-Json | Select-Object -ExpandProperty version
    $filename = $application+"_"+$version+".json"
    $filename_latest = $application+"_latest.json"
    $filename_compare = $application+"_compare.json"
    Write-Host $version
    Write-Host $filename

    Invoke-WebRequest -Uri "https://sccmsoftwarecheckstorage.blob.core.windows.net/$application/$($application)_latest.json" -OutFile "C:\home\site\wwwroot\temp_files\$filename_compare"
    $version_latest = Get-Content "C:\home\site\wwwroot\temp_files\$filename_compare" -raw | ConvertFrom-Json | Select-Object -ExpandProperty Version
    if ($version -ne $version_latest)
    {
        $resourceGroupName="sccm-software-check"
        $storageAccName="sccmsoftwarecheckstorage"
        $storageAcc=Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccName    
        $ctx=$storageAcc.Context
        $containers=Get-AzStorageContainer  -Context $ctx 

        $file_path = "C:\home\site\wwwroot\temp_files\$filename"
        $body | Out-File $file_path
        
        $Metadata = @{
            "key" = "value";
            "name" = "test"}
        $tags = @{
            "key" = "value";
            "name" = "test1"}
        Set-AzStorageBlobContent -Container $application.ToLower()  -Context $ctx -Blob $filename -File $file_path -Force -Tag $tags -Metadata $Metadata
        Set-AzStorageBlobContent -Container $application.ToLower()  -Context $ctx -Blob $filename_latest -File $file_path -Force -Tag $tags -Metadata $Metadata
        Send-Telegram -Message "Вышла новая версия $application $version"
    }
    else
    {
        $counter ++
    }
}
if ($counter -eq $application_list.Count)
{
    Send-Telegram -Message "Новых приложений нет."
}
Write-Host "Pong"
#Push-OutputBinding -Name outputBlob -Value  $body