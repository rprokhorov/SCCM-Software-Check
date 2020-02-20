function write-log{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowEmptyCollection()]
        [Alias('Text')]
        [string]$Message,
        [Parameter(Mandatory=$false,Position=1)]
        [ValidateNotNullorEmpty()]
        [string]$Component = "Main",
        [Parameter(Mandatory=$false,Position=2)]
        [ValidateSet('Info','Warning','Error')]
        [string]$MessageType = 'Info',
        [Parameter(Mandatory=$false,Position=3)]
        [ValidateNotNullorEmpty()]
        [string]$LogFileName=(Get-Date -Format 'yyyy-MM-dd').ToString()+".log",
        [Parameter(Mandatory=$false,Position=4)]
        [ValidateNotNullorEmpty()]
        [string]$LogFileDirectory = "$env:SystemDrive\Temp\Logs\Software\",
        [Parameter(Mandatory=$false,Position=5)]
        [ValidateNotNullorEmpty()]
        [string]$Source = "SCCM Application Detection Method"
    )
    $MessageType_to_int = @{
        'Info' = '1'
        'Warning' = '2'
        'Error' = '3'
    }
    $MessageType_to_Event = @{
        'Info' = 'Information'
        'Warning' = 'Warning'
        'Error' = 'Error'
    }
    [string]$LogTime = (Get-Date -Format 'HH:mm:ss.fff').ToString()
    [string]$LogDate = (Get-Date -Format 'MM-dd-yyyy').ToString()
    if (!(Test-Path -Path $LogFileDirectory))
    {
        New-Item -ItemType Directory -Path $LogFileDirectory | Out-Null
    }
    Try{
		$params = @{
            LogName = 'Application'
            Source = 'Configuration Manager Agent'
            EntryType = $MessageType_to_Event[$MessageType]
            EventId = 1000
            Message = $Message
        }
		Write-EventLog @params
		
		"<![LOG[$Message]LOG]!><time=`"$LogTime"+"180`" date=`"$LogDate`" component=`"$Component`" context="""" type=""$($MessageType_to_int[$MessageType])"" thread=""0"" file=""$Source"">" | out-file $LogFileDirectory\$LogFileName -Append -Encoding utf8 -ErrorAction SilentlyContinue        
    }
    catch{
		Write-Host "Error write-log $($_.Exception.Message)"
	}
}

Function Get-InstalledApplication {
<#
.SYNOPSIS
	Retrieves information about installed applications.
.DESCRIPTION
	Retrieves information about installed applications by querying the registry. You can specify an application name, a product code, or both.
	Returns information about application publisher, name & version, product code, uninstall string, install source, location, date, and application architecture.
.PARAMETER Name
	The name of the application to retrieve information for. Performs a contains match on the application display name by default.
.PARAMETER Exact
	Specifies that the named application must be matched using the exact name.
.PARAMETER WildCard
	Specifies that the named application must be matched using a wildcard search.
.PARAMETER RegEx
	Specifies that the named application must be matched using a regular expression search.
.PARAMETER ProductCode
	The product code of the application to retrieve information for.
.PARAMETER IncludeUpdatesAndHotfixes
	Include matches against updates and hotfixes in results.
.EXAMPLE
	Get-InstalledApplication -Name 'Adobe Flash'
.EXAMPLE
	Get-InstalledApplication -ProductCode '{1AD147D0-BE0E-3D6C-AC11-64F6DC4163F1}'
.NOTES
.LINK
	http://psappdeploytoolkit.com
#>
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory=$false)]
		[ValidateNotNullorEmpty()]
		[string[]]$Name,
		[Parameter(Mandatory=$false)]
		[switch]$Exact = $false,
		[Parameter(Mandatory=$false)]
		[switch]$WildCard = $false,
		[Parameter(Mandatory=$false)]
		[switch]$RegEx = $false,
		[Parameter(Mandatory=$false)]
		[ValidateNotNullorEmpty()]
		[string]$ProductCode,
		[Parameter(Mandatory=$false)]
		[switch]$IncludeUpdatesAndHotfixes,
		[Parameter(Mandatory=$false)]
		[string]$LogName
	)
	
	Begin {
		## Get the name of this function and write header
		[string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-Log -Message "Start detection method" -MessageType Info -Component $CmdletName -LogFileName $LogName
	}
	Process {
		If ($name) {
			Write-Log -Message "Get information for installed Application Name(s) [$($name -join ', ')]..." -MessageType Info -Component $CmdletName -LogFileName $LogName
		}
		If ($productCode) {
			Write-Log -Message "Get information for installed Product Code [$ProductCode]..." -MessageType Info -Component $CmdletName -LogFileName $LogName
		}
		[string[]]$regKeyApplications = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall','HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
		## Enumerate the installed applications from the registry for applications that have the "DisplayName" property
		[psobject[]]$regKeyApplication = @()
		ForEach ($regKey in $regKeyApplications) {
			If (Test-Path -LiteralPath $regKey -ErrorAction 'SilentlyContinue' -ErrorVariable '+ErrorUninstallKeyPath') {
				[psobject[]]$UninstallKeyApps = Get-ChildItem -LiteralPath $regKey -ErrorAction 'SilentlyContinue' -ErrorVariable '+ErrorUninstallKeyPath'
				ForEach ($UninstallKeyApp in $UninstallKeyApps) {
					Try {
						[psobject]$regKeyApplicationProps = Get-ItemProperty -LiteralPath $UninstallKeyApp.PSPath -ErrorAction 'Stop'
						If ($regKeyApplicationProps.DisplayName) { [psobject[]]$regKeyApplication += $regKeyApplicationProps }
					}
					Catch{
						Write-Log -Message "Unable to enumerate properties from registry key path [$($UninstallKeyApp.PSPath)]. `n$(Resolve-Error)" -MessageType Info -Component $CmdletName -LogFileName $LogName
						Continue
					}
				}
			}
		}
		If ($ErrorUninstallKeyPath) {
			Write-Log -Message "The following error(s) took place while enumerating installed applications from the registry. `n$(Resolve-Error -ErrorRecord $ErrorUninstallKeyPath)" -MessageType Info -Component $CmdletName -LogFileName $LogName
		}
		
		## Create a custom object with the desired properties for the installed applications and sanitize property details
		[psobject[]]$installedApplication = @()
		ForEach ($regKeyApp in $regKeyApplication) {
			Try {
				[string]$appDisplayName = ''
				[string]$appDisplayVersion = ''
				[string]$appPublisher = ''
				
				## Bypass any updates or hotfixes
				If (-not $IncludeUpdatesAndHotfixes) {
					If ($regKeyApp.DisplayName -match '(?i)kb\d+') { Continue }
					If ($regKeyApp.DisplayName -match 'Cumulative Update') { Continue }
					If ($regKeyApp.DisplayName -match 'Security Update') { Continue }
					If ($regKeyApp.DisplayName -match 'Hotfix') { Continue }
				}
				
				## Remove any control characters which may interfere with logging and creating file path names from these variables
				$appDisplayName = $regKeyApp.DisplayName -replace '[^\u001F-\u007F]',''
				$appDisplayVersion = $regKeyApp.DisplayVersion -replace '[^\u001F-\u007F]',''
				$appPublisher = $regKeyApp.Publisher -replace '[^\u001F-\u007F]',''
				
				## Determine if application is a 64-bit application
				[boolean]$Is64BitApp = If (($is64Bit) -and ($regKeyApp.PSPath -notmatch '^Microsoft\.PowerShell\.Core\\Registry::HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node')) { $true } Else { $false }
				
				If ($ProductCode) {
					## Verify if there is a match with the product code passed to the script
					If ($regKeyApp.PSChildName -match [regex]::Escape($productCode)) {
						Write-Log -Message "Found installed application [$appDisplayName] version [$appDisplayVersion] matching product code [$productCode]."  -MessageType Info -Component 'Registry'
						$installedApplication += New-Object -TypeName 'PSObject' -Property @{
							UninstallSubkey = $regKeyApp.PSChildName
							ProductCode = If ($regKeyApp.PSChildName -match $MSIProductCodeRegExPattern) { $regKeyApp.PSChildName } Else { [string]::Empty }
							DisplayName = $appDisplayName
							DisplayVersion = $appDisplayVersion
							UninstallString = $regKeyApp.UninstallString
							InstallSource = $regKeyApp.InstallSource
							InstallLocation = $regKeyApp.InstallLocation
							InstallDate = $regKeyApp.InstallDate
							Publisher = $appPublisher
							Is64BitApplication = $Is64BitApp
						}
					}
				}
				
				If ($name) {
					## Verify if there is a match with the application name(s) passed to the script
					ForEach ($application in $Name) {
						$applicationMatched = $false
						If ($exact) {
							#  Check for an exact application name match
							If ($regKeyApp.DisplayName -eq $application) {
								$applicationMatched = $true
								Write-Log -Message "Found installed application [$appDisplayName] version [$appDisplayVersion] using exact name matching for search term [$application]." -MessageType Info -Component $CmdletName -LogFileName $LogName
							}
						}
						ElseIf ($WildCard) {
							#  Check for wildcard application name match
							If ($regKeyApp.DisplayName -like $application) {
								$applicationMatched = $true
								Write-Log -Message "Found installed application [$appDisplayName] version [$appDisplayVersion] using wildcard matching for search term [$application]." -MessageType Info -Component $CmdletName -LogFileName $LogName
							}
						}
						ElseIf ($RegEx) {
							#  Check for a regex application name match
							If ($regKeyApp.DisplayName -match $application) {
								$applicationMatched = $true
								Write-Log -Message "Found installed application [$appDisplayName] version [$appDisplayVersion] using regex matching for search term [$application]." -MessageType Info -Component $CmdletName -LogFileName $LogName
							}
						}
						#  Check for a contains application name match
						ElseIf ($regKeyApp.DisplayName -match [regex]::Escape($application)) {
							$applicationMatched = $true
							Write-Log -Message "Found installed application [$appDisplayName] version [$appDisplayVersion] using contains matching for search term [$application]." -MessageType Info -Component $CmdletName -LogFileName $LogName
						}
						
						If ($applicationMatched) {
							[array]$installedApplication += New-Object -TypeName 'PSObject' -Property @{
								UninstallSubkey = $regKeyApp.PSChildName
								ProductCode = If ($regKeyApp.PSChildName -match $MSIProductCodeRegExPattern) { $regKeyApp.PSChildName } Else { [string]::Empty }
								DisplayName = $appDisplayName
								DisplayVersion = $appDisplayVersion
								UninstallString = $regKeyApp.UninstallString
								InstallSource = $regKeyApp.InstallSource
								InstallLocation = $regKeyApp.InstallLocation
								InstallDate = $regKeyApp.InstallDate
								Publisher = $appPublisher
								Is64BitApplication = $Is64BitApp
							}
						}
					}
				}
			}
			Catch {
				Write-Log -Message "Failed to resolve application details from registry for [$appDisplayName]. `n$(Resolve-Error)"  -MessageType Error -Component $CmdletName -LogFileName $LogName
				Continue
			}
		}
		if (!$installedApplication)
		{
			If ($name) {
				Write-Log -Message "Failed to get information for installed Application Name(s) [$($name -join ', ')]..." -MessageType Error -Component $CmdletName -LogFileName $LogName
			}
			If ($productCode) {
				Write-Log -Message "Failed to get information for installed Product Code [$ProductCode]..." -MessageType Error -Component $CmdletName -LogFileName $LogName
			}
			Write-Log -Message "Finish detection method" -MessageType Info -LogFileName $LogName
		}
		Write-Output -InputObject $installedApplication	
	}	
}

## Load config file
#. "$(Split-Path $script:MyInvocation.MyCommand.Path)\SupportFiles\Config.ps1"
##*===============================================
$appName = "%appName%"
$appVersion = "%appVersion%"
$appDetectionVersion = "%appDetectionVersion%"
$appDetectionName = "%appDetectionName%"

$LogName = "Detection Method $appName - $appVersion.log" -replace '\*', ' '
$Version = "$appDetectionVersion"
[array]$Products = Get-InstalledApplication -Name "*$appDetectionName*" -WildCard -LogName $LogName

$counter=0
foreach ($product in $Products)
{ 
	if ((Get-ItemProperty "$($product.InstallLocation)CarambaSwitcher.exe").VersionInfo.ProductVersion -ge $Version)
	{
		Write-Log -Message "Application $((Get-ItemProperty "$($product.InstallLocation)CarambaSwitcher.exe").VersionInfo.ProductVersion) [$($product.DisplayVersion)] has version greater or equal $Version" -MessageType Info -Component Main -LogFileName $LogName
		$counter++
	}
	else 
	{
		Write-Log -Message "Application $($product.DisplayName) [$($product.DisplayVersion)] has not version greater or equal $Version" -MessageType Error -Component Main -LogFileName $LogName
	}
}
if ($counter -eq $products.Count -and $counter -ne 0)
{
	Write-Host "Software was found"
}
else {
}
Write-Log -Message "Detection method was finished" -MessageType Info -Component Main -LogFileName $LogName