Этот проект создан для упрощения работы с приложениями в SCCM. Главная цель, которую я хочу решить - это возможность гибко настраивать установку приложений, так как в жизни часто встречаются случаи, когда установка бывает немного сложнее чем установка /qn или /s флагов.

### Список продуктов и их готовность

| №   | Icon   |   Product Name  |  Check new version | Config (Install/Uninstall) |
|-----|--------|:----------------|:--------:|:-----------:|
| 1 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/1C%20Enterprise/icon.png?raw=true" width="32">  |  1C  | Не нужно* | Готово |
| 2 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/7-zip/icon.png?raw=true" width="32">  |  7-zip | Готово | Готово |
| 3 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/ABBYY%20FineReader%2012/icon.png?raw=true" width="32">  |  Abbyy FineReader  | Не нужно* | Готово |
| 4 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/ABBYY%20Lingvo/icon.png?raw=true" width="32">  |  Abbyy Lingvo | Не нужно* | В работе |
| 5 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Acronis/icon.png?raw=true" width="32">  |  Acronis Backup Agent | Не нужно* | Готово |
| 6 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Professional/icon.png?raw=true" width="32">  |  Adobe Acrobat 9 Pro  | Не нужно* | Готово |
| 7 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Reader%20DC/icon.png?raw=true" width="32">  |  Adobe Acrobat Reader 2015 Classic | Не нужно* | В работе |
| 8 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Reader%20DC/icon.png?raw=true" width="32">  |  Adobe Acrobat Reader 2017 Classic | В работе | В работе |
| 9 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Reader%20DC/icon.png?raw=true" width="32">  |  Adobe Acrobat Reader DC  | В работе | Готово |
| 10 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Anaconda/icon.png?raw=true" width="32">  |  Anaconda | В работе | В работе |
| 11 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Axure%20RP/icon.png?raw=true" width="32">  |  AxurePR | Готово | Готово |
| 12 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Business%20Studio/icon.png?raw=true" width="32">  |  Business Studio | В работе | Готово |
| 13 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Camtasia%209/icon.png?raw=true" width="32">  |  Camtasia | В работе | В работе |
| 14 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Caramba%20Switcher%20Corporate/icon.png?raw=true" width="32">  |  Caramba Switcher | В работе | Готово |
| 15 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Check%20Point%20Endpoint%20Security/icon.png?raw=true" width="32">  |  Check Point Endpoint Security | Не нужно* | В работе |
| 16 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/DameWare%20Mini%20Remote%20Control/icon.png?raw=true" width="32">  |  DameWare Mini Remote Control | Не нужно** | В работе |
| 17 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/DataGrip/icon.png?raw=true" width="32">  |  DataGrip | В работе | В работе |
| 18 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/DaVinci%20Resolve/icon.png?raw=true" width="32">  |  DaVinchi Resolve | В работе | В работе |
| 19 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Dropbox/icon.png?raw=true" width="32">  |  Dropbox | В работе | В работе |
| 20 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Autodesk%20DWG%20True%20Viewer/icon.png?raw=true" width="32">  |  DWG TrueView | В работе | В работе |
| 21 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Far%20Manager/icon.png?raw=true" width="32">  |  Far Manager | Готово | Готово |
| 22 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Fiddler/icon.png?raw=true" width="32">  |  Fiddler | Готово | Готово |
| 23 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/FileZilla/icon.png?raw=true" width="32">  |  FileZilla Client | Готово | Готово |
| 24 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Foxit%20Reader/icon.png?raw=true" width="32">  |  Foxit Reader | В работе | В работе |
| 25 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/FreeCommander%20XE/icon.png?raw=true" width="32">  |  FreeCommander | В работе | В работе |
| 26 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/GIMP/icon.png?raw=true" width="32">  |  Gimp | В работе | В работе |
| 27 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/git/icon.png?raw=true" width="32">  |  Git | Готово | Готово |
| 28 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Git%20Extensions/icon.png?raw=true" width="32">  |  Git Extensions | Готово | Готово |
| 29 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Google%20Chrome/icon.png?raw=true" width="32">  |  Google Chrome | В работе | В работе |
| 30 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Gpg4win/icon.png?raw=true" width="32">  |  Gpg4win | В работе | В работе |
| 31 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Greenshot/icon.png?raw=true" width="32">  |  Greenshot | В работе | В работе |
| 32 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/InfoWatch%20Device%20Monitor/icon.png?raw=true" width="32">  |  InfoWatch | Не нужно* | В работе |
| 33 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Kaspersky/icon.png?raw=true" width="32">  |  Kaspersky agent  | Не нужно* | В работе |
| 34 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/KDiff3/icon.png?raw=true" width="32">  |  KDiff3 | В работе | В работе |
| 35 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/KeePass/icon.png?raw=true" width="32">  |  KeePass | Готово | Готово |
| 36 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/K-Lite%20Codec%20Pack%20Standard/icon.png?raw=true" width="32">  |  K-Lite | Готово | Готово |
| 37 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/kubectl/icon.png?raw=true" width="32">  |  kubectl | В работе | В работе |
| 38 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Local%20Administrator%20Password%20Solution/icon.png?raw=true" width="32">  |  Local Administrator Password Solution | Не нужно* | Готово |
| 39 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Logitech%20Options/icon.png?raw=true" width="32">  |  Logitech Options | В работе | В работе |
| 40 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Message%20Analyzer/icon.png?raw=true" width="32">  |  Message Analyzer | Не нужно* | Готово |
| 41 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Azure%20Information%20Protection/icon.png?raw=true" width="32">  |  Microsoft Azure Information Protection | В работе | В работе |
| 42 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Edge/icon.png?raw=true" width="32">  |  Microsoft Edge | В работе | В работе |
| 43 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PowerBI%20Desktop/icon.png?raw=true" width="32">  |  Microsoft Power BI Desktop | В работе | Готово |
| 44 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SQL%20Management%20Studio/icon.png?raw=true" width="32">  |  Microsoft SQL Server Management Studio | Готово | Готово |
| 45 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Teams/icon.png?raw=true" width="32">  |  Microsoft Teams | В работе | В работе |
| 46 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Visual%20C++/icon.png?raw=true" width="32">  |  Microsoft Visual C++ 2015-2019 Redistributable | Не нужно* | В работе |
| 47 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Visual%20C++/icon.png?raw=true" width="32">  |  Microsoft Visual C++ 2015-2022 Redistributable | Не нужно* | В работе |
| 48 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Visual%20Studio%20Code/icon.png?raw=true" width="32">  |  Microsoft Visual Studio Code | Готово | Готово |
| 49 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Mozilla%20Firefox%20ESR/icon.png?raw=true" width="32">  |  Mozilla Firefox ESR | Готово | Готово |
| 50 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/mRemoteNG/icon.png?raw=true" width="32">  |  mRemoteNG | Готово | Готово |
| 51 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Nmap/icon.png?raw=true" width="32">  |  Nmap | Готово | Готово |
| 52 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Notepad++/icon.png?raw=true" width="32">  |  Notepad++ | Готово | Готово |
| 53 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/OBS%20Studio/icon.png?raw=true" width="32">  |  OBS Studio | В работе | В работе |
| 54 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/IAM/icon.png?raw=true" width="32">  |  One Identity Manager | Не нужно* | В работе |
| 55 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Java/__icon.png?raw=true" width="32">  |  Oracle Java 7 | В работе | В работе |
| 56 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Java/__icon.png?raw=true" width="32">  |  Oracle Java SE Development Kit | В работе | В работе |
| 57 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Oracle%20SQL%20Developer/icon.png?raw=true" width="32">  |  Oracle SQL Developer | Не нужно* | В работе |
| 58 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Orca/Icon.png?raw=true" width="32">  |  Orca | Не нужно* | В работе |
| 59 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/paint.net/icon.png?raw=true" width="32">  |  Paint.NET | В работе | Готово |
| 60 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PDF%20Creator%2024/icon.png?raw=true" width="32">  |  PDF24 Creator | В работе | Готово |
| 61 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/pgAdmin/icon.png?raw=true" width="32">  |  pgAdmin | В работе | В работе |
| 62 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PHPStorm/icon.png?raw=true" width="32">  |  PHP Storm | В работе | В работе |
| 63 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Postman/icon.png?raw=true" width="32">  |  Postman | Готово | Готово |
| 64 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Punto%20Switcher/icon.png?raw=true" width="32">  |  PuntoSwitcher | В работе | Готово |
| 65 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Putty/icon.png?raw=true" width="32">  |  PuTTY | Готово | Готово |
| 66 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PyCharm/icon.png?raw=true" width="32">  |  PyCharm | В работе | В работе |
| 67 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Python/icon.png?raw=true" width="32">  |  Python 3 | В работе | Готово |
| 68 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Remote%20Desktop%20Connection%20Manager/icon.png?raw=true" width="32">  |  Remote Desktop Connection Manager (RDCMan) | Готово | Готово |
| 69 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Remote%20Server%20Administration%20Tools/icon.png?raw=true" width="32">  |  Remote Server Administration Tools (RSAT) | Не нужно* | В работе |
| 70 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/RD%20Tabs/icon.png?raw=true" width="32">  |  RD Tabs | Готово | В работе |
| 71 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SAS%20Enterprise%20Guide/icon.png?raw=true" width="32">  |  SAS Enterprise Guide | Не нужно* | В работе |
| 72 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SBIS%20Plugin/icon.png?raw=true" width="32">  |  SBIS Plugin | Не нужно* | В работе |
| 73 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SCCM%20Client/icon.png?raw=true" width="32">  |  SCCM Console | Не нужно* | Готово |
| 74 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Secret%20Net%20Studio/icon.png?raw=true" width="32">  |  Secret Net Studio | Не нужно* | В работе |
| 75 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Snagit/icon.png?raw=true" width="32">  |  Snagit | Не нужно* | В работе |
| 76 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SoapUI/icon.png?raw=true" width="32">  |  SoapUI | В работе | В работе |
| 77 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Strategy%20Design%20Studio/icon.png?raw=true" width="32">  |  Strategy Design Studio | Не нужно* | В работе |
| 78 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Sublime%20Merge/icon.png?raw=true" width="32">  |  Sublime Merge | В работе | В работе |
| 79 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Symantec%20Endpoint%20Protection/icon.png?raw=true" width="32">  |  Symantec Endpoint Protection | Не нужно* | В работе |
| 80 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Tableau/icon.png?raw=true" width="32">  |  Tableau Desktop | В работе | В работе |
| 81 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Taxcom%20Plugin/icon.png?raw=true" width="32">  |  Taxcom Plugin | Не нужно* | В работе |
| 82 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TeamViewer/icon.png?raw=true" width="32">  |  TeamViewer Host | В работе | В работе |
| 83 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Think-cell/icon.png?raw=true" width="32">  |  think-cell | Не нужно* | В работе |
| 84 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TortoiseGit/icon.png?raw=true" width="32">  |  TortoiseGit | В работе | В работе |
| 85 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TortoiseSVN/icon.png?raw=true" width="32">  |  TortoiseSVN | В работе | В работе |
| 86 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Total%20Commander/icon.png?raw=true" width="32">  |  Total Commander | Готово | Готово |
| 87 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TreeSize%20Free/icon.png?raw=true" width="32">  |  TreeSize Free | В работе | В работе |
| 88 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Visio%20Viewer/icon.png?raw=true" width="32">  |  Visio Viewer | Не нужно* | Готово |
| 89 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/VLC/icon.png?raw=true" width="32">  |  VLC | Готово | Готово |
| 90 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/VMware%20Horizon%20Client/icon.png?raw=true" width="32">  |  VMware Horizon Client | Не нужно* | В работе |
| 91 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/VMware%20Tools/icon.png?raw=true" width="32">  |  VMware Tools | Не нужно* | В работе |
| 92 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Cisco%20Webex%20Meetings/icon.png?raw=true" width="32">  |  WebEx | В работе | Готово |
| 93 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinDjView/icon.png?raw=true" width="32">  |  WinDjView | В работе | В работе |
| 94 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinMerge/icon.png?raw=true" width="32">  |  WinMerge | В работе | В работе |
| 95 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinRAR/icon.png?raw=true" width="32">  |  WinRAR | Готово | Готово |
| 96 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinSCp/icon.png?raw=true" width="32">  |  WinSCP | Готово | Готово |
| 97 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Wireshark/icon.png?raw=true" width="32">  |  Wireshark | Готово | Готово |
| 98 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/XMind/icon.png?raw=true" width="32">  |  XMind | В работе | Готово |
| 99 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/XnView/icon.png?raw=true" width="32">  |  XnView | В работе | Готово |
| 100 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Yandex%20Browser/icon.png?raw=true" width="32">  |  Yandex Browser | В работе | Готово |
| 101 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Zabbix/icon.png?raw=true" width="32">  |  Zabbix agent | В работе | Готово |
| 102 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/%D0%93%D0%B0%D0%BB%D0%B0%D0%BA%D1%82%D0%B8%D0%BA%D0%B0/icon.png?raw=true" width="32">  |  Галактика | Не нужно* | В работе |
| 103 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/%D0%9A%D0%9E%D0%9C%D0%9F%D0%90%D0%A1-3D%20Viewer/icon.png?raw=true" width="32">  |  КОМПАС-3D Viewer | В работе | Готово |
| 104 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/%D0%90%D0%9F%20%D0%9A%D0%BE%D0%BD%D1%82%D0%B8%D0%BD%D0%B5%D0%BD%D1%82/icon.jpeg?raw=true" width="32">  |  Континент АП | Не нужно* | В работе |


