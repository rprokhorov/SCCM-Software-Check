Этот проект создан для упрощения работы с приложениями в SCCM. Главная цель, которую я хочу решить - это возможность гибко настраивать установку прилжений, так как в жизни часто встречаются случаи, когда установка бывает немного сложнее чем установка /qn или /s флагов.

Содержание папок:

- __Applications__ - В папке сожержатся иконки приложений и какие-то кастомные файлы настроек или трансформаций для приложений. Например, для VLC нужно применять файл транформации для "тихого первого запуска приложения".
- __Software Check__ - в папке находятся скрипты, которые получают последнюю версию приложения с сайта, и если на вашей файловой шаре нет этой версии, то она его скачивает. После чего запускает создание приложения в SCCM.
- __Template__ - в папке находится fork PSADT, который был переработан для работы с файлами конфигураций + небольшие косметические улучшения.

Что я получил используюя такой подход у себя в работе (по понятным причинам скриншоты я могу делать только с тестовой среды, но это ничего не меняет):

_________________
__Структура хранения дистрибутивов__

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/FileshareStructure.png?raw=true "File share structure")

- _Красный_ - сетевая папка, где будут храниться все наши дистрибутивы
- _Зелёный_ - Папка с названием продукта
- _Синий_ - версия продукта, которая будет понятна человеку. Например, прилжение "SQL Server Management Studio" при запуске и скачивании пишет, что она имеет версию "18.4", но при установке в системе она будет иметь версию "15.0.18206.0". В этом случае, для простоты использования папка создаётся с версией 18.4, а уже в самом файле DetectionMethod будет использоваться версия "15.0.18206.0".
- _Фиолетовый_ - папка, где по умолчанию будут храниться сами файлы дистрибутивов
- _Жёлтый_ - пример скаченных файлов.

____________
__Структура приложений в SCCM__

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/SCCMApplicationsStructure.png?raw=true "SCCM Application structure")

- _Красный_ - название приложения. Я предпочитаю делать максимально плоский список, так как в этом случае любой новый сотрудник не должен обладать какими-то тайными знаниями, а просто должен просмотреть список и найти нужное.
- _Синий_ - папка с архивными версиями приложений. Я предпочитаю не удалять старые приложения, а просто перемещать их в отдельную папку. Там же могут храниться приложения которые относятся к этому продукту и достались  по наследству и по какой-то причне уже не используются. В этом случае, я тоже лучше сохраню приложение.
- _Зелёный_ - приложения, которые используются в данный момент в продакшене. В определённый момент, тут будут находиться 2 версии приложений v1 и v2, пока не произошёл переход с одной версии на другую.

________

__Описание шаблона__

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/TemplateStructure.png?raw=true "Template structure")

Общую информацию о работе с PSADT лучше всего почтать у автора.
Я вносил следующие изсенения:

- _Красный_ - папка в которой содержатся все примеры Config файлов.
- _Синий_ - файл Config.ps1, который будет исполняться для установки и удаления приложений.
- _Зеленый_ - файл DetectionMethod.ps1, который будет исполняться в как Detection Method в приложении SCCM.
- _Белый_ -  оригинальные файлы из PSADT
- _Жёлтый_ - части шаблона, которые я изменял. Более подобно опишу позже.

_______
__Описание файла Config.ps1__
Данный файл используется для описания шагов установки/постустановки и удаления приложения. Файл имеет формат хеш-таблицы в PowerShell (Другого нормально варианта хранить отдельно ScriptBlock я не нашёл).
Пример файла Config.ps1:

