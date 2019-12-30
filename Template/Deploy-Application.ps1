<#
.SYNOPSIS
	This script performs the installation or uninstallation of an application(s).
	# LICENSE #
	PowerShell App Deployment Toolkit - Provides a set of functions to perform common application deployment tasks on Windows. 
	Copyright (C) 2017 - Sean Lillis, Dan Cunningham, Muhammad Mashwani, Aman Motazedian.
	This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. 
	You should have received a copy of the GNU Lesser General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
.DESCRIPTION
	The script is provided as a template to perform an install or uninstall of an application(s).
	The script either performs an "Install" deployment type or an "Uninstall" deployment type.
	The install deployment type is broken down into 3 main sections/phases: Pre-Install, Install, and Post-Install.
	The script dot-sources the AppDeployToolkitMain.ps1 script which contains the logic and functions required to install or uninstall an application.
.PARAMETER DeploymentType
	The type of deployment to perform. Default is: Install.
.PARAMETER DeployMode
	Specifies whether the installation should be run in Interactive, Silent, or NonInteractive mode. Default is: Interactive. Options: Interactive = Shows dialogs, Silent = No dialogs, NonInteractive = Very silent, i.e. no blocking apps. NonInteractive mode is automatically set if it is detected that the process is not user interactive.
.PARAMETER AllowRebootPassThru
	Allows the 3010 return code (requires restart) to be passed back to the parent process (e.g. SCCM) if detected from an installation. If 3010 is passed back to SCCM, a reboot prompt will be triggered.
.PARAMETER TerminalServerMode
	Changes to "user install mode" and back to "user execute mode" for installing/uninstalling applications for Remote Destkop Session Hosts/Citrix servers.
.PARAMETER DisableLogging
	Disables logging to file for the script. Default is: $false.
.EXAMPLE
    powershell.exe -Command "& { & '.\Deploy-Application.ps1' -DeployMode 'Silent'; Exit $LastExitCode }"
.EXAMPLE
    powershell.exe -Command "& { & '.\Deploy-Application.ps1' -AllowRebootPassThru; Exit $LastExitCode }"
.EXAMPLE
    powershell.exe -Command "& { & '.\Deploy-Application.ps1' -DeploymentType 'Uninstall'; Exit $LastExitCode }"
.EXAMPLE
    Deploy-Application.exe -DeploymentType "Install" -DeployMode "Silent"
.NOTES
	Toolkit Exit Code Ranges:
	60000 - 68999: Reserved for built-in exit codes in Deploy-Application.ps1, Deploy-Application.exe, and AppDeployToolkitMain.ps1
	69000 - 69999: Recommended for user customized exit codes in Deploy-Application.ps1
	70000 - 79999: Recommended for user customized exit codes in AppDeployToolkitExtensions.ps1
.LINK 
	http://psappdeploytoolkit.com
#>
[CmdletBinding()]
Param (
	[Parameter(Mandatory=$false)]
	[ValidateSet('Install','Uninstall')]
	[string]$DeploymentType = 'Install',
	[Parameter(Mandatory=$false)]
	[ValidateSet('Interactive','Silent','NonInteractive')]
	[string]$DeployMode = 'Interactive',
	[Parameter(Mandatory=$false)]
	[switch]$AllowRebootPassThru = $false,
	[Parameter(Mandatory=$false)]
	[switch]$TerminalServerMode = $false,
	[Parameter(Mandatory=$false)]
	[switch]$DisableLogging = $false
)

