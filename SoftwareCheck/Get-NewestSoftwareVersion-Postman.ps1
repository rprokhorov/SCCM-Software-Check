# Получает с сайта последнюю версию Postman и если у нас нет такой версии, то сначала копирует шаблон устанвоки PSADT, заменяет в неём значения. После этого создаёт приложение в SCCM с заполнением всех нужых атрибутов.

#region Function
function Invoke-UnzipFile
	{
		Param (
			[Parameter(Mandatory = $true)]
			[AllowEmptyCollection()]
			[string]$FilePath,
			[Parameter(Mandatory = $true)]
			[AllowEmptyCollection()]
			[string]$Destination
		)
		$shell = New-Object -ComObject shell.application
		$zip = $shell.NameSpace($FilePath)
		$result = @()
		New-Item -Path $Destination -ErrorAction SilentlyContinue -ItemType Directory
		foreach ($item in $zip.items())
		{
			$shell.Namespace($Destination).CopyHere($item)
			$result += , $item.Path
		}
		return $result
		#[System.IO.Compression.ZipFile]::ExtractToDirectory($FilePath, $Destination)
    }

    function Invoke-7zipUnzipFile
	{
		Param (
			[Parameter(Mandatory = $true)]
			[AllowEmptyCollection()]
			[string]$FilePath,
			[Parameter(Mandatory = $true)]
			[AllowEmptyCollection()]
			[string]$Destination
		)
        New-Item -Path $Destination -ErrorAction SilentlyContinue -ItemType Directory
		&"C:\Program Files\7-Zip\7z.exe" x $FilePath -o"$($Destination)"
    }

