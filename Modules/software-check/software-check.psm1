function Get-7zip {
    $URLPage = 'https://www.7-zip.org/'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.outerHTML -match '7-zip [0-9\.]+' -and $_.outerHTML -notlike '*Alpha*' -and $_.outerHTML -notlike '*Beta*'}).outerHTML[0] -match '7-zip [0-9\.]+' | Out-Null
    $script:Version = $Matches[0] -replace '7-zip '
    $script:FileName_x64 = $script:FileName_x64 -replace '%version%', $script:version
    $script:FileName_x86 = $script:FileName_x86 -replace '%version%', $script:version
    $URLPage = 'https://www.7-zip.org/download.html'
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $DownloadURL_x64 = "https://www.7-zip.org/$(($result.Links | Where-Object {$_.href -like '*x64.msi'})[0].href)"
    $DownloadURL_x86 = "https://www.7-zip.org/$(($result.Links | Where-Object {$_.href -like '*.msi'})[0].href)"
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = '7-zip'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/7-zip/icon.png"
        LocalizedDescription = @{
            ru = "7-Zip — свободный файловый архиватор с высокой степенью сжатия данных. Поддерживает несколько алгоритмов сжатия и множество форматов данных, включая собственный формат 7z c высокоэффективным алгоритмом сжатия LZMA."
            en = "7-zip - free file archiver with a high degree of data compression. Supports multiple compression algorithms and multiple data formats, including native 7z format with highly efficient LZMA compression algorithm"
        }
        Publisher = 'Igor Pavlov'
    }
    return $result
}

function Get-AxurePR {
    $URLPage = 'https://www.axure.com/release-history/rp8'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.Content -match 'Version [0-9\.]+ \(PC' | Out-Null
    $script:Version = $Matches[0] -replace 'Version ' -replace ' \(PC'
    $script:Build = $Matches[0] -replace 'Version ' -replace ' \(PC' -replace '8\.1', '8.0'
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL = ($result.Links | Where-Object {$_.href -like '*exe'}).href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'AxurePR'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Axure%20RP/icon.png"
        LocalizedDescription = @{
            ru = "Axure RP — программное обеспечение для создания прототипов и спецификаций веб-сайтов и приложений"
            en = "Axure RP — "
        }
        Publisher = 'Axure Software Solutions, Inc.'
    }
    return $result
}

function Get-CarambaSwitcherCorporate {
    $URLPage = 'https://caramba-switcher.com/update'
    $URLPage = 'https://caramba-switcher.com/'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result =  Invoke-WebRequest -Uri $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $DownloadURL = $result.Links | Where-Object {$_.href -like '*update'} | Select-Object -First 1 -ExpandProperty href
    ($result.Links | Where-Object {$_.href -like '*update'} | Select-Object -First 1 -ExpandProperty href) -match "[0-9][0-9\.]+[0-9]" | Out-Null
    $script:Version = $Matches[0] -replace '.exe'
    #$script:FileName = $script:FileName -replace '%version%', $script:version
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Caramba Switcher Corporate'
        Version = $script:Version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Caramba%20Switcher%20Corporate/icon.png"
        LocalizedDescription = @{
            ru = "Caramba Switcher Corporate — это версия не соединяется с интернетом – из нее полностью убран функциональный блок осуществляющий работу с сетью"
            en = "Caramba Switcher Corporate — ."
        }
        Publisher = 'Caramba Tech'
    }
    return $result
}