- Не нужно* - считаю, что нет смысла пытаться писать парсеры сайтов, при условии, что данное ПО обновляется только после одобрения администраторами ПО.
- в работе - стоит в планах написать и опубликовать либо конфиг, либо парсер сайта

### REST API
Если вы не хотите запускать у себя скрипты по парсингу сайтов, а хотите только получать данные о приложениях, то я начал делать REST сервис https://sccm-software-check.azurewebsites.net/api/application

#### Примеры REST
Запрос приложения 

https://sccm-software-check.azurewebsites.net/api/application?name=Postman
``` json
{
  "TimeStamp": "2022-04-01 10:00:28",
  "Product": "Postman",
  "Version": "9.15.10",
  "Searchlink": "https://www.postman.com/downloads/",
  "Download_link_x86": "https://dl.pstmn.io/download/latest/win32",
  "Download_link_x64": "https://dl.pstmn.io/download/latest/win64",
  "icon": "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Postman/icon.png",
  "LocalizedDescription": {
    "en": "Postman is an API platform for building and using APIs. Postman simplifies each step of the API lifecycle and streamlines collaboration so you can create better APIs—faster.",
    "ru": "Postman — это платформа API для создания и использования API. Postman упрощает каждый этап жизненного цикла API и оптимизирует совместную работу, чтобы вы могли быстрее создавать более качественные API."
  },
  "Publisher": "Simon Tatharm"
}
```

