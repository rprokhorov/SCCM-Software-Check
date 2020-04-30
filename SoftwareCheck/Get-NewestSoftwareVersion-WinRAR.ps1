# Получает с сайта последнюю версию WinRAR и если у нас нет такой версии, то сначала копирует шаблон устанвоки PSADT, заменяет в неём значения. После этого создаёт приложение в SCCM с заполнением всех нужых атрибутов.

#region Function
function Get-WinRAR ($URLPage){
    $result = Invoke-WebRequest -Uri $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.RawContent -match 'WinRAR and RAR [0-9\.]+ release' | Out-Null
    $script:Version = $Matches[0] -replace '[a-z ]+'
    $shortnewversion = $script:Version -replace "\."
    $script:FileName_x86 = $script:FileName_x86 -replace '%Version%', $shortnewversion
    $script:FileName_x64 = $script:FileName_x64 -replace '%Version%', $shortnewversion
    $DownloadURL_x86 = "https://www.rarlab.com/rar/wrar$($shortnewversion)ru.exe"
    $DownloadURL_x64 = "https://www.rarlab.com/rar/winrar-x64-$($shortnewversion)ru.exe"
    
    Write-Host "-===========-" -ForegroundColor Green
    Write-Host "Product:  $script:Application"
    Write-Host "Search link: $URLPage"
    Write-Host "Version: "$version
    Write-host "Download Link: $DownLoadURL_x86"
    Write-Host "Download path: $DistribPath\$version\$FileName_x86"
    Write-host "Download Link: $DownLoadURL_x64"
    Write-Host "Download path: $DistribPath\$version\$FileName_x64"
    $script:body  = "Product:  $script:Application `rSearch link: $URLPage `rVersion: $version`rLink: $DownloadURL_x86 `rDownload path: $DistribPath\$version\$FileName_x86 `rLink: $DownloadURL_x64 `rDownload path: $DistribPath\$version\$FileName_x64 `r"
    if (Test-Path "filesystem::$DistribPath\$version\")
    {
        write-host "Данная версия уже есть "
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
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName_x86%', "$FileName_x86") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName_x64%', "$FileName_x64") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%Publisher%', "$script:Publisher") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appName%', "$script:Application") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionName%', "$script:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appName%', "$script:Application") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionName%', "$script:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        
        $destination_x86 = "$DistribPath\$version\Files\$FileName_x86"
        $destination_x64 = "$DistribPath\$version\Files\$FileName_x64"
        Invoke-WebRequest -Uri $DownloadURL_x86 -OutFile $destination_x86 -UseBasicParsing -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox #-Proxy $ProxyURL -ProxyUseDefaultCredentials 
        Invoke-WebRequest -Uri $DownloadURL_x64 -OutFile $destination_x64 -UseBasicParsing -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox #-Proxy $ProxyURL -ProxyUseDefaultCredentials 
        # copy winrar license
        #Copy-Item -Path "\\SCCMServer\Sources\Applications\WinRAR\License\rarreg_Domain1.key" -Destination "$DistribPath\$version\Files"
        #Copy-Item -Path "\\SCCMServer\Sources\Applications\WinRAR\License\rarreg_Domain2.key" -Destination "$DistribPath\$version\Files"
        #Copy-Item -Path "\\SCCMServer\Sources\Applications\WinRAR\License\rarreg_Domain3.key" -Destination "$DistribPath\$version\Files"
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
        [PARAMETER(Mandatory=$True)]$Scriptpath,
        [PARAMETER(Mandatory=$True)]$LocalScriptpath,
        [PARAMETER(Mandatory=$False)]$UserCategory
    )
    
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

    #Create Application
    New-CMApplication -Name $ApplicationName -LocalizedApplicationName $script:Application -Description $Description -SoftwareVersion $Version -Publisher $Publisher -LocalizedDescription $LocalizedDescription -IconLocationFile $IconLocationFile
    Set-CMApplication -Name $ApplicationName -UserCategory $UserCategory -AutoInstall $true
    $DeploymentTypeProperties = @{
    InstallCommand = $InstallCommand
    DeploymentTypeName = "[DT] $ApplicationName"
    ApplicationName = $ApplicationName
    ContentLocation = $SourcesPath
    InstallationBehaviorType = 'InstallForSystem'
    InstallationProgramVisibility = 'Normal'
    UninstallCommand = $UninstallCommand
    ScriptLanguage = 'PowerShell'
    #RebootBehavior = 'NoAction'
    RequireUserInteraction = $true
    #ScriptFile = $scriptPath}
    ScriptText = (Get-Content -Path $LocalScriptpath) -join "`n"}
    Add-CMScriptDeploymentType @DeploymentTypeProperties
    
    
    # Move Application in Folder
    if ($DirAppinConsole -ne $null) {
        $Apps = Get-WmiObject -Namespace Root\SMS\Site_$SiteCode -Class SMS_ApplicationLatest -Filter "LocalizedDisplayName='$ApplicationName'"
        Create-CollectionFolder -FolderName $DirAppinConsole -SCCMSiteName $SiteCode -ErrorAction SilentlyContinue
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

Function Create-CollectionFolder
{
    param (
        [PARAMETER(Mandatory=$True)]$FolderName,
        [PARAMETER(Mandatory=$True)]$SCCMSiteName
    )
    #Object type 2 - Package Folder
    #Object type 7 - Query Folder
    #Object type 9 - Software Metering Folder
    #Object type 14 - Operating System Installers Folder
    #Object type 17 - State Migration GFolder
    #Object type 18 - Image Package Folder
    #Object type 19 - Boot Image Folder
    #Object type 20 - Task Sequence Folder
    #Object type 23 - Driver Package Folder
    #Object type 25 - Driver Folder
    #Object type 2011 - Configuration Baseline Folder
    #Object type 5000 - Device Collection Folder
    #Object type 5001 - User Collection Folder
    #Object type 6000 - Application Folder
    #Object type 6001 - Configuration Item Folder
    $CollectionFolderArgs = @{
        Name = $FolderName;
        ObjectType = "6000";
        ParentContainerNodeid = "0"
    }
    Set-WmiInstance -Class SMS_ObjectContainerNode -arguments $CollectionFolderArgs -namespace "root\SMS\Site_$SCCMSiteName" | Out-Null
}

#endregion Function

#region Variables
$Config = Get-Content "$PSScriptRoot\config.json" | ConvertFrom-Json 
$script:Application = "WinRAR"
$script:Application_detection = 'WinRAR'
$script:DirAppinConsole = "WinRAR"
$script:DistribPath = "$($Config.DistribPath)WinRAR"
$script:FileName_x86 = 'winrar-x86-%Version%-ru.exe'
$script:FileName_x64 = 'winrar-x64-%Version%-ru.exe'
$URLPage = "https://www.rarlab.com"
$script:Version = '1.1'
$ProxyURL = $Config.ProxyURL
$script:PSADTTemplatePath = "$((get-item $psscriptroot).parent.FullName)\Template\*" #"$($Config.PSADTTemplatePath)\*"
$script:body = ''
$script:NewVersion = $null
$script:templatename = 'Config_WinRAR_template.ps1'
$To= $Config.To
$From = $config.From
$MailServer = $Config.MailServer
$LocalDistribPath = $Config.LocalDistribPath
#endregion Variables

Try{
    Get-WinRAR -URLPage $URLPage
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
            Publisher = 'WinRAR'
            InstallCommand = "Deploy-Application.exe"
            DPGroup = 'Distribution Point Group'
            TestCollection = "DA | $Application | Pilot | Required"
            ProdCollection = "DA | $Application | Prod | Required"
            TestUserCollection = "ALL | TEST | Application Catalog | Standard user"
            MSIFileName = '$script:FileName'
            UninstallCommand = """Deploy-Application.exe"" -DeploymentType Uninstall"
            LocalizedDescription = @"
            WinRAR — архиватор файлов для 32- и 64-разрядных операционных систем Windows, позволяющий создавать/изменять/распаковывать архивы RAR и ZIP и распаковывать архивы множества других форматов
"@
            IconLocationFile = "$((get-item $psscriptroot).parent.FullName)\Applications\$Application\icon.png"
            Scriptpath = "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
            LocalScriptpath = "$LocalDistribPath\$version\SupportFiles\DetectionMethod.ps1"
        }
        New-Application @NewApplication_Properties
        Send-EmailAnonymously -Body $global:Body -To $To -SMTPServer $MailServer -From $From
    }
}
catch{}