function Get-FarManager {
    $URLPage = 'https://www.farmanager.com/download.php?l=ru' 
    # Присваивание переменных
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $res = Invoke-WebRequest -Uri $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    # We can find a lot of URLs. They will have alfabit order (Linux, Ma)
    $DownloadURL_x64 = "https://www.farmanager.com/$(($res.Links | Where-Object {$_.href -like 'files/Far*.x64*.msi'}).href)"
    $DownloadURL_x86 = "https://www.farmanager.com/$(($res.Links | Where-Object {$_.href -like 'files/Far*.x86*.msi'}).href)"
    ($res.Links | Where-Object {$_.href -like 'files/Far*.x64*.msi'}).href -match '[0-9]+b[0-9]+' | Out-Null
    $script:Version = ($Matches[0]) -replace 'b', '.'
    $script:Version = "$($Version[0]).$($version[1..$version.Length])" -replace ' '
    $script:FileName_x64 = $script:FileName_x64 -replace '%version%', $script:Version
    $script:FileName_x86 = $script:FileName_x86 -replace '%version%', $script:Version
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Far Manager'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Far%20Manager/icon.png"
        LocalizedDescription = @{
            ru = "FAR Manager — консольный файловый менеджер для операционных систем семейства Microsoft Windows."
            en = "FAR Manager — program for managing files and archives in Windows operating systems"
        }
        Publisher = 'Eugene Roshal & Far Group'
    }
    return $result
}

function Get-Fiddler {
    $URLPage = 'https://www.telerik.com/support/whats-new/fiddler/release-history'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.outerHTML -match 'FIddler v[0-9]'})[0].outerHTML -match "v[0-9\.]+" | Out-Null
    $script:Version = $Matches[0] -replace 'v'
    
    $DownLoadURL = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Fiddler'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownLoadURL
        Download_link_x64 = $DownLoadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Fiddler/icon.png"
        LocalizedDescription = @{
            ru = "Fiddler – прокси, который работает с трафиком между Вашим компьютером и удалённым сервером, и позволяет инспектировать и менять его."
            en = "Fiddler - proxy debug tool used to log, inspect, and modify HTTP and HTTPS traffic between a computer and a web server."
        }
        Publisher = 'Fiddler'
    }
    return $result
}

function Get-FileZilla {
    $URLPage = 'https://filezilla.ru/get/'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.href -like '*win64*' -and $_.href -notlike '*server*'} | Select-Object -ExpandProperty title ) -match "[0-9\.]+"| Out-Null
    $script:Version = $Matches[0]
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL_x64 = "https://filezilla.ru$(($result.Links | Where-Object {$_.href -like '*win64*' -and $_.href -notlike '*server*'}).href)"
    $DownloadURL_x86 = "https://filezilla.ru$(($result.Links | Where-Object {$_.href -like '*win32*' -and $_.href -notlike '*server*'}).href)"
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'FileZilla'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/FileZilla/icon.png"
        LocalizedDescription = @{
            ru = "FileZilla — свободный многоязычный FTP-клиент с открытым исходным кодом для Microsoft Windows, Mac OS X и Linux. Он поддерживает FTP, SFTP, и FTPS (FTP через SSL/TLS) и имеет настраиваемый интерфейс с поддержкой смены тем оформления. Оснащён возможностью перетаскивания объектов, синхронизацией каталогов и поиском на удалённом сервере. Поддерживает многопоточную загрузку файлов, а также докачку при обрыве (если поддерживается сервером) интернет-соединения"
            en = "FileZilla - free and open source multilingual FTP client for Windows, macOS and Linux. It supports FTP, SFTP, and FTPS and has a highly customizable interface with theme changer support. Equipped with the ability to drag and drop objects, directory synchronization and search on a remote server."
        }
        Publisher = 'Tim Kosse'
    }
    return $result
}

function Get-GitExtensions {
    $URLPage = 'https://github.com/gitextensions/gitextensions/releases/latest'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    (($result.Links | Where-Object {$_.href -like '*.msi'}).href -split '/')[-1] -match "[0-9][0-9\.]+[0-9]" | Out-Null
    $script:Version = $Matches[0] -replace '.msi'
    $DownLoadURL = 'https://github.com'+($result.Links | ? {$_.href -like '*.msi'}).href
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Git Extensions'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Git%20Extensions/icon.png"
        LocalizedDescription = @{
            ru = "Git Extensions - визуальный клиент системы управления версиями Git, позволяющий использовать Git без использования консольного интерфейса."
            en = "Git Extensions - standalone UI tool for managing Git repositories"
        }
        Publisher = 'Git Extensions Team'
    }
    return $result
}

