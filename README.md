This project is designed to easily manage applications in SCCM. The main goal of this project is to get a flexible installation configuration for your company. Because in real life a silent install is more complicated than "/qn".

## List of products and their readiness

| №   | Icon   |   Product Name  |  Web parser | Config file (Install/Uninstall) |
|-----|--------|:----------------|:--------:|:-----------:|
| 1 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/1C%20Enterprise/icon.png?raw=true" width="32">  |  1C  | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_1C_exapmle.ps1) |
| 2 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/7-zip/icon.png?raw=true" width="32">  |  7-zip | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_7zip_exapmle.ps1) |
| 3 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/ABBYY%20FineReader%2012/icon.png?raw=true" width="32">  |  Abbyy FineReader  | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_ABBYYFineReader14_exapmle.ps1) |
| 4 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/ABBYY%20Lingvo/icon.png?raw=true" width="32">  |  Abbyy Lingvo | Not necessary* | In progress |
| 5 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Acronis/icon.png?raw=true" width="32">  |  Acronis Backup Agent | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_AcronisBackupAgent_exapmle.ps1) |
| 6 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Professional/icon.png?raw=true" width="32">  |  Adobe Acrobat 9 Pro  | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_AdobeAcrobatPro9_exapmle.ps1) |
| 7 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Reader%20DC/icon.png?raw=true" width="32">  |  Adobe Acrobat Reader 2015 Classic | Not necessary* | In progress |
| 8 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Reader%20DC/icon.png?raw=true" width="32">  |  Adobe Acrobat Reader 2017 Classic | In progress | In progress |
| 9 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Adobe%20Acrobat%20Reader%20DC/icon.png?raw=true" width="32">  |  Adobe Acrobat Reader DC  | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_AdobeAcrobatReaderDC_exapmle.ps1) |
| 10 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Anaconda/icon.png?raw=true" width="32">  |  Anaconda | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Anaconda_example.ps1) |
| 11 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Axure%20RP/icon.png?raw=true" width="32">  |  AxurePR | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_AxureRP_exapmle.ps1) |
| 12 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Business%20Studio/icon.png?raw=true" width="32">  |  Business Studio | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_BusinessStudio_example.ps1) |
| 13 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Camtasia%209/icon.png?raw=true" width="32">  |  Camtasia 8 | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Camtasia_8_example.ps1) |
| 13 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Camtasia%209/icon.png?raw=true" width="32">  |  Camtasia 9 | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Camtasia_9_example.ps1) |
| 14 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Caramba%20Switcher%20Corporate/icon.png?raw=true" width="32">  |  Caramba Switcher | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_CarambaSwitcherCorporate_example.ps1) |
| 15 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Check%20Point%20Endpoint%20Security/icon.png?raw=true" width="32">  |  Check Point Endpoint Security | Not necessary* | In progress |
| 16 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/DameWare%20Mini%20Remote%20Control/icon.png?raw=true" width="32">  |  DameWare Mini Remote Control | Not necessary** | In progress |
| 17 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/DataGrip/icon.png?raw=true" width="32">  |  DataGrip | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_DataGrip_example.ps1) |
| 18 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/DaVinci%20Resolve/icon.png?raw=true" width="32">  |  DaVinchi Resolve | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_DaVinci%20Resolve_example.ps1) |
| 19 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Dropbox/icon.png?raw=true" width="32">  |  Dropbox | In progress | In progress |
| 20 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Autodesk%20DWG%20True%20Viewer/icon.png?raw=true" width="32">  |  DWG TrueView | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_DWG%20TrueView_example.ps1) |
| 21 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Far%20Manager/icon.png?raw=true" width="32">  |  Far Manager | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_FarManager_exapmle.ps1) |
| 22 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Fiddler/icon.png?raw=true" width="32">  |  Fiddler | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Fiddler_exapmle.ps1) |
| 23 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/FileZilla/icon.png?raw=true" width="32">  |  FileZilla Client | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_FileZilla_exapmle.ps1) |
| 24 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Foxit%20Reader/icon.png?raw=true" width="32">  |  Foxit Reader | In progress | In progress |
| 25 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/FreeCommander%20XE/icon.png?raw=true" width="32">  |  FreeCommander | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_FreeCommander_example.ps1) |
| 26 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/GIMP/icon.png?raw=true" width="32">  |  Gimp | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_GIMP_example.ps1) |
| 27 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/git/icon.png?raw=true" width="32">  |  Git | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Git_exapmle.ps1) |
| 28 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Git%20Extensions/icon.png?raw=true" width="32">  |  Git Extensions | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_GitExtensions_exapmle.ps1) |
| 29 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Google%20Chrome/icon.png?raw=true" width="32">  |  Google Chrome | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Google%20Chrome_example.ps1) |
| 30 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Gpg4win/icon.png?raw=true" width="32">  |  Gpg4win | In progress | In progress |
| 31 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Greenshot/icon.png?raw=true" width="32">  |  Greenshot | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Greenshot_example.ps1) |
| 32 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/InfoWatch%20Device%20Monitor/icon.png?raw=true" width="32">  |  InfoWatch | Not necessary* | In progress |
| 33 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Kaspersky/icon.png?raw=true" width="32">  |  Kaspersky agent  | Not necessary* | In progress |
| 34 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/KDiff3/icon.png?raw=true" width="32">  |  KDiff3 | In progress | In progress |
| 35 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/KeePass/icon.png?raw=true" width="32">  |  KeePass | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_KeePass_exapmle.ps1) |
| 36 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/K-Lite%20Codec%20Pack%20Standard/icon.png?raw=true" width="32">  |  K-Lite | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_KLite_exapmle.ps1) |
| 37 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/kubectl/icon.png?raw=true" width="32">  |  kubectl | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_kubectl_example.ps1) |
| 38 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Local%20Administrator%20Password%20Solution/icon.png?raw=true" width="32">  |  Local Administrator Password Solution | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_LAPS_exapmle.ps1) |
| 39 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Logitech%20Options/icon.png?raw=true" width="32">  |  Logitech Options | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Logitech%20Options_example.ps1) |
| 40 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Message%20Analyzer/icon.png?raw=true" width="32">  |  Message Analyzer | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_MessageAnalyzer_exapmle.ps1) |
| 41 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Azure%20Information%20Protection/icon.png?raw=true" width="32">  |  Microsoft Azure Information Protection | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Azure%20Information%20Protection_example.ps1) |
| 42 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Edge/icon.png?raw=true" width="32">  |  Microsoft Edge | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Microsoft%20Edge_example.ps1) |
| 43 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PowerBI%20Desktop/icon.png?raw=true" width="32">  |  Microsoft Power BI Desktop | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_PowerBI_RS_exapmle.ps1) |
| 44 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SQL%20Management%20Studio/icon.png?raw=true" width="32">  |  Microsoft SQL Server Management Studio | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_SQLManagemetStudio_exapmle.ps1) |
| 45 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Teams/icon.png?raw=true" width="32">  |  Microsoft Teams | In progress | In progress |
| 46 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Visual%20C++/icon.png?raw=true" width="32">  |  Microsoft Visual C++ 2015-2019 Redistributable | Not necessary* | In progress |
| 47 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Microsoft%20Visual%20C++/icon.png?raw=true" width="32">  |  Microsoft Visual C++ 2015-2022 Redistributable | Not necessary* | In progress |
| 48 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Visual%20Studio%20Code/icon.png?raw=true" width="32">  |  Microsoft Visual Studio Code | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_VSCode_exapmle.ps1) |
| 49 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Mozilla%20Firefox%20ESR/icon.png?raw=true" width="32">  |  Mozilla Firefox ESR | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_MozillaFirefoxESR_exapmle.ps1) |
| 50 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/mRemoteNG/icon.png?raw=true" width="32">  |  mRemoteNG | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_mRemoteNG_exapmle.ps1) |
| 51 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Nmap/icon.png?raw=true" width="32">  |  Nmap | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Nmap_exapmle.ps1) |
| 52 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Notepad++/icon.png?raw=true" width="32">  |  Notepad++ | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Notepad%2B%2B_exapmle.ps1) |
| 53 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/OBS%20Studio/icon.png?raw=true" width="32">  |  OBS Studio | In progress | In progress |
| 54 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/IAM/icon.png?raw=true" width="32">  |  One Identity Manager | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_IAM_example.ps1) |
| 55 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Java/__icon.png?raw=true" width="32">  |  Oracle Java 7 | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_JRE_example.ps1) |
| 56 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Java/__icon.png?raw=true" width="32">  |  Oracle Java SE Development Kit | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_JDK_example.ps1) |
| 57 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Oracle%20SQL%20Developer/icon.png?raw=true" width="32">  |  Oracle SQL Developer | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Oracle%20SQL%20Develope_example.ps1) |
| 58 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Orca/Icon.png?raw=true" width="32">  |  Orca | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Oracle%20SQL%20Develope_example.ps1) |
| 59 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/paint.net/icon.png?raw=true" width="32">  |  Paint.NET | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_PaintNet_exapmle.ps1) |
| 60 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PDF%20Creator%2024/icon.png?raw=true" width="32">  |  PDF24 Creator | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_PDFCreator24_exapmle.ps1) |
| 61 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/pgAdmin/icon.png?raw=true" width="32">  |  pgAdmin | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_pgAdmin_example.ps1) |
| 62 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PHPStorm/icon.png?raw=true" width="32">  |  PHP Storm | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_PHPStorm_example.ps1) |
| 63 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Postman/icon.png?raw=true" width="32">  |  Postman | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Postman_example.ps1) |
| 64 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Punto%20Switcher/icon.png?raw=true" width="32">  |  PuntoSwitcher | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_PuntoSwitcher_exapmle.ps1) |
| 65 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Putty/icon.png?raw=true" width="32">  |  PuTTY | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Putty_exapmle.ps1) |
| 66 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PyCharm/icon.png?raw=true" width="32">  |  PyCharm | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_PyCharm_example.ps1) |
| 66 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/PyCharm/icon.png?raw=true" width="32">  |  PyCharm | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_PyCharm%20Community_example.ps1) |
| 67 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Python/icon.png?raw=true" width="32">  |  Python 3 | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Python3_exapmle.ps1) |
| 68 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Remote%20Desktop%20Connection%20Manager/icon.png?raw=true" width="32">  |  Remote Desktop Connection Manager (RDCMan) | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_RDCMan_exapmle.ps1) |
| 69 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Remote%20Server%20Administration%20Tools/icon.png?raw=true" width="32">  |  Remote Server Administration Tools (RSAT) | Not necessary* | In progress |
| 70 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/RD%20Tabs/icon.png?raw=true" width="32">  |  RD Tabs | Ready | In progress |
| 71 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SAS%20Enterprise%20Guide/icon.png?raw=true" width="32">  |  SAS Enterprise Guide | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_SAS%20Enterprise%20Guide_example.ps1) |
| 72 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SBIS%20Plugin/icon.png?raw=true" width="32">  |  SBIS Plugin | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_SBIS%20Plugin_example.ps1) |
| 73 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SCCM%20Client/icon.png?raw=true" width="32">  |  SCCM Console | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_SCCMConsole_exapmle.ps1) |
| 74 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Secret%20Net%20Studio/icon.png?raw=true" width="32">  |  Secret Net Studio | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Secret%20Net%20Studio_example.ps1) |
| 75 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Snagit/icon.png?raw=true" width="32">  |  Snagit | Not necessary* | In progress |
| 76 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/SoapUI/icon.png?raw=true" width="32">  |  SoapUI | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_SoapUI_example.ps1) |
| 77 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Strategy%20Design%20Studio/icon.png?raw=true" width="32">  |  Strategy Design Studio | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Strategy%20Design%20Studio_example.ps1) |
| 78 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Sublime%20Merge/icon.png?raw=true" width="32">  |  Sublime Merge | In progress | In progress |
| 79 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Symantec%20Endpoint%20Protection/icon.png?raw=true" width="32">  |  Symantec Endpoint Protection | Not necessary* | In progress |
| 80 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Tableau/icon.png?raw=true" width="32">  |  Tableau Desktop | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Tableau_example.ps1) |
| 81 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Taxcom%20Plugin/icon.png?raw=true" width="32">  |  Taxcom Plugin | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Taxcom%20Plugin_example.ps1) |
| 82 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TeamViewer/icon.png?raw=true" width="32">  |  TeamViewer Host | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_TeamViewer_example.ps1) |
| 83 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Think-cell/icon.png?raw=true" width="32">  |  think-cell | Not necessary* | In progress |
| 84 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TortoiseGit/icon.png?raw=true" width="32">  |  TortoiseGit | In progress | In progress |
| 85 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TortoiseSVN/icon.png?raw=true" width="32">  |  TortoiseSVN | In progress | In progress |
| 86 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Total%20Commander/icon.png?raw=true" width="32">  |  Total Commander | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_TotalCommander_exapmle.ps1) |
| 87 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/TreeSize%20Free/icon.png?raw=true" width="32">  |  TreeSize Free | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_TreeSize%20Free_example.ps1) |
| 88 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Visio%20Viewer/icon.png?raw=true" width="32">  |  Visio Viewer | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_VisioViewer_exapmle.ps1) |
| 89 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/VLC/icon.png?raw=true" width="32">  |  VLC | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_VLC_exapmle.ps1) |
| 90 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/VMware%20Horizon%20Client/icon.png?raw=true" width="32">  |  VMware Horizon Client | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_VMware%20Horizon%20Client_example.ps1) |
| 91 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/VMware%20Tools/icon.png?raw=true" width="32">  |  VMware Tools | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_VMWare%20tools_example.ps1) |
| 92 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Cisco%20Webex%20Meetings/icon.png?raw=true" width="32">  |  WebEx | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_Webex_exapmle.ps1) |
| 93 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinDjView/icon.png?raw=true" width="32">  |  WinDjView | In progress | In progress |
| 94 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinMerge/icon.png?raw=true" width="32">  |  WinMerge | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_WinMerge_example.ps1) |
| 95 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinRAR/icon.png?raw=true" width="32">  |  WinRAR | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_WinRAR_exapmle.ps1) |
| 96 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/WinSCp/icon.png?raw=true" width="32">  |  WinSCP | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_WinSCP_example.ps1) |
| 97 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Wireshark/icon.png?raw=true" width="32">  |  Wireshark | Ready | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_WireShark_exapmle.ps1) |
| 98 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/XMind/icon.png?raw=true" width="32">  |  XMind | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_XMind_exapmle.ps1) |
| 99 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/XnView/icon.png?raw=true" width="32">  |  XnView | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_XnView_exapmle.ps1) |
| 100 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Yandex%20Browser/icon.png?raw=true" width="32">  |  Yandex Browser | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_YandexBrowser_exapmle.ps1) |
| 101 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/Zabbix/icon.png?raw=true" width="32">  |  Zabbix agent | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_zabbix_example.ps1) |
| 102 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/%D0%93%D0%B0%D0%BB%D0%B0%D0%BA%D1%82%D0%B8%D0%BA%D0%B0/icon.png?raw=true" width="32">  |  Галактика | Not necessary* | In progress |
| 103 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/%D0%9A%D0%9E%D0%9C%D0%9F%D0%90%D0%A1-3D%20Viewer/icon.png?raw=true" width="32">  |  КОМПАС-3D Viewer | In progress | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_KompasViewer_exapmle.ps1) |
| 104 |  <img src="https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Applications/%D0%90%D0%9F%20%D0%9A%D0%BE%D0%BD%D1%82%D0%B8%D0%BD%D0%B5%D0%BD%D1%82/icon.jpeg?raw=true" width="32">  |  Континент АП | Not necessary* | [Ready](https://github.com/rprokhorov/SCCM-Software-Check/blob/master/Template/SupportFiles/Config%20files/Config_ContinentAP_example.ps1) |


- No need* - I think that it makes no sense to try to write site parsers, provided that this software is updated only after approval by software administrators.
- in progress - it is worth writing and publishing either a config or a site parser

## REST API
If you do not want to run scripts for parsing sites on your site, but only want to receive data about applications, then I started making a REST service https://sccm-software-check.azurewebsites.net/api/application

### REST request examples
- Request the latest version of the application

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

- Requesting a specific application version

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

## Folder structure

- __Applications__ - the folder contains application icons and some custom settings or transformation files for applications. For example, for VLC, you need to apply a transformation file for "quiet first launch of the application."
- __Software Check__ - the folder contains scripts that parse sites, get the latest version of the application, download links. and if your file share does not have this version, then it downloads it. Then it starts creating the application in SCCM.
- __Template__ - the folder contains fork PSADT, which was redesigned to work with configuration files + minor cosmetic improvements.

## Installation
1) Copy repository
2) Edit file Config.json in folder SoftwareCheck for work in your's infrastructure
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
3) Run script All.ps1 or add it to run from Task Scheduler
        