Запрос приложения конкретной версии

https://sccm-software-check.azurewebsites.net/api/application?name=Postman&version=9.15.2

``` json
{
  "TimeStamp": "2022-03-28 10:12:37",
  "Product": "Postman",
  "Version": "9.15.2",
  "Searchlink": "https://www.postman.com/downloads/",
  "Download_link_x86": "https://dl.pstmn.io/download/latest/win32",
  "Download_link_x64": "https://dl.pstmn.io/download/latest/win64",
  "icon": "https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/Postman/icon.png",
  "LocalizedDescription": {
    "en": "Postman is an API platform for building and using APIs. Postman simplifies each step of the API lifecycle and streamlines collaboration so you can create better APIs—faster.",
    "ru": "Postman — это платформа API для создания и использования API. Postman упрощает каждый этап жизненного цикла API и оптимизирует совместную работу, чтобы вы могли быстрее создавать более качественные API."
  },
  "Publisher": "Simon Tatharm"
}
```


### Содержание папок

- __Applications__ - В папке содержатся иконки приложений и какие-то кастомные файлы настроек или трансформаций для приложений. Например, для VLC нужно применять файл трансформации для "тихого первого запуска приложения".
- __Software Check__ - в папке находятся скрипты, которые получают последнюю версию приложения с сайта, и если на вашей файловой шаре нет этой версии, то она его скачивает. После чего запускает создание приложения в SCCM.
- __Template__ - в папке находится fork PSADT, который был переработан для работы с файлами конфигураций + небольшие косметические улучшения.