function Get-KLiteStandard {
    $URLPage = "http://www.codecguide.com/download_k-lite_codec_pack_standard.htm"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage #-Proxy $ProxyURL -ProxyUseDefaultCredentials -UseBasicParsing
    ($result.RawContent -match 'Version [0-9\.]+ Standard') | Out-Null
    $script:Version = $Matches[0] -replace 'Version ', '' -replace ' Standard', ''
    $DownloadURL = ($result.Links | Where-Object {$_.href -like '*exe*'})[0].href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'K-Lite Codec Pack Standard'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/K-Lite%20Codec%20Pack%20Standard/icon.png"
        LocalizedDescription = @{
            ru = "K-Lite Codec Pack Standard — универсальный набор кодеков и утилит для просмотра и обработки аудио- и видеофайлов. В пакет входит большое число свободных, либо бесплатных кодеков и утилит."
            en = "K-Lite Codec Pack Standard - free software bundle for playing all your audio and video files. It supports all common file formats, such as AVI, MP4, MKV, and FLV"
        }
        Publisher = 'KLCP'
    }
    return $result
}

function Get-KeePass
{
    $URLPage = 'https://keepass.info/download.html'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.outerHTML -like '*keepass 2*MSI*'}).outerHTML -match 'keepass 2[0-9\.]+ MSI' | Out-Null
    $script:Version = $Matches[0] -replace '[a-z -]'
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL = ($result.Links | Where-Object {$_.outerHTML -like '*keepass 2*MSI*'}).href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'KeePass'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownLoadURL
        Download_link_x64 = $DownLoadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/KeePass/icon.png"
        LocalizedDescription = @{
            ru = "KeePass Password Safe — кроссплатформенная свободная программа для хранения паролей, распространяемая по лицензии GPL. Программа разработана Домиником Райхлом, изначально только для операционной системы Windows."
            en = "KeePass - free, open source, light-weight and easy-to-use password manager."
        }
        Publisher = 'Dominik Reichl'
    }
    return $result
}

function Get-MozillaFirefoxESR {
    $URLPage = "https://www.mozilla.org/en-US/firefox/organizations/notes/"
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.RawContent -match 'Version [0-9\.]+' | Out-Null
    $script:Version = $Matches[0] -replace 'Version ', ''
    $DownloadURL_x86 = $result.Links | Where-Object {$_.outerHTML -like '*Download Firefox ESR*' -and $_.outerHTML -like '*Windows 32-bit*' -and $_.href -notlike '*msi*'} | Select-Object -ExpandProperty href -First 1
    $DownloadURL_x64 = $result.Links | Where-Object {$_.outerHTML -like '*Download Firefox ESR*' -and $_.outerHTML -like '*Windows 64-bit*' -and $_.href -notlike '*msi*'} | Select-Object -ExpandProperty href -First 1
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Mozilla Firefox ESR'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Mozilla%20Firefox%20ESR/icon.png"
        LocalizedDescription = @{
            ru = "Mozilla Firefox ESR - альтернативный браузер для использования в корпоративной среде."
            en = "Mozilla Firefox ESR - official version of Firefox developed for large organizations like universities and businesses that need to set up and maintain Firefox on a large scale. Firefox ESR does not come with the latest features but it has the latest security and stability fixes."
        }
        Publisher = 'Mozilla'
    }
    return $result
}

function Get-Nmap {
    $URLPage = 'https://nmap.org/download.html#windows'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.href -like 'https://nmap.org/dist*.exe' -and $_.href -notlike '*beta*'}).href -match '[0-9][0-9\.]+' | Out-Null
    $script:Version = $Matches[0]
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL = ($result.Links | Where-Object {$_.href -like 'https://nmap.org/dist*.exe' -and $_.href -notlike '*beta*'}).href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Nmap'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Nmap/icon.png"
        LocalizedDescription = @{
            en = "Nmap - free and open source utility for network discovery and security auditing. Many systems and network administrators also find it useful for tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime."
            ru = "Nmap - свободная утилита, предназначенная для разнообразного настраиваемого сканирования IP-сетей с любым количеством объектов, определения состояния объектов сканируемой сети (портов и соответствующих им служб)."            
        }
        Publisher = 'Nmap Project'
    }
    return $result
}

