#region Function
# Получение последней версии XnView
function Get-MSPProductcode {
    param (
        [IO.FileInfo] $patchnamepath
    )
    try {
        $wi = New-Object -com WindowsInstaller.Installer
        $mspdb = $wi.GetType().InvokeMember("OpenDatabase", "InvokeMethod", $Null, $wi, $($patchnamepath.FullName, 32))
        $su = $mspdb.GetType().InvokeMember("SummaryInformation", "GetProperty", $Null, $mspdb, $Null)
        #$pc = $su.GetType().InvokeMember("PropertyCount", "GetProperty", $Null, $su, $Null)
          
        [String] $productcode = $su.GetType().InvokeMember("Property", "GetProperty", $Null, $su, 7)
        return $productcode
    }
    catch {
        Write-Output $_.Exception.Message
        return $NULL
    }
}

function Get-WinSCP  ($URLPage){
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.Content -match "Version [0-9\.]+" | Out-Null
    ($result.Links | ? {$_.href -like '*.exe'}).href -match '[0-9\.]+' | Out-Null
    $script:Version = $Matches[0]
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL_html = Invoke-WebRequest "https://winscp.net$(($result.Links | ? {$_.href -like '*.exe'}).href)" -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials
    $DownloadURL = ($DownloadURL_html.Links | ?{$_.href -like '*.exe'}).href
    Write-Host "-===========-" -ForegroundColor Green
    Write-Host "Product:  $script:Application"
    Write-Host "Search link: $URLPage"
    Write-Host "Version: "$version
    Write-host "Download Link: "$DownLoadURL
    Write-Host "Download path: $DistribPath\$version\$FileName"
    $script:body  = "Product:  $script:Application `rSearch link: $URLPage `rVersion: $version`rLink: $DownLoadURL `rDownload path: $DistribPath\$version\$FileName `r"
    if (Test-Path "filesystem::$DistribPath\$version\")
    {
        write-host "Версия уже есть"
        $script:NewVersion = $false
    }
    Else
    {
        $script:NewVersion = $true
        Write-Host "Начинаю закачивание новой версии"
        Set-Location C:
        #cd C:
        New-Item -ItemType Directory -Path "$DistribPath\$version"  -Force
        # Копирую шаблон PSADT
        Copy-Item $PSADTTemplatePath -Destination "$DistribPath\$version" -Recurse
        Copy-Item -Path "$DistribPath\$version\SupportFiles\Config files\$script:templatename" -Destination "$DistribPath\$version\SupportFiles\Config.ps1" -Force
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appVersion%', "$version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName%', "$FileName") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%Publisher%', "$script:Publisher") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appName%', "$script:Application") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionName%', "$script:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appName%', "$script:Application") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionName%', "$script:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        
        $destination = "$DistribPath\$version\Files\$FileName"
        Invoke-WebRequest -Uri $DownLoadURL -OutFile $destination -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
    }
    Write-Host "-===========-" -ForegroundColor Green
}