_________________
## Content folder structure
What I got using this approach in my work (for obvious reasons, I can only take screenshots from the test environment, but this does not change anything):

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/FileshareStructure.png?raw=true "File share structure")

- _Red_ - content folder. __DistribPath__ in Config.json
- _Green_ - folder named as application.
- _Blue_ - a version of the product that will be understood by a person. For example, the "SQL Server Management Studio" application, when launched and downloaded, says that it has a version of "18.4", but when installed on the system, it will have a version of "15.0.18206.0". In this case, for ease of use, the folder is created with version 18.4, and the version "15.0.18206.0" will be used in the DetectionMethod file itself.
- _Purple_ - folder with downloaded files.
- _Yellow_ - example of downloaded files.

____________
## Structure of applications and folders in SCCM

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/SCCMApplicationsStructure.png?raw=true "SCCM Application structure")

- _Red_ - the name of the application root folder of the application. I prefer to make the list as narrow as possible, since in this case any new employee should not have any secret advantages, but simply have to look through the list and find the right one.
- _Blue_ - folder with archive versions of applications. I prefer not to delete old applications, but simply move them to a separate folder. There may also be stored applications that relate to this product and inherited, and for some reason are no longer used. In that case, I'd rather save the app too.
- _Green_ - приложения, которые используются в данный момент в продакшене. В определённый момент тут будут находиться 2 версии приложений v1 и v2, пока не произошёл переход с одной версии на другую.