function Get-Notepadplusplus {
    $URLPage = "https://notepad-plus-plus.org/"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.outerHTML -like '*current version*'})[0].outerHTML -match '[0-9\.]+' | Out-Null
    $script:Version = $Matches[0]
    $script:FileName_x64 = $script:FileName_x64 -replace '%version%', $script:version
    $script:FileName_x86 = $script:FileName_x86 -replace '%version%', $script:version
    $URL_temp = "https://notepad-plus-plus.org/downloads/v$script:Version/"
    $result = Invoke-WebRequest $URL_temp -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $DownloadURL_x64 =  ($result.Links | Where-Object {$_.href -like '*Installer*x64.exe'})[0].href
    $DownloadURL_x86 =  ($result.Links | Where-Object {$_.href -like '*Installer.exe'})[0].href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Notepad++'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Notepad%2B%2B/icon.png"
        LocalizedDescription = @{
            ru = "Notepad++ — свободный текстовый редактор с открытым исходным кодом для Windows с подсветкой синтаксиса большого количества языков программирования и разметки, а также языков описания аппаратуры VHDL и Verilog. Поддерживает открытие более 100 форматов."
            en = "Notepad++ - free source code editor and Notepad replacement that supports several languages."
        }
        Publisher = 'Notepad++ Team'
    }
    return $result
}

function Get-PuTTY {
    $URLPage = 'https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html' # For Windows only
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $res = Invoke-WebRequest -Uri $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    # We can find a lot of URLs. They will have alfabit order (Linux, Ma)
    $DownloadURL_x64 = ($res.Links | Where-Object {$_.href -like '*putty/latest/w64*64*.msi'}).href
    $DownloadURL_x86 = ($res.Links | Where-Object {$_.href -like '*putty/latest/w32/*.msi'}).href
    (($res.Links | Where-Object {$_.href -like '*putty/latest/w64*64*.msi'}).href -split '/')[-1] -match '[0-9]+.[0-9]+' | Out-Null
    $script:Version = $Matches[0]
    $script:FileName_x64 = "PuTTY-x64-$version.msi"
    $script:FileName_x86 = "PuTTY-x86-$version.msi"
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'PuTTY'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Putty/icon.png"
        LocalizedDescription = @{
            ru = "PuTTY — свободно распространяемый клиент для различных протоколов удалённого доступа, включая SSH, Telnet, rlogin"
            en = "PuTTY - open source SSH and telnet client, developed originally by Simon Tatham for the Windows platform."
        }
        Publisher = 'Simon Tatharm'
    }
    return $result
}

function Get-SQLManagementStudio {
    $URLPage = 'https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.outerHTML -like '*Download for SQL Server Management Studio*'} | Select-Object -ExpandProperty outerHTML) -match "[0-9][0-9\.]+" | Out-Null
    $script:Version = $Matches[0]
    $script:DownLoadURL = ($result.Links | Where-Object {$_.outerHTML -like '*Download for SQL Server Management Studio*'} | Select-Object -ExpandProperty href)
    #$DownLoadURL = 'https://aka.ms/ssmsfullsetup'
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'SQL Server Management Studio'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownLoadURL
        Download_link_x64 = $DownLoadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/SQL%20Management%20Studio/icon.png"
        LocalizedDescription = @{
            ru = "SQL Server Management Studio - интегрированная среда для управления SQL. SSMS предоставляет средства для настройки, наблюдения и администрирования экземпляров SQL. С помощью SSMS можно развертывать, отслеживать и обновлять компоненты уровня данных, используемые вашими приложениями, а также создавать запросы и скрипты."
            en = "SQL Server Management Studio - integrated environment for managing any SQL infrastructure, from SQL Server to Azure SQL Database"
        }
        Publisher = 'Microsoft'
    }
    return $result
}

