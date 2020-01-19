# Получает с сайта последнюю версию Adobe Flash Player NPAPI и если у нас нет такой версии, то сначала копирует шаблон устанвоки PSADT, заменяет в неём значения. После этого создаёт приложение в SCCM с заполнением всех нужых атрибутов.

#region Function
# Получение последней версии Adobe Flash Player NPAPI
function Get-AdobeFlashPlayerNPAPI ($URLPage){
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $Content = $result.RawContent
    # Create HTML file Object
    $HTMLObject = New-Object -Com "HTMLFile"
    # Write HTML content according to DOM Level2 
    try {
        # This works in PowerShell with Office installed
        $HTMLObject.IHTMLDocument2_write($content)
    }
    catch {
        # This works when Office is not installed    
        $src = [System.Text.Encoding]::Unicode.GetBytes($content)
        $HTMLObject.write($src)
    }
    ($HTMLObject.getElementsByTagName('p') | Where-Object { $_.className -eq 'NoBottomMargin' -and $_.id -eq 'AUTO_ID_columnleft_p_version' }).innerText -match "[0-9\.]+" | out-Null
    $global:Version = $Matches[0]
    $majorVersion = ([version] $global:Version).Major

    # Создаем массив, и помещаем готовые ссылки на скачивание контента
    #$DownLoadURL = @()
    #$DownLoadURL = "https://download.macromedia.com/pub/flashplayer/pdc/$global:Version/install_flash_player_${majorVersion}_active_x.msi"
    $DownLoadURL += "https://download.macromedia.com/get/flashplayer/pdc/$global:Version/install_flash_player_${majorVersion}_plugin.msi"
    #$DownLoadURL += "https://download.macromedia.com/pub/flashplayer/pdc/$global:Version/install_flash_player_${majorVersion}_ppapi.msi"
    Write-Host "-===========-" -ForegroundColor Green
    Write-Host "Product:  $global:Application"
    Write-Host "Search link: $URLPage"
    Write-Host "Version: "$global:Version
    Write-host "Download Link:    "$DownLoadURL
    Write-Host "Download path: $DistribPath\$global:Version\install_flash_player_${majorVersion}_plugin.msi"#`n$DistribPath\$global:Version\install_flash_player_${majorVersion}_plugin.msi`n$DistribPath\$global:Version\install_flash_player_${majorVersion}_ppapi.msi`n"
    $global:FileName = "install_flash_player_${majorVersion}_plugin.msi"
    $global:body  = "Product:  $global:Application `rSearch link: $URLPage `rVersion: $global:Version`rLink: $DownLoadURL `rDownload path: $DistribPath\$global:Version\$FileName `r"
    if (Test-Path "filesystem::$DistribPath\$global:Version\")
    {
        write-host "Версия уже есть $DistribPath\$global:Version\"
        $global:NewVersion = $false
    }
    Else
    {
        $global:NewVersion = $true
    Write-Host "Начинаю закачивание новой версии"
    Set-Location C:
    #cd C:
    New-Item -ItemType Directory -Path "$DistribPath\$version"  -Force
    # Копирую шаблон PSADT
    Copy-Item $PSADTTemplatePath -Destination "$DistribPath\$version" -Recurse
    Copy-Item -Path "$DistribPath\$version\SupportFiles\Config files\$global:templatename" -Destination "$DistribPath\$version\SupportFiles\Config.ps1" -Force
    (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appVersion%', "$version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName%', "$FileName") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%Publisher%', "$global:Publisher") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appName%', "$global:Application") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionVersion%', "$global:Version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionName%', "$global:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
    
    (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appVersion%', "$global:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionVersion%', "$global:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appName%', "$global:Application") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
    (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionName%', "$global:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
    
    $destination = "$DistribPath\$version\Files\$FileName"
    Invoke-WebRequest -Uri $DownLoadURL -OutFile $destination -UseBasicParsing -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox #-Proxy $ProxyURL -ProxyUseDefaultCredentials 
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
    New-CMApplication -Name $ApplicationName -LocalizedApplicationName $global:Application -Description $Description -SoftwareVersion $Version -Publisher $Publisher -LocalizedDescription $LocalizedDescription -IconLocationFile $IconLocationFile

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
    $global:Body += @"
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
        $Subject = "Available new version $global:Application",
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
$global:Application = "Adobe Flash Player NPAPI"
$global:Application_detection = "Adobe Flash Player*NPAPI"
$global:DirAppinConsole = "Adobe Flash Player"
$global:DistribPath = "$($Config.DistribPath)Adobe\Flash Player NPAPI"
$global:FileName = 'Adobe Flash Player.exe'
$URLPage = "https://get.adobe.com/en/flashplayer/"
$global:Version = '1.1'
$ProxyURL = $Config.ProxyURL
$global:PSADTTemplatePath = "$((get-item $psscriptroot).parent.FullName)\Template\*" #"$($Config.PSADTTemplatePath)\*"
$global:body = ''
$global:NewVersion = $null
$global:templatename = 'Config_AdobeFlashPlayerNPAPI_template.ps1'
$To= $Config.To
#endregion Variables

Try{
    Get-AdobeFlashPlayerNPAPI -URLPage $URLPage
    if ($global:NewVersion -eq $true)
    {
        #New-Application
        $global:ApplicationName = "$global:Application $global:version"
        $NewApplication_Properties = @{
            ApplicationName = "$global:ApplicationName"
            SourcesPath = "$global:DistribPath\$global:version"
            ProviderMachineName = $Config.ProviderMachineName
            SiteCode = $Config.SiteCode
            Application = $global:Application
            DirAppinConsole = $global:DirAppinConsole
            Description = "$global:Application application version: $($global:version) `rCreated by Script"
            Version = $global:Version
            Publisher = 'Adobe'
            InstallCommand = "Deploy-Application.exe"
            DPGroup = 'Distribution Point Group'
            TestCollection = "DA | $Application | Pilot | Required"
            ProdCollection = "DA | $Application | Prod | Required"
            TestUserCollection = "ALL | TEST | Application Catalog | Standard user"
            MSIFileName = '$global:FileName'
            UninstallCommand = """Deploy-Application.exe"" -DeploymentType Uninstall"
            LocalizedDescription = @"
            Adobe Flash Player - это компьютерное программное обеспечение для использования контента, созданного на платформе Adobe Flash, включая просмотр мультимедийного контента, выполнение многофункциональных интернет-приложений и потоковую передачу аудио и видео.
            NPAPI - Firefox
            PPAPI - Chrome
            ActiveX - Internet Explorer
"@
            IconLocationFile = "$((get-item $psscriptroot).parent.FullName)\Applications\$Application\icon.png"
            Scriptpath = "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        }
        New-Application @NewApplication_Properties
        Send-EmailAnonymously -Body $global:Body -To $To
    }
}
catch{}