function New-Application {
    param (
        [PARAMETER(Mandatory=$True)]$ApplicationName,
        [PARAMETER(Mandatory=$True)]$SourcesPath,
        [PARAMETER(Mandatory=$True)]$ProviderMachineName,
        [PARAMETER(Mandatory=$True)]$SiteCode,
        [PARAMETER(Mandatory=$True)]$Application,
        [PARAMETER(Mandatory=$True)]$DirAppinConsole,
        [PARAMETER(Mandatory=$True)]$Description,
        [PARAMETER(Mandatory=$True)]$Version,
        [PARAMETER(Mandatory=$False)]$Publisher,
        [PARAMETER(Mandatory=$True)]$InstallCommand,
        [PARAMETER(Mandatory=$True)]$DPGroup,
        [PARAMETER(Mandatory=$True)]$TestCollection,
        [PARAMETER(Mandatory=$True)]$ProdCollection,
        [PARAMETER(Mandatory=$True)]$TestUserCollection,
        [PARAMETER(Mandatory=$True)]$MSIFileName,
        [PARAMETER(Mandatory=$True)]$UninstallCommand,
        [PARAMETER(Mandatory=$False)]$LocalizedDescription,
        [PARAMETER(Mandatory=$False)]$IconLocationFile,
        [PARAMETER(Mandatory=$True)]$Scriptpath
    )
    Write-Host "Get-Module ConfigurationManage"  -ForegroundColor DarkGreen
    #region Import the ConfigurationManager module and change PSDrive
    if((Get-Module ConfigurationManager) -eq $null) {
        Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1"
    }
    # Connect to the site's drive if it is not already present
    if((Get-PSDrive -Name $SiteCode -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
        New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $ProviderMachineName 
    }
    $SaveLocation = Get-Location
    Set-Location "$($SiteCode):\"
    #endregion

    #if (Test-Path $IconLocationFile)
    #{
        Write-Host "New-CMApplication" -ForegroundColor DarkGreen
        #Create Application
        New-CMApplication -Name $ApplicationName -LocalizedApplicationName $script:Application -Description $Description -SoftwareVersion $Version -Publisher $Publisher -LocalizedDescription $LocalizedDescription -IconLocationFile $IconLocationFile

        $DeploymentTypeProperties = @{
        InstallCommand = $InstallCommand
        DeploymentTypeName = "[DT] $ApplicationName"
        ApplicationName = $ApplicationName
        ContentLocation = $SourcesPath
        InstallationBehaviorType = 'InstallForSystem'
        InstallationProgramVisibility = 'Normal'
        UninstallCommand = $UninstallCommand
        ScriptLanguage = 'PowerShell' 
        ScriptFile = $scriptPath}
        Add-CMScriptDeploymentType @DeploymentTypeProperties

        # Move Application in Folder
        if ($DirAppinConsole -ne $null) {
            $Apps = Get-WmiObject -Namespace Root\SMS\Site_$SiteCode -Class SMS_ApplicationLatest -Filter "LocalizedDisplayName='$ApplicationName'"
            $TargetFolderID = Get-WmiObject -Namespace Root\SMS\Site_$SiteCode -Class SMS_ObjectContainerNode -Filter "ObjectType='6000' and Name='$DirAppinConsole'"
            $CurrentFolderID = 0
            $ObjectTypeID = 6000
            $WMIConnectionString = "\\$ProviderMachineName\root\SMS\Site_$SiteCode" + ":SMS_objectContainerItem"
            $WMIConnection = [WMIClass]$WMIConnectionString
            $MoveItem = $WMIConnection.psbase.GetMethodParameters("MoveMembers")
            $MoveItem.ContainerNodeID = $CurrentFolderID
            $MoveItem.InstanceKeys = $Apps.ModelName
            $MoveItem.ObjectType = $ObjectTypeID
            $MoveItem.TargetContainerNodeID = $TargetFolderID.ContainerNodeID
            $WMIConnection.psbase.InvokeMethod("MoveMembers", $MoveItem, $null)
        }

        # Distribute content on DP
        Start-CMContentDistribution -ApplicationName $ApplicationName -DistributionPointGroupName $DPGroup

        #Remove previous deployments
        #Get-CMDeployment -CollectionName $TestCollection | Where-Object { $PSItem.ApplicationName -like "${Application}*" } | Remove-CMDeployment -Force
        #Get-CMDeployment -CollectionName $ProdCollection | Where-Object { $PSItem.ApplicationName -like "${Application}*" } | Remove-CMDeployment -Force
        #Get-CMDeployment -CollectionName $TestUserCollection | Where-Object { $PSItem.ApplicationName -like "${Application}*" } | Remove-CMDeployment -Force
    
        # Create deployments
        #$DateTest = (Get-Date).AddHours(3)
        #$DateProd = (Get-Date).AddDays(14)
        #New-CMApplicationDeployment -Name $ApplicationName -CollectionName $TestCollection -DeployPurpose Required -UserNotification HideAll -AvailableDateTime $DateTest
        #New-CMApplicationDeployment -Name $ApplicationName -CollectionName $ProdCollection -DeployPurpose Required -UserNotification HideAll -AvailableDateTime $DateProd
        #New-CMApplicationDeployment -Name $ApplicationName -CollectionName $TestUserCollection -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly -AvailableDateTime $DateTest
        # Return Location
        Set-Location $SaveLocation

        # Generate Mail Body
        $script:Body += @"
    Created application '$ApplicationName'.
"@
    #Deployment assigned to '$TestCollection' starts on $DateTest.
    #Deployment assigned to '$ProdCollection' starts on $DateProd.
    #"@

        # Return Location
        Set-Location $SaveLocation
    #}
}

function Send-EmailAnonymously {
    param (
        $User = "anonymous",
        $SMTPServer = "SMTPServer.contoso.com",
        $From = "SCCMServer@contoso.com",
        [PARAMETER(Mandatory=$True)]$To,
        $Subject = "Available new version $script:Application",
        $Body
    )
    $PWord = ConvertTo-SecureString -String "anonymous" -AsPlainText -Force
    $Creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -Credential $Creds -Encoding Default -Priority High
}

#endregion Function

#region Variables
$Config = Get-Content "$PSScriptRoot\config.json" | ConvertFrom-Json
$script:Application = "WinSCP "
$script:Application_detection = 'WinSCP'
$script:DirAppinConsole = "WinSCP"
$script:DistribPath = "$($Config.DistribPath)WinSCP"
$script:FileName = 'WinSCP-%Version%.exe'
$URLPage = 'https://winscp.net/eng/download.php'
$script:Version = '1.1'
$ProxyURL = $Config.ProxyURL
$script:PSADTTemplatePath = "$((get-item $psscriptroot).parent.FullName)\Template\*" #"$($Config.PSADTTemplatePath)\*"
$script:body = ''
$script:NewVersion = $null
$script:Publisher = 'Martin Prikryl'
$script:templatename = 'Config_WinSCP_template.ps1'
$To= $Config.To
#endregion Variables

Try{
    Get-WinSCP -URLPage $URLPage
    if ($script:NewVersion -eq $true)
    {
        #New-Application
        $script:ApplicationName = "$script:Application $script:version"
        $NewApplication_Properties = @{
            ApplicationName = "$script:ApplicationName"
            SourcesPath = "$script:DistribPath\$script:version"
            ProviderMachineName = $Config.ProviderMachineName
            SiteCode = $Config.SiteCode
            Application = $script:Application
            DirAppinConsole = $script:DirAppinConsole
            Description = "$script:Application application version: $($script:version) `rCreated by Script"
            Version = $script:Version
            Publisher = $script:Publisher
            InstallCommand = "Deploy-Application.exe"
            DPGroup = 'Distribution Point Group'
            TestCollection = "DA | $Application | Pilot | Required"
            ProdCollection = "DA | $Application | Prod | Required"
            TestUserCollection = "ALL | TEST | Application Catalog | Standard user"
            MSIFileName = "$script:FileName"
            UninstallCommand = """Deploy-Application.exe"" -DeploymentType Uninstall"
            LocalizedDescription = "WinSCP — свободный графический клиент протоколов SFTP и SCP, предназначенный для Windows. Распространяется по лицензии GNU GPL. Обеспечивает защищённое копирование файлов между компьютером и серверами, поддерживающими эти протоколы."
            IconLocationFile = "$((get-item $psscriptroot).parent.FullName)\Applications\$Application\icon.png"
            Scriptpath = "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        }
        New-Application @NewApplication_Properties
        Send-EmailAnonymously -Body $script:Body -To $To
    }
}
catch{}