#region Function
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

function Get-MSIPropertySet {
    param (
        [parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [ValidateScript({Test-Path $_})]
        [string]$MSIFilePath
    )
    try {
        [IO.FileInfo]$Path = Get-Item $MSIFilePath
        $WindowsInstaller = New-Object -com WindowsInstaller.Installer
        $MSIDatabase = $WindowsInstaller.GetType().InvokeMember("OpenDatabase","InvokeMethod",$Null,$WindowsInstaller,@($Path.FullName,0))
        $View = $MSIDatabase.GetType().InvokeMember("OpenView","InvokeMethod",$null,$MSIDatabase,"SELECT * FROM Property")
        $View.GetType().InvokeMember("Execute", "InvokeMethod", $null, $View, $null)
        $hash = @{}
        while($Record = $View.GetType().InvokeMember("Fetch","InvokeMethod",$null,$View,$null))
        {
            $hash += (@{ $Record.GetType().InvokeMember("StringData","GetProperty",$null,$Record,1) = $Record.GetType().InvokeMember("StringData","GetProperty",$null,$Record,2)})
        }
        $result = [PSCustomObject]$hash
        $View.GetType().InvokeMember("Close","InvokeMethod",$null,$View,$null)
        return $result
    }
    catch {
        Write-Output $_.Exception.Message
        return $NULL
    }
}

function Get-CiscoWebex  ($URLPage){
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    # We can fing version on site, so we need to download file, and after that take version from file
    $DownloadURL = $URLPage
    Remove-Item -Path "$DistribPath\CiscoWebexMeetings-temp.msi" -Force -ErrorAction SilentlyContinue
    Invoke-WebRequest -Uri $DownLoadURL -OutFile "$DistribPath\CiscoWebexMeetings-temp.msi" -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
    
    $script:Version = (Get-MSIPropertySet -MsiFile "$DistribPath\CiscoWebexMeetings-temp.msi").ProductVersion
    $script:FileName = $script:FileName -replace '%version%', $script:version
    
    Write-Host "-===========-" -ForegroundColor Green
    Write-Host "Product:  $script:Application"
    Write-Host "Search link: $URLPage"
    Write-Host "Version: "$version
    Write-host "Download Link:    "$DownLoadURL
    Write-Host "Download path: $DistribPath\$version\$FileName"
    $script:body  = "Product:  $script:Application `rSearch link: $URLPage `rVersion: $version`rLink: $DownLoadURL `rDownload path: $DistribPath\$version\$FileName `r"
    if (Test-Path "filesystem::$DistribPath\$version\")
    {
        write-host "Версия уже есть"
        $script:NewVersion = $false
        Remove-Item -Path "$DistribPath\CiscoWebexMeetings-temp.msi" -Force
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
        Copy-Item -Path "$DistribPath\CiscoWebexMeetings-temp.msi" -Destination $destination -Force
        #Invoke-WebRequest -Uri $DownLoadURL -OutFile $destination -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
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
        #ScriptFile = $scriptPath}
        ScriptText = (Get-Content -Path $LocalScriptpath) -join "`n"}
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
$script:Application = "Cisco Webex Meetings"
$script:Application_detection = 'Webex'
$script:DirAppinConsole = "Cisco Webex Meetings"
$script:DistribPath = "$($Config.DistribPath)Cisco Webex Meetings"
$script:FileName = 'CiscoWebexMeetings-%Version%.msi'
$URLPage = 'https://akamaicdn.webex.com/client/webexapp.msi'
$script:Version = '1.1'
$ProxyURL = $Config.ProxyURL
$script:PSADTTemplatePath = "$((get-item $psscriptroot).parent.FullName)\Template\*" #"$($Config.PSADTTemplatePath)\*"
$script:body = ''
$script:NewVersion = $null
$script:Publisher = 'Cisco Webex LLC'
$script:templatename = 'Config_CiscoWebexMeetings_template.ps1'
$To= $Config.To
$From = $config.From
$MailServer = $Config.MailServer
$LocalDistribPath = $Config.LocalDistribPath

#endregion Variables

Try{
    Get-CiscoWebex -URLPage $URLPage
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
            MSIFileName = '$script:FileName'
            UninstallCommand = """Deploy-Application.exe"" -DeploymentType Uninstall"
            LocalizedDescription = "Cisco Webex Meeting — кроссплатформенная программа для проведения встреч."
            IconLocationFile = "$DistribPath\icon.png"
            Scriptpath = "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
            LocalScriptpath = "$LocalDistribPath\$version\SupportFiles\DetectionMethod.ps1"
        }
        New-Application @NewApplication_Properties
        Send-EmailAnonymously -Body $global:Body -To $To -SMTPServer $MailServer -From $From
    }
}
catch{}