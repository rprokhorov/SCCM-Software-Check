# Получает с сайта последнюю версию VMWare и если у нас нет такой версии, то сначала копирует шаблон установки PSADT, заменяет в нём значения. После этого создаёт приложение в SCCM с заполнением всех нужых атрибутов.

#region Function
function Get-VMwareTools ($URLPage){
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $HTML = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $Content = $HTML.RawContent
    # Create HTML file Object
    $HTMLObject = New-Object -Com "HTMLFile"
    # Write HTML content according to DOM Level2 
    $HTMLObject.IHTMLDocument2_write($Content)
    
    $LastDir = ($HTMLObject.getElementsByTagName('A') | Where-Object { $_.pathname -match "\d.\d.\d/" } | Sort-Object -Property 'pathname' -Descending | Select-Object -First 1).pathname

    #parse web-page with last version VMWare
    $FileURL = "https://packages.vmware.com/tools/releases/$($LastDir)windows/x64/index.html"
    $HTML = Invoke-WebRequest $FileURL -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $Content = $HTML.RawContent
    # Create HTML file Object
    $HTMLObject = New-Object -Com "HTMLFile"
    # Write HTML content according to DOM Level2 
    $HTMLObject.IHTMLDocument2_write($Content)

    $FileName = ($HTMLObject.getElementsByTagName('A') | Where-Object { $_.pathname -like 'VMware-tools-*' } ).pathname
  
    $script:Version = $FileName.TrimStart('VMware-tools-').TrimEnd('-x86_64.exe').Replace('-','.')
  
    $DownloadURL = "https://packages.vmware.com/tools/releases/$($LastDir)windows/x64/$FileName"
    

    Write-Host "-===========-" -ForegroundColor Green
    Write-Host "Product:  $script:Application"
    Write-Host "Search link: $URLPage"
    Write-Host "Version: "$version
    Write-host "Download Link:    "$DownLoadURL
    Write-Host "Download path: $DistribPath\$version\$FileName"
    $script:ApplicationName = "$script:Application $script:version"
    $script:body  = "Product:  $script:Application `rSearch link: $URLPage `rVersion: $version`rLink: $DownLoadURL `rDownload path: $DistribPath\$version\ `rCreated application: $ApplicationName `r"
    
    # Создаём папку куда будем скачивать дистибутив
    if (Test-Path "filesystem::$DistribPath\$version")
    {
        write-host "Такой файл у нас уже есть"
        $script:NewVersion = $false
    }
    Else
    {
        $script:NewVersion = $true
        Write-Host "Начинаю закачку файла"
        cd C:
        New-Item -ItemType Directory -Path "$DistribPath\$version"  -Force
        # Копирую шаблон для PSADT
        Copy-Item -Path "$script:DistribPath\PSADT template\*" -Destination "$DistribPath\$version" -Recurse
        # Заменяю переменные в файле шаблона на переменные из скрипта.
        (Get-Content "$DistribPath\$version\Deploy-Application.ps1").replace('%version%', "$version") | Set-Content "$DistribPath\$version\Deploy-Application.ps1"
        (Get-Content "$DistribPath\$version\Deploy-Application.ps1").replace('%FileName%', "$FileName") | Set-Content "$DistribPath\$version\Deploy-Application.ps1"
        (Get-Content "$DistribPath\$version\Deploy-Application.ps1").replace('%Publisher%', "$script:Publisher") | Set-Content "$DistribPath\$version\Deploy-Application.ps1"
        (Get-Content "$DistribPath\$version\Deploy-Application.ps1").replace('%ApplicationName%', "$script:Application") | Set-Content "$DistribPath\$version\Deploy-Application.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%version%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%version_detection%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%ApplicationName%', "$script:Application") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%ApplicationName_Detection%', "$script:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        # Указываем куда будем сохранять скачиваемый файл
        $destination = "$DistribPath\$version\Files\$FileName"
        # Скачивание файла
        Invoke-WebRequest -Uri $DownLoadURL -OutFile $destination -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials
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
        #[PARAMETER(Mandatory=$True)]$TestCollection,
        #[PARAMETER(Mandatory=$True)]$ProdCollection,
        #[PARAMETER(Mandatory=$True)]$TestUserCollection,
        [PARAMETER(Mandatory=$True)]$DeviceAvailableCollection,
        [PARAMETER(Mandatory=$True)]$MSIFileName,
        [PARAMETER(Mandatory=$True)]$UninstallCommand,
        [PARAMETER(Mandatory=$False)]$LocalizedDescription,
        [PARAMETER(Mandatory=$False)]$IconLocationFile,
        [PARAMETER(Mandatory=$True)]$Scriptpath,
        [PARAMETER(Mandatory=$True)]$LocalScriptpath,
        [PARAMETER(Mandatory=$False)]$UserCategory
    )
    
    # $Version = $newversion
    # $SourcesPath = $targetDirectory
    # $DetectScript = "Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object {`$_.DisplayName -like `"WinRAR*`" -and `$_.Displayversion -like `"${Version}*`"}"

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

    #$DetectionFileProperties = @{
    #    FileName = 'AcroRd32.exe';
    #    Path = '%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader';
    #    Is64Bit = $True;
    #    PropertyType = 'Version';
    #    ExpectedValue = $Version;
    #    ExpressionOperator = 'IsEquals'
    #    Value = $True
    #}
    #$DetectionFileProperties
    #$DetectionFile = New-CMDetectionClauseFile @DetectionFileProperties

    # Example. for search 
    #Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object {$_.DisplayName -like "WinRAR*" -and $_.Displayversion -like "5.61*"}

    $DeploymentTypeProperties = @{
    InstallCommand = $InstallCommand
    DeploymentTypeName = "[DT] $ApplicationName"
    ApplicationName = $ApplicationName
    ContentLocation = $SourcesPath
    #AddDetectionClause = $DetectionFile
    InstallationBehaviorType = 'InstallForSystem'
    InstallationProgramVisibility = 'Normal'
    UninstallCommand = $UninstallCommand
    ScriptLanguage = 'PowerShell' 
    #ScriptFile = $scriptPath}
    ScriptText = (Get-Content -Path $LocalScriptpath) -join "`n"}
    #$DeploymentTypeProperties
    Add-CMScriptDeploymentType @DeploymentTypeProperties -RequireUserInteraction

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
    $DateTest = (Get-Date).AddHours(3)
    #$DateProd = (Get-Date).AddDays(14)
    #New-CMApplicationDeployment -Name $ApplicationName -CollectionName $TestCollection -DeployPurpose Required -UserNotification HideAll -AvailableDateTime $DateTest
    #New-CMApplicationDeployment -Name $ApplicationName -CollectionName $ProdCollection -DeployPurpose Required -UserNotification HideAll -AvailableDateTime $DateProd
    #New-CMApplicationDeployment -Name $ApplicationName -CollectionName $TestUserCollection -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly -AvailableDateTime $DateTest
    New-CMApplicationDeployment -Name $ApplicationName -CollectionName $DeviceAvailableCollection -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly -AvailableDateTime $DateTest
    
    # Return Location
    Set-Location $SaveLocation


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

#endregion Function

#region Variables
$Config = Get-Content "$PSScriptRoot\config.json" | ConvertFrom-Json 
$script:Application = "VMware Tools"
$script:Application_detection = 'VMware Tools'
$script:DirAppinConsole = "VMware Tools"
$script:DistribPath = "$($Config.DistribPath)\VMware\VMware Tools"
#$script:FileName = 'VMware-tools-%version%-x86_64.exe'
$URLPage = "https://packages.vmware.com/tools/releases/index.html"
$script:version = '1.0'
$ProxyURL = $Config.ProxyURL
$script:body = ''
$script:NewVersion = $null
$script:Publisher = 'VMware, Inc.'
$To= $Config.To
$From = $config.From
$MailServer = $Config.MailServer
$LocalDistribPath = $Config.LocalDistribPath
#endregion Variables

try{
    Get-VMwareTools -URLPage $URLPage
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
            # TestCollection = "DA | Adobe Acrobat Reader DC - Russian | Pilot | Required"
            # ProdCollection = "DA | Adobe Acrobat Reader DC - Russian | Prod | Required"
            # TestUserCollection = "ALL | TEST | Application Catalog | Standard user"
            DeviceAvailableCollection = "DA | All Servers | VMware Tools | Prod | Available"
            MSIFileName = '$script:FileName'
            UninstallCommand = """Deploy-Application.exe"" -DeploymentType Uninstall"
            LocalizedDescription = 'VMware Tools improves the performance and management of the virtual machine.'
            IconLocationFile = "$script:DistribPath\icon.png"
            Scriptpath = "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
            LocalScriptpath = "$LocalDistribPath\$script:Application\$version\SupportFiles\DetectionMethod.ps1"
        }
    
        New-Application @NewApplication_Properties
        Send-EmailAnonymously -Body $script:Body -To $To -SMTPServer $MailServer -From $From
    }
}
catch{}