function Get-TotalCommander {
    $URLPage = 'https://www.ghisler.com/download.htm'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.Content -match 'version [0-9\.a-z]+ of Total Commander' | Out-Null
    $script:Version = $Matches[0] -replace 'version ' -replace ' of Total Commander'
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL = ($result.Links | Where-Object {$_.OuterHTML -like '*64-bit+32-bit*' -and $_.href -like 'https:*'}).href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Total Commander'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownLoadURL
        Download_link_x64 = $DownLoadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Total%20Commander/icon.png"
        LocalizedDescription = @{
            ru = "Total Commander — файловый менеджер с закрытым исходным кодом, работающий на платформах Microsoft Windows."
            en = "Total Commander - shareware file manager for Windows"
        }
        Publisher = 'Ghisler Software GmbH'
    }
    return $result
}

function Get-VLC {
    $URLPage = "https://www.videolan.org/vlc/"
    # Присваивание переменных
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest -Uri $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.RawContent -match '"latestVersion":"[0-9\.]+' | Out-Null
    $script:Version = $Matches[0] -replace '"latestVersion":"', ''
    # $DownloadURL_temp = "https:$($result.Links | Where-Object {$_.href -like '*win64.exe'} | Select-Object href -ExpandProperty href)"
    # $result = Invoke-WebRequest -Uri $DownloadURL_temp
    # $DownloadURL =$result.Links | ? {$_.InnerText -eq 'click here'} | Select href -ExpandProperty href
    $DownloadURL_x64 = "https://download.videolan.org/vlc/last/win64/vlc-$script:Version-win64.msi"
    $DownloadURL_x86 = "https://download.videolan.org/vlc/last/win32/vlc-$script:Version-win32.msi"
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'VLC'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/VLC/icon.png"
        LocalizedDescription = @{
            ru = "VLC — бесплатный и свободный кросс-платформенный медиаплеер и медиаплатформа с открытым исходным кодом. VLC воспроизводит множество мультимедийных файлов, а также DVD, Audio CD, VCD и сетевые трансляции."
            en = "VLC - free and open source cross-platform multimedia player and framework that plays most multimedia files, and various streaming protocols"
        }
        Publisher = 'Simon Tatharm'
    }
    return $result
}

function Get-VisualStudioCode {
    $URLPage = 'https://code.visualstudio.com/updates'
    # Присваивание переменных
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $res = Invoke-WebRequest -Uri $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    # We can find a lot of URLs. They will have alfabit order (Linux, Ma)
    ($res.Links | Where-Object {$_.OuterHTML -like '*Version*' -and $_.href -eq '/updates'}).outerHTML -match '[0-9\.]+' | Out-Null
    $script:Version = $Matches[0]
    # try to find update
    $a = $res.Content.IndexOf("Update $script:Version")
    if ($a -ne '-1')
    {
        ($res.Content[$a..($a+13)] -join '') -match '[0-9\.]+' | Out-Null
        $script:Version = $Matches[0]
    }
    $DownLoadURL_x64 = "https://vscode-update.azurewebsites.net/latest/win32-x64/stable"
    $DownLoadURL_x86 = "https://vscode-update.azurewebsites.net/latest/win32/stable"
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Visual Studio Code'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Visual%20Studio%20Code/icon.png"
        LocalizedDescription = @{
            ru = "Visual Studio Code - Редактор кода. Включает в себя отладчик, инструменты для работы с Git, подсветку синтаксиса, IntelliSense и средства для рефакторинга. Имеет широкие возможности для кастомизации: пользовательские темы, сочетания клавиш и файлы конфигурации."
            en = "Visual Studio Code - lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS and Linux. It comes with built-in support for JavaScript, TypeScript and Node.js and has a rich ecosystem of extensions for other languages and runtimes (such as C++, C#, Java, Python, PHP, Go, .NET)"
        }
        Publisher = 'Microsoft'
    }
    return $result
}