________

## Template

![alt text](https://github.com/rprokhorov/LikePatchMyPC/blob/master/Documentation/TemplateStructure.png?raw=true "Template structure")

It based on PSADT project (https://psappdeploytoolkit.com)

I made the following changes:
- _Red_ - folder that contains all sample Config files.
- _Blue_ - Config.ps1 file, which will be executed to install and uninstall applications.
- _Green_ - DetectionMethod.ps1 file, which will be executed as Detection Method in the SCCM application.
- _White_ -  original PSADT files
- _Yellow_ - parts of the template that I changed.

_______
## Config.ps1 file
This file is used to describe the installation/post-installation and uninstallation steps of the application. The file has the format of a hash table in PowerShell (I did not find another normal option to store a separate ScriptBlock).

Example Config.ps1 file:

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
        Show-InstallationProgress -StatusMessage "Install application $appName `nStep [1/2] install new version of software..."
        # Install block
        if ($Is64Bit)
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\FirefoxESR_x64.exe" -Parameters "/s /INI=$dirFiles\Firefox.ini"
        }
        else
        {
            $mainExitCode = Execute-Process -Path "$dirFiles\FirefoxESR_x86.exe" -Parameters "/s /INI=$dirFiles\Firefox.ini"
        }
        Show-InstallationProgress -StatusMessage "Install application $appName `nStep [2/2] copy policy files..."
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

- _appVendor_ - application author (Mozilla)
- _appName_ - the name of the application in SCCM, and in the installation window if it will show the installation process.
- _appVersion_ - the version of the application that is human-readable. See the example above with SQL Management Studio.
- _appDetectionVersion_ - application version to be used when executing DetectionMethod.ps1
- _appDetectionName_ - the name of the application that will be used to find it on the computer. For example, appName = "Adobe Flash Player ActiveX", while on the computer the application will be searched for by the mask appDetectionName = "Adobe Flash Player*ActiveX"
- _appScriptDate_ - variable to understand when this config file was created. Not used anywhere.
- _appScriptAuthor_ - config author.
- _close_app_ - applications that must be closed before the installation of the application can begin. If the application is running on the computer and interferes with the installation, the user will be shown a window asking them to close the application or postpone the installation.
- _InstallScriptBlock_ - a block that describes how the application will be installed. You can and should use PSADT functions in a block.
- _UninstallScriptBlock_ - the block to be executed when the app uninstall is triggered

_______
## DetectionMethod.ps1 file
The file is used as the Detection method when creating an Application in SCCM.
File description:
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
- _function write-log_ - function for writing logs in cmtrace format.
- _function Get-InstalledApplication_ - a function from PSADT that returns an array of applications, since multiple applications can be found on the computer.
- _appName_ - the name of the application
- _appVersion_ - the version of the application that is human-readable. See the example above with SQL Management Studio.
- _appDetectionVersion_ - application version to be used when executing DetectionMethod.ps1
- _appDetectionName_ - the name of the application that will be used to find it on the computer. For example, appName = "Adobe Flash Player ActiveX", while on the computer the application will be searched for by the mask appDetectionName = "Adobe Flash Player*ActiveX"
- _$LogName_ - the path where the log will be stored
- _#Detection block_ - a description of how your applications will be searched. In a specific case, a search is made for all applications by mask, and if at least one is lower than the version we are looking for, then it will be considered that the application was not found. In the future, this will help to clean up the infrastructure from old artifacts.