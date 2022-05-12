from dataclasses import asdict
from bs4 import BeautifulSoup
# $ pip install selenium
from selenium import webdriver
import time
import json
from datetime import datetime
import codecs
import re

options = webdriver.ChromeOptions()
options.add_argument('--no-sandbox')
options.add_argument('--window-size=1920,1080')
options.add_argument('--disable-gpu')
options.add_argument("--incognito")
options.add_argument('--headless')
# get chromedriver from
# https://sites.google.com/a/chromium.org/chromedriver/downloads
#browser = webdriver.Chrome(executable_path="C:/Users/Admin/Downloads/chromedriver_win32/chromedriver.exe", options=options)
browser = webdriver.Chrome(options=options)
browser.implicitly_wait(15)
browser.delete_all_cookies()
browser.get('https://www.jetbrains.com/datagrip/download/#section=windows')

generated_html = browser.page_source
#browser.quit
soup = BeautifulSoup(generated_html, "html.parser")

parents = soup.findAll('ul', class_='wt-text-2 wt-offset-top-24')
version = re.search('Version: [0-9\.]+', str(parents)).group(0).replace('Version: ','')
build = re.search('Build: [0-9\.]+', str(parents)).group(0).replace('Build: ','')
link = "https://www.jetbrains.com"+str(soup.findAll('span', class_='wt-download-button')[0].a['href'])
dt = datetime.now()
x = {
  "TimeStamp" : str(dt.strftime("%Y-%m-%d %H:%M:%S")),
  "Product": 'DataGrip',
  "Version": version,
  "Searchlink": 'https://www.jetbrains.com/datagrip/download/#section=windows',
  "Download_link_x86": link,
  "Download_link_x64": link,
  "icon" : 'https://raw.githubusercontent.com/rprokhorov/SCCM-Software-Check/master/Applications/DataGrip/icon.png',
  
  "cars":{
        "en": 'DataGrip is a database management environment for developers. It is designed to query, create, and manage databases. Databases can work locally, on a server, or in the cloud. Supports MySQL, PostgreSQL, Microsoft SQL Server, Oracle, and more. If you have a JDBC driver, add it to DataGrip, connect to your DBMS, and start working.',
        "ru": u'DataGrip — это среда управления базами данных для разработчиков. Он предназначен для запросов, создания и управления базами данных. Базы данных могут работать локально, на сервере или в облаке. Поддерживает MySQL, PostgreSQL, Microsoft SQL Server, Oracle и другие. Если у вас есть драйвер JDBC, добавьте его в DataGrip, подключитесь к своей СУБД и начинайте работать.'
    },
    "Publisher" : 'JetBrains',
}

result_string = json.dumps(x, ensure_ascii=False)
print(result_string)