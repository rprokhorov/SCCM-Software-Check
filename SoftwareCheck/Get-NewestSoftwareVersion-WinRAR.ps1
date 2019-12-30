# Получает с сайта последнюю версию WinRAR и если у нас нет такой версии, то сначала копирует шаблон устанвоки PSADT, заменяет в неём значения. После этого создаёт приложение в SCCM с заполнением всех нужых атрибутов.

#region Function
function Get-WinRAR ($URLPage){
    $result = Invoke-WebRequest -Uri $URLPage -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.RawContent -match 'WinRAR and RAR [0-9\.]+ release' | Out-Null
    $global:Version = $Matches[0] -replace '[a-z ]+'
    $shortnewversion = $global:Version -replace "\."
    $global:FileName_x86 = $global:FileName_x86 -replace '%Version%', $shortnewversion
    $global:FileName_x64 = $global:FileName_x64 -replace '%Version%', $shortnewversion
    $DownloadURL_x86 = "https://www.rarlab.com/rar/wrar$($shortnewversion)ru.exe"
    $DownloadURL_x64 = "https://www.rarlab.com/rar/winrar-x64-$($shortnewversion)ru.exe"
    
    Write-Host "-===========-" -ForegroundColor Green
    Write-Host "Product:  $global:Application"
    Write-Host "Search link: $URLPage"
    Write-Host "Version: "$version
    Write-host "Download Link: $DownLoadURL_x86"
    Write-Host "Download path: $DistribPath\$version\$FileName_x86"
    Write-host "Download Link: $DownLoadURL_x64"
    Write-Host "Download path: $DistribPath\$version\$FileName_x64"
    $global:body  = "Product:  $global:Application `rSearch link: $URLPage `rVersion: $version`rLink: $DownloadURL_x86 `rDownload path: $DistribPath\$version\$FileName_x86 `rLink: $DownloadURL_x64 `rDownload path: $DistribPath\$version\$FileName_x64 `r"
    if (Test-Path "filesystem::$DistribPath\$version\")
    {
        write-host "Данная версия уже есть "
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
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName_x86%', "$FileName_x86") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName_x64%', "$FileName_x64") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%Publisher%', "$global:Publisher") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appName%', "$global:Application") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionVersion%', "$global:Version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionName%', "$global:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appVersion%', "$global:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionVersion%', "$global:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appName%', "$global:Application") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionName%', "$global:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        
        $destination_x86 = "$DistribPath\$version\Files\$FileName_x86"
        $destination_x64 = "$DistribPath\$version\Files\$FileName_x64"
        Invoke-WebRequest -Uri $DownloadURL_x86 -OutFile $destination_x86 -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
        Invoke-WebRequest -Uri $DownloadURL_x64 -OutFile $destination_x64 -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
        # copy winrar license
        Copy-Item -Path "\\SCCMServer\Sources\Applications\WinRAR\License\rarreg_AK.key" -Destination "$DistribPath\$version\Files"
        Copy-Item -Path "\\SCCMServer\Sources\Applications\WinRAR\License\rarreg_TNE.key" -Destination "$DistribPath\$version\Files"
        Copy-Item -Path "\\SCCMServer\Sources\Applications\WinRAR\License\rarreg_TNF.key" -Destination "$DistribPath\$version\Files"

        # Create install.cmd
        #Add-Content -Path "$DistribPath\$version\Files\install.cmd" -Value '@ECHO OFF'
        #Add-Content -Path "$DistribPath\$version\Files\install.cmd" -Value "$FileName /s"
        #Add-Content -Path "$DistribPath\$version\Files\install.cmd" -Value "xcopy `"rarreg.key`" `"C:\Program Files\WinRAR`" /q /y"
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
    New-CMApplication -Name $ApplicationName -LocalizedApplicationName $global:Application -Description $Description -SoftwareVersion $Version -Publisher $Publisher -LocalizedDescription $LocalizedDescription -IconLocationFile $IconLocationFile
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
    RebootBehavior = 'NoAction'
    RequireUserInteraction = $true
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

#endregion Function

#region Variables
$Config = Get-Content "$PSScriptRoot\config.json" | ConvertFrom-Json 
$global:Application = "WinRAR"
$global:Application_detection = 'WinRAR'
$global:DirAppinConsole = "WinRAR"
$global:DistribPath = "$($Config.DistribPath)\WinRAR"
$global:FileName_x86 = 'winrar-x86-%Version%-ru.exe'
$global:FileName_x64 = 'winrar-x64-%Version%-ru.exe'
$URLPage = "https://www.rarlab.com"
$global:Version = '1.1'
$ProxyURL = $Config.ProxyURL
$global:PSADTTemplatePath = $Config.PSADTTemplatePath
$global:body = ''
$global:NewVersion = $null
$global:templatename = 'Config_WinRAR_template.ps1'
$To= $Config.To
#endregion Variables

Try{
    Get-WinRAR -URLPage $URLPage
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
            Publisher = 'WinRAR'
            InstallCommand = "Deploy-Application.exe"
            DPGroup = 'Distribution Point Group'
            TestCollection = "DA | $Application | Pilot | Required"
            ProdCollection = "DA | $Application | Prod | Required"
            TestUserCollection = "ALL | TEST | Application Catalog | Standard user"
            MSIFileName = '$global:FileName'
            UninstallCommand = """Deploy-Application.exe"" -DeploymentType Uninstall"
            LocalizedDescription = @"
            WinRAR — архиватор файлов для 32- и 64-разрядных операционных систем Windows, позволяющий создавать/изменять/распаковывать архивы RAR и ZIP и распаковывать архивы множества других форматов
"@
            IconLocationFile = "$DistribPath\icon.png"
            Scriptpath = "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        }
        New-Application @NewApplication_Properties
        Send-EmailAnonymously -Body $global:Body -To $To
    }
}
catch{}