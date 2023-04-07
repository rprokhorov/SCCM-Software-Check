using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)
$ProgressPreference = "SilentlyContinue"
# Write to the Azure Functions log stream.
#Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$name = ($Request.Query.Name).ToLower()
if (-not $name) {
    $name = ($Request.Body.Name).ToLower()
}

$versions = $Request.Query.version
if (-not $versions) {
    $versions = $Request.Body.version
}

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
    Write-Host "name = $name"
}
if ($versions) {
    Write-Host "version =  $versions"
}

Function Send-Telegram {
Param([Parameter(Mandatory=$true)][String]$Message)
$Telegramtoken = $Env:Telegram_bot_api
$Telegramchatid = $Env:Telegram_chat_id
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$($Telegramtoken)/sendMessage?chat_id=$($Telegramchatid)&text=$($Message)"
}

if ($name)
{
    if ($versions -eq 'check')
    {
        switch ($name)
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
    }
    else
    {
        if ($versions -ne 'latest' -and $versions -ne $null)
        {
            $filename = $name+"_"+$versions+".json"
            Write-Host $filename
            #$resourceGroupName="sccm-software-check"
            #$storageAccName="sccmsoftwarecheck"
            #$storageAcc=Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccName    
            #$ctx=$storageAcc.Context
            #$containers=Get-AzStorageContainer  -Context $ctx 
            $file_path = "C:\home\site\wwwroot\temp_files\$filename"
            #Invoke-WebRequest -Uri "https://sccmsoftwarecheck.blob.core.windows.net/$($name.ToLower())/$filename" -OutFile $file_path
            #Write-Host $file_path
            #Get-AzStorageBlobContent -Container $containers[0].Name  -Context $ctx -Blob $filename -Destination 'C:\home\site\wwwroot\temp_files' -Force
            $body =  [System.Text.Encoding]::Default.GetString((Invoke-WebRequest -Uri "https://sccmsoftwarecheckstorage.blob.core.windows.net/$($name.ToLower())/$filename" | Select-Object -ExpandProperty Content))
            #$body = Invoke-WebRequest -Uri 'https://sccmsoftwarecheck.blob.core.windows.net/git/vlc_3.0.16.json?sp=r&st=2022-03-24T21:46:09Z&se=2022-03-25T05:46:09Z&skoid=fb846453-8aec-40cf-bfef-598cbaa1d2fb&sktid=f211b049-89c0-4f49-9ecb-4e4e9cee326d&skt=2022-03-24T21:46:09Z&ske=2022-03-25T05:46:09Z&sks=b&skv=2020-08-04&spr=https&sv=2020-08-04&sr=b&sig=PkrwAb766qI8qfnhyfd3lkLfqGS4O3gDHi%2BMpfZFa3U%3D' | Select-Object -ExpandProperty Content
        }
        else
        {

            $filename = $name+"_latest.json"
            Write-Host $filename
            #$resourceGroupName="sccm-software-check"
            #$storageAccName="sccmsoftwarecheck"
            #$storageAcc=Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccName    
            #$ctx=$storageAcc.Context
            #$containers=Get-AzStorageContainer  -Context $ctx 
            $file_path = "C:\home\site\wwwroot\temp_files\$filename"
            #Invoke-WebRequest -Uri "https://sccmsoftwarecheck.blob.core.windows.net/$name/$filename" -OutFile $file_path
            #Write-Host  "https://sccmsoftwarecheck.blob.core.windows.net/$name/$filename" 
            #Write-Host $file_path
            #Get-AzStorageBlobContent -Container $containers[0].Name  -Context $ctx -Blob $filename -Destination 'C:\home\site\wwwroot\temp_files' -Force
            #$body = Get-Content $file_path -Raw
            $body =  [System.Text.Encoding]::Default.GetString((Invoke-WebRequest -Uri "https://sccmsoftwarecheckstorage.blob.core.windows.net/$($name.ToLower())/$filename" | Select-Object -ExpandProperty Content))
        }
        
    }
}
else
{
    $body = '<b>На данный момент доступен для проверки следующий списко ПО.</b>

<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=7zip">7zip</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=AxurePR">AxurePR</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=FarManager">FarManager</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=Fiddler">Fiddler</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=FileZilla">FileZilla</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=Git">Git</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=GitExtensions">GitExtensions</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=KLiteStandard">KLiteStandard</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=KeePass">KeePass</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=MozillaFirefoxESR">MozillaFirefoxESR</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=mRemoteNG">mRemoteNG</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=Nmap">Nmap</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=Notepadplusplus">Notepadplusplus</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=Postman">Postman</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=PuTTY">PuTTY</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=RDCMan">RDCMan</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=RDTabs">RDTabs</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=SQLManagementStudio">SQLManagementStudio</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=TotalCommander">TotalCommander</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=VLC">VLC</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=VisualStudioCode">VisualStudioCode</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=WinRAR">WinRAR</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=WinSCP">WinSCP</a></li>
<li><a href="https://sccm-software-check.azurewebsites.net/api/application?name=Wireshark">Wireshark</a></li>

Нормальная документация будет написана позже, так как делаю данный проект для души и по вечерам. </br> 
Если есть какие-то пожелания, нашли ошибку или просто хотите сказать, что я делаю какую-то фигню, то меня можно всегда найти тут: <a href="https://t.me/RProkhorov">@RProkhorov</a>
'

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
    ContentType = 'text/html'
})
}

Write-Host "Body:"
Write-Host $body
Send-Telegram $body
# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
    
})


#Push-OutputBinding -Name myOutputBlob -Value $body 