function Get-WinRAR {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $URLPage = "https://www.rarlab.com"
    $result = Invoke-WebRequest -Uri $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.RawContent -match 'WinRAR and RAR [0-9\.]+ release' | Out-Null
    $script:Version = $Matches[0] -replace '[a-z ]+'
    $shortnewversion = $script:Version -replace "\."
    $DownloadURL_x86 = "https://www.rarlab.com/rar/wrar$($shortnewversion)ru.exe"
    $DownloadURL_x64 = "https://www.rarlab.com/rar/winrar-x64-$($shortnewversion)ru.exe"
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'WinRAR'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/WinRAR/icon.png"
        LocalizedDescription = @{
            ru = "WinRAR — архиватор файлов для 32- и 64-разрядных операционных систем Windows, позволяющий создавать/изменять/распаковывать архивы RAR и ZIP и распаковывать архивы множества других форматов"
            en = "WinRAR - powerful archiver extractor tool, and can open all popular file formats. RAR and WinRAR"
        }
        Publisher = 'win.rar GmbH'
    }
    return $result
}

function Get-WinSCP  {
    $URLPage = 'https://winscp.net/eng/download.php'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.Content -match "Version [0-9\.]+" | Out-Null
    ($result.Links | Where-Object {$_.href -like '*.exe'}).href -match "[0-9\.]+" | Out-Null
    $script:Version = $Matches[0]
    #$script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL_html = Invoke-WebRequest "https://winscp.net$(($result.Links | Where-Object {$_.href -like '*.exe'}).href)" -UseBasicParsing -TimeoutSec 5 #-Proxy $ProxyURL -ProxyUseDefaultCredentials

    $DownloadURL = $DownloadURL_html.Links | Where-Object {$_.OuterHTML -like '*Direct download*'} | Select-Object -First 1 -ExpandProperty href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'WinSCP'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/WinSCp/icon.png"
        LocalizedDescription = @{
            ru = "WinSCP — свободный графический клиент протоколов SFTP и SCP, предназначенный для Windows. Распространяется по лицензии GNU GPL. Обеспечивает защищённое копирование файлов между компьютером и серверами, поддерживающими эти протоколы."
            en = "WinSCP - popular SFTP client and FTP client for Microsoft Windows! Copy file between a local computer and remote servers using FTP, FTPS, SCP, SFTP, WebDAV or S3 file transfer protocols."
        }
        Publisher = 'Martin Prikryl'
    }
    return $result
}

function Get-Wireshark {
    $URLPage = 'https://www.wireshark.org/#download'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.href -like '*64*exe'})[0].href -match '[0-9][0-9\.]+exe' | Out-Null
    $script:Version = $Matches[0] -replace '.exe'
    $DownloadURL_x64 = ($result.Links | Where-Object {$_.href -like '*64*exe'})[0].href
    $DownloadURL_x86 = ($result.Links | Where-Object {$_.href -like '*32*exe'})[0].href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Wireshark'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Wireshark/icon.png"
        LocalizedDescription = @{
            ru = "Wireshark — программа-анализатор трафика для компьютерных сетей Ethernet и некоторых других. Имеет графический пользовательский интерфейс."
            en = "Wireshark - free and open-source packet analyzer. It is used for network troubleshooting, analysis, software and communications protocol development, and education."
        }
        Publisher = 'Wireshark'
    }
    return $result
}

function Get-Git {
    $URLPage = 'https://git-scm.com/download/win'
    $URLPage_version = 'https://git-scm.com/download/'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage_version -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.href -like '*/Documentation/RelNotes*'}).href -match '[0-9\.]+\.txt'  | Out-Null
    $script:Version = $Matches[0] -replace '\.txt'
    $script:FileName_x64 = $script:FileName_x64 -replace '%version%', $script:version
    $script:FileName_x86 = $script:FileName_x86 -replace '%version%', $script:version
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $DownloadURL_x64 = $(($result.Links | Where-Object {$_.href -like '*64-bit.exe'})[0].href)
    $DownloadURL_x86 = $(($result.Links | Where-Object {$_.href -like '*32-bit.exe'})[0].href)
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Git'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/git/icon.png"
        LocalizedDescription = @{
            ru = "Git — система управления версиями."
            en = "Git - free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency."
        }
        Publisher = 'The Git Development Community'
    }
    return $result
}