```Powershell
$Config = @{
    appVendor = "Mozilla"
    appName = "Mozilla Firefox ESR"
    appVersion = "68.3.0"
    appDetectionVersion = "68.3.0"
    appDetectionName = "Mozilla Firefox*ESR"
    appScriptDate = get-date -Format "yyyy/MM/dd"
    appScriptAuthor = "RProhkorov"
    close_app = "firefox"
    InstallScriptBlock = {
        [string]$installPhase = 'Installation'
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [1/2] установка новой версии ПО..."
        # Установка любого приложения с параметрами
        if ($Is64Bit)
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\FirefoxESR_x64.exe" -Parameters "/s /INI=$dirFiles\Firefox.ini"
        }
        else
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\FirefoxESR_x86.exe" -Parameters "/s /INI=$dirFiles\Firefox.ini"
        }
        Show-InstallationProgress -StatusMessage "Установка приложения $appName `nШаг [2/2] копирование файла политик..."
		[string]$installPhase = 'Post-Installation'
        $FireFox_Folder = 'C:\Program Files\Mozilla Firefox'
        if(!(Test-Path -Path "$FireFox_Folder\distribution"))
        {
            New-Folder -Path "$FireFox_Folder\distribution"
        }
        Copy-File -Path "$dirSupportFiles\policies.json" -Destination "$FireFox_Folder\distribution\policies.json" -ContinueOnError $false 
    }
    UninstallScriptBlock = {
        [string]$installPhase = 'Uninstall'
        Stop-Process -Name 'Firefox' -Force
		$mainExitCode = Execute-Process -Path "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -Parameters "/s"
    }
}

```

- _appVendor_ - автор приложения (Mozilla)
- _appName_ - название приложения в SCCM, и в окне установки, если будет показываться процесс установки.
- _appVersion_ - версия приложения, которая "читаема" для человека. Смотрите пример выше с SQL Management Studio.
- _appDetectionVersion_ - версия приложения, которая которая будет использоваться при поиске в DetectionMethod.ps1
- _appDetectionName_ - имя прилжения, которое будет использваться для поиска его на компьютере. Например, appName = "Adobe Flash Player ActiveX", при этом на компьютере приложение будет искаться по маске appDetectionName = "Adobe Flash Player*ActiveX"
- _appScriptDate_ - переменная для понимания когда был создан этот конфиг файл. Нигде не используется.
- _appScriptAuthor_ - автор конфига.
- _close_app_ - приложения, которые должны быть закрыты до начала установки приложения. Если приложение будет запущёно на компьютере и будет мешать запуску установки, то пользователю будет показано окно с просьбой закрыть прилжение или отложить установку.
- _InstallScriptBlock_ - блок, в котором описывается как будет проходить установка приложения. В блоке можно и нужно использовать функции PSADT.
- _UninstallScriptBlock_ - блок, который будет выполняться при запуске удаления приложения

_______
__Описание файла DetectionMethod.ps1__
Файл используется для как Detection method при создании Application в SCCM.
Описание файла:
```Powershell
function write-log{
    ...
}

Function Get-InstalledApplication {
...
}

## Load config file
#. "$(Split-Path $script:MyInvocation.MyCommand.Path)\SupportFiles\Config.ps1"
##*===============================================
$appName = "Mozilla Firefox ESR"
$appVersion = "68.4.1"
$appDetectionVersion = "68.4.1"
$appDetectionName = "Mozilla Firefox*ESR"
$LogName = "Detection Method $appName - $appVersion.log" -replace '\*', ' '
$Version = "$appDetectionVersion"
#Detection block
[array]$Products = Get-InstalledApplication -Name "*$appDetectionName*" -WildCard -LogName $LogName

$counter=0
foreach ($product in $Products)
{ 
	if ($product.DisplayVersion -ge $Version)
	{
		Write-Log -Message "Application $($product.DisplayName) [$($product.DisplayVersion)] has version greater or equal $Version" -MessageType Info -Component Main -LogFileName $LogName
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

```
- _function write-log_ - функция для записи логов в формате cmtrace.
- _function Get-InstalledApplication_ - функция из PSADT, которая вовращает массив приложений, так как может быть найдено несколько приложений на компьютере.
- _appName_ - название приложения в SCCM, и в окне установки, если будет показываться процесс установки.
- _appVersion_ - версия приложения, которая "читаема" для человека. Смотрите пример выше с SQL Management Studio.
- _appDetectionVersion_ - версия приложения, которая которая будет использоваться при поиске в DetectionMethod.ps1
- _appDetectionName_ - имя прилжения, которое будет использваться для поиска его на компьютере. Например, appName = "Adobe Flash Player ActiveX", при этом на компьютере приложение будет искаться по маске appDetectionName = "Adobe Flash Player*ActiveX"
- _$LogName_ - путь где будет храниться лог
- _#Detection block_ - описание того, как будет происходить поиск вашего приложений. В конкретном случае делается поиск всех приложений по маске и если хотя бы одно ниже той версии, которую мы ищем, то будет считаться, что приложение не найдено. В будущем это будет помогать вычищать инфраструктуру от старых артифактов.