Что я получил используя такой подход у себя в работе (по понятным причинам скриншоты я могу делать только с тестовой среды, но это ничего не меняет):


### Установка
1) Копируем содержимое репозитория
2) Правим файл Config.json в папке SoftwareCheck для работы в вашей инфраструктуре
``` json
{
    "to":"LikePatchMyPC@rprokhorov.ru",
    "From":"SCCM_service@rprokhorov.ru",
    "MailServer":"mail.rprokhorov.ru",
    "LocalDistribPath":"D:\\Sources\\Applications\\",
    "DistribPath":"\\\\SCCMandSQL\\Sources\\Applications\\",
    "ProxyURL" : "http://ProxyServer.contoso.com:8080",
    "PSADTTemplatePath" : "\\SCCMandSQL.rprokhorov.local\\Sources\\Applications\\_PSADT Template\\%AppName% %Version%\\*",
    "ProviderMachineName" : "SCCMandSQL",
    "SiteCode":"PRV"
}
```
3) Запускаем скрипт All.ps1 и смотрим результат работы
4) Добавляем в Task Scheduler запуск данного скрипта по расписанию.
        
_________________
### Структура хранения дистрибутивов

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/FileshareStructure.png?raw=true "File share structure")

- _Красный_ - сетевая папка, где будут храниться все наши дистрибутивы
- _Зелёный_ - Папка с названием продукта
- _Синий_ - версия продукта, которая будет понятна человеку. Например, приложение "SQL Server Management Studio" при запуске и скачивании пишет, что она имеет версию "18.4", но при установке в системе она будет иметь версию "15.0.18206.0". В этом случае, для простоты использования папка создаётся с версией 18.4, а уже в самом файле DetectionMethod будет использоваться версия "15.0.18206.0".
- _Фиолетовый_ - папка, где по умолчанию будут храниться сами файлы дистрибутивов
- _Жёлтый_ - пример скаченных файлов.