function Get-mRemoteNG {
    $URLPage = 'https://mremoteng.org/download'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.href -like '*msi*'})[0].href -match '[0-9\.]+msi' | Out-Null
    $script:Version = $Matches[0] -replace '.msi'
    $script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL = ($result.Links | Where-Object {$_.href -like '*msi*'})[0].href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'mRemoteNG'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/mRemoteNG/icon.png"
        LocalizedDescription = @{
            ru = "mRemoteNG - это менеджер удаленных подключений с ""вкладочным"" интерфейсом, который позволяет одновременно работать с несколькими сессиями. Программа поддерживает протоколы VNC, SSH, RDP, ICA, Telnet, HTTP/HTTPS и RLOGIN. В зависимости от используемого протокола, mRemoteNG может работать в разных режимах. Например, SSH используется для передачи данных на удаленный компьютер, а VNC - для трансляции рабочего стола. Некоторые протоколы позволяют осуществлять удаленную проверку портов."
            en = "mRemoteNG - fork of mRemote: an open source, tabbed, multi-protocol, remote connections manager for Windows. mRemoteNG adds bug fixes and new features to mRemote and allows you to view all of your remote connections in a simple yet powerful tabbed interface."
        }
        Publisher = 'Next Generation Software'
    }
    return $result
}

function Get-RDCMan {
    $URLPage = 'https://docs.microsoft.com/en-us/sysinternals/downloads/rdcman'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.Content -match "Remote Desktop Connection Manager v[0-9\.]+" | Out-Null
    $script:Version = $Matches[0] -replace 'Remote Desktop Connection Manager v'
    #$script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL = $result.Links | Where-Object {$_.outerHTML -like '*Download Remote Desktop Connection Manager*'} | Select -First 1 -ExpandProperty href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'RDCMan'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Microsoft/RDCMan/icon.png"
        LocalizedDescription = @{
            ru = "Remote Desktop Connection Manager (RDCMan) - RDCMan управляет несколькими подключениями к удаленному рабочему столу. Это полезно для управления серверными лабораториями, где вам нужен регулярный доступ к каждой машине, такой как автоматизированные системы регистрации и центры обработки данных."
            en = "Remote Desktop Connection Manager (RDCMan) - RDCMan manages multiple remote desktop connections. It is useful for managing server labs where you need regular access to each machine such as automated checkin systems and data centers."
        }
        Publisher = 'Microsoft'
    }
    return $result
}