# Получение последней версии Postman
function Get-Postman ($URLPage){
    # Присваивание переменных
    #[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    #$res = Invoke-WebRequest -Uri $URLPage -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials
    # We can find a lot of URLs. They will have alfabit order (Linux, Ma)
    # Element ID to check for in DOM
    $elementID = "latest-release__version"
    # Text to match in elemend
    $elementMatchText = "Version [0-9\.]+"
    # Timeout
    $timeoutMilliseconds = 5000
    $ie = New-Object -ComObject "InternetExplorer.Application"
    # optional
    $ie.Visible = $false
    $ie.Navigate2("https://www.postman.com/downloads/")
    $timeStart = Get-Date
    $exitFlag = $false
    do {
        sleep -milliseconds 100
        if ( $ie.ReadyState -eq 4 ) {
            $elementText = (($ie.Document).getElementByID($elementID )).innerText
            $elementMatch = $elementText -match $elementMatchText
            if ( $elementMatch ) { $loadTime = (Get-Date).subtract($timeStart) }
        }
        $timeout = ((Get-Date).subtract($timeStart)).TotalMilliseconds -gt $timeoutMilliseconds
        $exitFlag = $elementMatch -or $timeout
    } until ( $exitFlag )
    if ($elementMatch)
    {
        Write-Host "Match element found: $($Matches[0])"
    }
    else {
        break
    }
    $DownloadURL_x64 = 'https://dl.pstmn.io/download/latest/win64'
    $DownloadURL_x86 = 'https://dl.pstmn.io/download/latest/win32'
    #(($res.Links | Where-Object {$_.href -like '*putty/latest/w64*64*.msi'}).href -split '/')[-1] -match '[0-9]+.[0-9]+' | Out-Null
    $script:Version = $Matches[0] -replace '[a-z\ ]+'
    $script:FileName_x64 = "Postman-x64-$version.exe"
    $script:FileName_x86 = "Postman-x86-$version.exe"
    Write-Host "-===========-" -ForegroundColor Green
    Write-Host "Product:  $script:Application"
    Write-Host "Search link: $URLPage"
    Write-Host "Version: "$version
    Write-host "Download Link x86:    "$DownloadURL_x86
    Write-Host "Download path: $DistribPath\$version\$script:FileName_x86"
    Write-host "Download Link x64:    "$DownloadURL_x64
    Write-Host "Download path: $DistribPath\$version\$script:FileName_x64"
    $script:body  = "Product:  $script:Application `rSearch link: $URLPage `rVersion: $version`rLink: $DownloadURL_x86 `rDownload path: $DistribPath\$version\$script:FileName_x86 `rLink: $DownloadURL_x64 `rDownload path: $DistribPath\$version\$script:FileName_x64 `r"
    $script:ApplicationName = "$script:Application $script:version"
    # Создаём папку куда будем скачивать дистибутив
    if (Test-Path "filesystem::$DistribPath\$version")
    {
        write-host "Такой файл у нас уже есть"
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
        Copy-Item -Path "$DistribPath\Detection\DetectionMethod.ps1" -Destination "$DistribPath\$version\SupportFiles\DetectionMethod.ps1" -Force
        Copy-Item -Path "$DistribPath\$version\SupportFiles\Config files\$script:templatename" -Destination "$DistribPath\$version\SupportFiles\Config.ps1" -Force
        

        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appVersion%', "$version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName_x86%', "x86\$script:FileName_x86") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%FileName_x64%', "x64\$script:FileName_x64") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%Publisher%', "$script:Publisher") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appName%', "$script:Application") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\Config.ps1").replace('%appDetectionName%', "$script:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\Config.ps1"
        
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionVersion%', "$script:Version") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appName%', "$script:Application") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        (Get-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1").replace('%appDetectionName%', "$script:Application_detection") | Set-Content "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
        
        $destination_x86 = "$DistribPath\$version\Files\$script:FileName_x86"
        $destination_x64 = "$DistribPath\$version\Files\$script:FileName_x64"
        Invoke-WebRequest -Uri $DownloadURL_x86 -OutFile $destination_x86 -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
        Invoke-WebRequest -Uri $DownloadURL_x64 -OutFile $destination_x64 -UseBasicParsing -Proxy $ProxyURL -ProxyUseDefaultCredentials -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
        
        Invoke-7zipUnzipFile -FilePath $destination_x86 -Destination "$DistribPath\$version\Files\x86\"
        Invoke-7zipUnzipFile -FilePath $destination_x64 -Destination "$DistribPath\$version\Files\x64\"
        
        Remove-Item -Path $destination_x86 -Force
        Remove-Item -Path $destination_x64 -Force
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
#endregion Function

#region Variables
$Config = Get-Content "$PSScriptRoot\config.json" | ConvertFrom-Json
$script:Application = "Postman"
$script:Application_detection = 'Postman'
$script:DirAppinConsole = "Postman"
$script:DistribPath = "$($Config.DistribPath)Postman"
$script:FileName_x64 = "Postman-x64-$version.exe"
$script:FileName_x86 = "Postman-x86-$version.exe"
$URLPage = 'https://www.postman.com/downloads/' # For Windows only
$script:Version = '1.1'
$ProxyURL = $Config.ProxyURL
$script:PSADTTemplatePath = "$((get-item $psscriptroot).parent.FullName)\Template\*" #"$($Config.PSADTTemplatePath)\*"
$script:body = ''
$script:NewVersion = $null
$script:Publisher = 'Simon Tatharm'
$script:templatename = 'Config_Postman_template.ps1'
$To= $Config.To
$From = $config.From
$MailServer = $Config.MailServer
$LocalDistribPath = $Config.LocalDistribPath
#endregion Variables

try{
    Get-Postman -URLPage $URLPage
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
            InstallCommand = "Deploy-Application.exe" #"install.cmd"
            DPGroup = 'Distribution Point Group'
            TestCollection = "DA | Adobe Acrobat Reader DC - Russian | Pilot | Required"
            ProdCollection = "DA | Adobe Acrobat Reader DC - Russian | Prod | Required"
            TestUserCollection = "ALL | TEST | Application Catalog | Standard user"
            MSIFileName = "$script:FileName"
            UninstallCommand = """Deploy-Application.exe"" -DeploymentType Uninstall"  #"msiexec /x {AC76BA86-7AD7-1049-7B44-AC0F074E4100} /q"
            LocalizedDescription = 'Postman — удобный HTTP-клиент для тестирования веб-сайтов. С помощью расширения можно составлять и редактировать простые или сложные HTTP-запросы.'
            IconLocationFile = "$((get-item $psscriptroot).parent.FullName)\Applications\$Application\icon.png"
            Scriptpath = "$DistribPath\$version\SupportFiles\DetectionMethod.ps1"
            LocalScriptpath = "$LocalDistribPath\$version\SupportFiles\DetectionMethod.ps1"
        }
    
        New-Application @NewApplication_Properties
        Send-EmailAnonymously -Body $global:Body -To $To -SMTPServer $MailServer -From $From
    }
}
catch{}