____________
### Структура приложений в SCCM

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/SCCMApplicationsStructure.png?raw=true "SCCM Application structure")

- _Красный_ - название приложения. Я предпочитаю делать максимально плоский список, так как в этом случае любой новый сотрудник не должен обладать какими-то тайными знаниями, а просто должен просмотреть список и найти нужное.
- _Синий_ - папка с архивными версиями приложений. Я предпочитаю не удалять старые приложения, а просто перемещать их в отдельную папку. Там же могут храниться приложения, которые относятся к этому продукту и достались  по наследству, и по какой-то причине уже не используются. В этом случае, я тоже лучше сохраню приложение.
- _Зелёный_ - приложения, которые используются в данный момент в продакшене. В определённый момент тут будут находиться 2 версии приложений v1 и v2, пока не произошёл переход с одной версии на другую.

________

### Описание шаблона

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/TemplateStructure.png?raw=true "Template structure")

Общую информацию о работе с PSADT лучше всего почитать у автора.
Я вносил следующие изменения:

- _Красный_ - папка, в которой содержатся все примеры Config файлов.
- _Синий_ - файл Config.ps1, который будет исполняться для установки и удаления приложений.
- _Зеленый_ - файл DetectionMethod.ps1, который будет исполняться в как Detection Method в приложении SCCM.
- _Белый_ -  оригинальные файлы из PSADT
- _Жёлтый_ - части шаблона, которые я изменял. Более подобно опишу позже.

_______
### Описание файла Config.ps1
Данный файл используется для описания шагов установки/пост-установки и удаления приложения. Файл имеет формат хеш-таблицы в PowerShell (Другого нормально варианта хранить отдельно ScriptBlock я не нашёл).
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
- _appDetectionVersion_ - версия приложения, которая будет использоваться при поиске в DetectionMethod.ps1
- _appDetectionName_ - имя приложения, которое будет использоваться для поиска его на компьютере. Например, appName = "Adobe Flash Player ActiveX", при этом на компьютере приложение будет искаться по маске appDetectionName = "Adobe Flash Player*ActiveX"
- _appScriptDate_ - переменная для понимания, когда был создан этот конфиг файл. Нигде не используется.
- _appScriptAuthor_ - автор конфига.
- _close_app_ - приложения, которые должны быть закрыты до начала установки приложения. Если приложение будет запущено на компьютере и будет мешать запуску установки, то пользователю будет показано окно с просьбой закрыть приложение или отложить установку.
- _InstallScriptBlock_ - блок, в котором описывается как будет проходить установка приложения. В блоке можно и нужно использовать функции PSADT.
- _UninstallScriptBlock_ - блок, который будет выполняться при запуске удаления приложения

_______
### Описание файла DetectionMethod.ps1
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
- _function Get-InstalledApplication_ - функция из PSADT, которая возвращает массив приложений, так как может быть найдено несколько приложений на компьютере.
- _appName_ - название приложения в SCCM, и в окне установки, если будет показываться процесс установки.
- _appVersion_ - версия приложения, которая "читаема" для человека. Смотрите пример выше с SQL Management Studio.
- _appDetectionVersion_ - версия приложения, которая будет использоваться при поиске в DetectionMethod.ps1
- _appDetectionName_ - имя приложения, которое будет использоваться для поиска его на компьютере. Например, appName = "Adobe Flash Player ActiveX", при этом на компьютере приложение будет искаться по маске appDetectionName = "Adobe Flash Player*ActiveX"
- _$LogName_ - путь, где будет храниться лог
- _#Detection block_ - описание того, как будет происходить поиск вашего приложений. В конкретном случае делается поиск всех приложений по маске и если хотя бы одно ниже той версии, которую мы ищем, то будет считаться, что приложение не найдено. В будущем это будет помогать вычищать инфраструктуру от старых артефактов.