function Get-Postman {
    $URLPage = 'https://www.postman.com/downloads/'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    $result.Content -match "Remote Desktop Connection Manager v[0-9\.]+" | Out-Null
    # site donwload version from external resource
    $version = (Invoke-WebRequest -UseBasicParsing -Uri "https://bifrost-https-v4.gw.postman.com/ws/proxy" `
        -Method "POST" `
        -WebSession $session `
        -Headers @{
        "method"="POST"
        "authority"="bifrost-https-v4.gw.postman.com"
        "scheme"="https"
        "path"="/ws/proxy"
        "pragma"="no-cache"
        "cache-control"="no-cache"
        "sec-ch-ua"="`" Not A;Brand`";v=`"99`", `"Chromium`";v=`"99`", `"Google Chrome`";v=`"99`""
        "accept"="application/json, text/plain, */*"
        "sec-ch-ua-mobile"="?0"
        "sec-ch-ua-platform"="`"Windows`""
        "origin"="https://www.postman.com"
        "sec-fetch-site"="same-site"
        "sec-fetch-mode"="cors"
        "sec-fetch-dest"="empty"
        "referer"="https://www.postman.com/downloads/"
        "accept-encoding"="gzip, deflate, br"
        "accept-language"="en-US,en;q=0.9,ru;q=0.8,da;q=0.7"
        } `
        -ContentType "application/json;charset=UTF-8" `
        -Body "{`"path`":`"/v1/product-versions/latest`",`"method`":`"get`",`"service`":`"product_version_public`"}" | Select-Object -ExpandProperty Content | ConvertFrom-Json).productVersion

    #$result.Links | Where-Object {$_.OuterHTML -like '*Download Postman App for Windows 64-bit*'}
    # URLs are static
    $DownloadURL_x64 = 'https://dl.pstmn.io/download/latest/win64'
    $DownloadURL_x86 = 'https://dl.pstmn.io/download/latest/win32'
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'Postman'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL_x86
        Download_link_x64 = $DownloadURL_x64
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Postman/icon.png"
        LocalizedDescription = @{
            ru = "Postman — это платформа API для создания и использования API. Postman упрощает каждый этап жизненного цикла API и оптимизирует совместную работу, чтобы вы могли быстрее создавать более качественные API."
            en = "Postman is an API platform for building and using APIs. Postman simplifies each step of the API lifecycle and streamlines collaboration so you can create better APIs—faster."
        }
        Publisher = 'Simon Tatharm'
    }
    return $result
}

function Get-RDTabs {
    $URLPage = 'https://www.avianwaves.com/Software/Tools/RD-Tabs'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $result = Invoke-WebRequest $URLPage -UseBasicParsing #-Proxy $ProxyURL -ProxyUseDefaultCredentials
    ($result.Links | Where-Object {$_.href -like '*setup*.exe'} | Select-Object -First 1 -ExpandProperty outerHTML) -match "RD Tabs [0-9\.]+" | Out-Null
    $script:Version = $Matches[0] -replace 'RD Tabs '
    #$script:FileName = $script:FileName -replace '%version%', $script:version
    $DownloadURL = $result.Links | Where-Object {$_.href -like '*setup*.exe'} | Select-Object -First 1 -ExpandProperty href
    $result = [PSCustomObject]@{
        TimeStamp = Get-Date -Format "yyyy-MM-dd hh:mm:ss"
        Product = 'RD Tabs'
        Version = $version
        Searchlink = $URLPage
        Download_link_x86 = $DownloadURL
        Download_link_x64 = $DownloadURL
        icon = "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/RD%20Tabs/icon.png"
        LocalizedDescription = @{
            ru = "RD Tabs — это оригинальный расширенный клиент удаленного рабочего стола Windows с несколькими вкладками и диспетчер подключений. Это началось еще в 2006 году с простой идеи: перенести новую идею веб-браузеров с вкладками на удаленный рабочий стол. Оттуда был добавлен способ запоминания сохраненных свойств сеанса, который превосходил набор файлов .rdp (избранное), включая возможность пакетного редактирования нескольких избранных одновременно, что упростило управление сохраненными паролями. Но зачем останавливаться на достигнутом? Были добавлены функции, позволяющие разделить экран, несколько окон, масштабировать размеры рабочего стола. Теперь в наши дни более продвинутые функции появляются быстро. От встроенного механизма сценариев PowerShell до цветных вкладок для организации — вкладки RD значительно упрощают жизнь системного администратора."
            en = "RD Tabs is the original advanced multi-tabbed Windows Remote Desktop client and connection manager. It started back in 2006 with a simple idea: bring the then new idea of tabbed web browsers to remote desktop. From there, a way to remember saved session properties that was superior to a bunch of .rdp files was added (favorites), including the ability to batch edit multiple favorites at a time, making management of stored passwords simple. But why stop there? Features allowing split-screen, multiple Windows, scaled desktop sizes were added. Now in present day more advanced features are coming fast. From an integrated PowerShell scripting engine, to colored tabs for organization, RD Tabs makes a System Administrator’s life so much easier."
        }
        Publisher = 'Avian Waves LLC'
    }
    return $result
}