Try {
	## Set the script execution policy for this process
	Try { Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force -ErrorAction 'Stop' } Catch {}
	
	##*===============================================
	##* VARIABLE DECLARATION
	##*===============================================
	## Load config file
	. "$(Split-Path $script:MyInvocation.MyCommand.Path)\SupportFiles\Config.ps1"
	##*===============================================
	## Variables: Application
	[string]$appVendor = $config.appVendor
	[string]$appName = $config.appName
	[string]$appVersion = $config.appVersion
	[string]$appArch = ''
	[string]$appLang = 'RU'
	[string]$appRevision = '01'
	[string]$appScriptVersion = '2.1.0'
	[string]$appScriptDate = $config.appScriptDate
	[string]$appScriptAuthor = $config.appScriptAuthor
	##*===============================================
	## Variables: Install Titles (Only set here to override defaults set by the toolkit)
	[string]$installName = "$appName-$appVersion"
	[string]$installTitle = "Установка ПО $appName версии $appVersion"
	
	##* Do not modify section below
	#region DoNotModify
	
	## Variables: Exit Code
	[int32]$mainExitCode = 0
	
	## Variables: Script
	[string]$deployAppScriptFriendlyName = 'Deploy Application'
	[version]$deployAppScriptVersion = [version]'3.7.0'
	[string]$deployAppScriptDate = '02/13/2018'
	[hashtable]$deployAppScriptParameters = $psBoundParameters
	
	## Variables: Environment
	If (Test-Path -LiteralPath 'variable:HostInvocation') { $InvocationInfo = $HostInvocation } Else { $InvocationInfo = $MyInvocation }
	[string]$scriptDirectory = Split-Path -Path $InvocationInfo.MyCommand.Definition -Parent
	
	## Dot source the required App Deploy Toolkit Functions
	Try {
		[string]$moduleAppDeployToolkitMain = "$scriptDirectory\AppDeployToolkit\AppDeployToolkitMain.ps1"
		If (-not (Test-Path -LiteralPath $moduleAppDeployToolkitMain -PathType 'Leaf')) { Throw "Module does not exist at the specified location [$moduleAppDeployToolkitMain]." }
		If ($DisableLogging) { . $moduleAppDeployToolkitMain -DisableLogging } Else { . $moduleAppDeployToolkitMain }
	}
	Catch {
		If ($mainExitCode -eq 0){ [int32]$mainExitCode = 60008 }
		Write-Error -Message "Module [$moduleAppDeployToolkitMain] failed to load: `n$($_.Exception.Message)`n `n$($_.InvocationInfo.PositionMessage)" -ErrorAction 'Continue'
		## Exit the script, returning the exit code to SCCM
		If (Test-Path -LiteralPath 'variable:HostInvocation') { $script:ExitCode = $mainExitCode; Exit } Else { Exit $mainExitCode }
	}
	
	#endregion
	##* Do not modify section above
	##*===============================================
	##* END VARIABLE DECLARATION
	##*===============================================
		
	If ($deploymentType -ine 'Uninstall') {
		##*===============================================
		##* PRE-INSTALLATION
		##*===============================================
		[string]$installPhase = 'Pre-Installation'
		# Данная конструкция позволяет показывать окна только в том случае, если не было запущено приложение из списка
        $close_app = $Config.close_app
		if ($close_app)
		{
			if(!(Get-Process | Where-Object {$_.Name -in $close_app}) -or ($close_app -eq '') -or ($IsServerOS -eq $true))
			{
				Write-Log -Message "Proceses $($close_app -join ', ') not running. Set SILIENT deployModeSilent" -Source "Main"
				$deployModeSilent = $true
				$deployModeNonInteractive = $true
			}
			else
			{
				Show-InstallationWelcome  -AllowDefer -DeferTimes 3 -CloseApps ($close_app -join ',') -PersistPrompt -DeferDays 1 -AllowDeferCloseApps -MinimizeWindows $false
			}
		}
		
		##*===============================================
		##* INSTALLATION 
		##*===============================================
		
		Invoke-Command -ScriptBlock $Config.InstallScriptBlock
		
		#[string]$installPhase = 'Installation'
		#Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/1] установка приложения..." #-WindowLocation 'BottomRight'
		# # Установка MSI файла с параметрами
		# $mainExitCode = Execute-MSI -Action 'Install' -Path "$dirFiles\AcroRead.msi" -Parameters '/qn'
		# # Установка MSI файла с трансформацией и с параметрами
		# $mainExitCode = Execute-MSI -Action 'Install' -Path '%FileName%' -Parameters '/QN /norestart'
		
		# Установка MSP файла с параметрами (Patch)
		#Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] установка последней версии программы..." #-WindowLocation 'BottomRight'
		#$mainExitCode = Execute-MSI -Action 'Patch' -Path '%DownloadFile%' -Parameters '/QN /norestart'
		# Установка любого приложения с параметрами
		#$mainExitCode = Execute-Process -Path "$dirFiles\%FileName%"  -Parameters "/verysilent"
		
		##*===============================================
		##* POST-INSTALLATION
		##*===============================================
		#[string]$installPhase = 'Post-Installation'
		# # Запись значения в реестр
		# Set-RegistryKey -Key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' -Name 'Debugger' -Value 'cmd.exe' -Type String
		# # Удаление значения из реестра
		# Remove-RegistryKey -Key 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'RunAppInstall'
		# # Создание папки
		# New-Folder -Path "$envWinDir\System32"
		# # Удаление папки
		# Remove-Folder -Path "$envWinDir\Downloaded Program Files"
		# # Копирование файла
		# Copy-File -Path "$dirSupportFiles\policies.json" -Destination "$PuTTY_Folder\distribution\policies.json" -ContinueOnError $false 
		# # Удаление файла
		# Remove-File -Path 'C:\Windows\Downloaded Program Files\Temp.inf' 
		# # Удаление папки и всего содержимого в ней
		# Remove-File -LiteralPath 'C:\Windows\Downloaded Program Files' -Recurse
		# Запуск Hardware Inventory на клиенте, но не в TS.
		if ($runningTaskSequence -eq $false)
		{
			Invoke-SCCMTask -ScheduleID HardwareInventory
		}
		## Display a message at the end of the install
		# If (-not $useDefaultMsi) { Show-InstallationPrompt -Message 'You can customize text to appear at the end of an install or remove it completely for unattended installations.' -ButtonRightText 'OK' -Icon Information -NoWait }
	}
	ElseIf ($deploymentType -ieq 'Uninstall')
	{
		Invoke-Command -ScriptBlock $Config.UninstallScriptBlock
		#[string]$installPhase = 'Uninstall'
		#$mainExitCode = Execute-Process -Path "C:\Program Files (x86)\K-Lite Codec Pack\unins000.exe"  -Parameters "/verysilent" 
		# # Удаление приложения по MSI коду
		# Execute-MSI -Action 'Uninstall' -Path '{B27534DB-4F72-4F49-A3AD-5EC1B6901E5E}'
		# # Удаление приложения по маске
		# Remove-MSIApplications -Name 'PuTTY'
		# Remove-MSIApplications -Name 'Java 8 Update' -FilterApplication ('Is64BitApplication', $false, 'Exact'),('Publisher', 'Oracle Corporation', 'Exact')
		# ##*===============================================
		##* PRE-UNINSTALLATION
		##*===============================================
		
		## <Perform Pre-Uninstallation tasks here>
		
		##*===============================================
		##* UNINSTALLATION
		##*===============================================
		
		# <Perform Uninstallation tasks here>
		
		##*===============================================
		##* POST-UNINSTALLATION
		##*===============================================
		
		## <Perform Post-Uninstallation tasks here>
	}
	
	##*===============================================
	##* END SCRIPT BODY
	##*===============================================
	
	## Call the Exit-Script function to perform final cleanup operations
	Exit-Script -ExitCode $mainExitCode
}
Catch {
	[int32]$mainExitCode = 60001
	[string]$mainErrorMessage = "$(Resolve-Error)"
	Write-Log -Message $mainErrorMessage -Severity 3 -Source $deployAppScriptFriendlyName
	Show-DialogBox -Text $mainErrorMessage -Icon 'Stop'
	Exit-Script -ExitCode $mainExitCode
}