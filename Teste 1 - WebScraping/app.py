# Necessário efetuar instalação das libs html5lib, beautifulSoup4 e requests.

import os
from zipfile import ZipFile
import requests 
from bs4 import BeautifulSoup

print("Baixando arquivos, por favor aguarde...")
link = "https://www.gov.br/ans/pt-br/assuntos/consumidor/o-que-o-seu-plano-de-saude-deve-cobrir-1/o-que-e-o-rol-de-procedimentos-e-evento-em-saude"
source = requests.get(link)
rawData = BeautifulSoup(source.text, "html5lib")

div = rawData.find('div', id="content-core")
data = div.find_all("a", class_="internal-link")

file_links = []
file_list = ["Anexo I - Lista completa de procedimentos (.pdf)", "Anexo I - Lista completa de procedimentos (.xlsx)", "Anexo II - Diretrizes de utilização (.pdf)", "Anexo III - Diretrizes clínicas (.pdf)", "Anexo IV - Protocolo de utilização (.pdf)"]

#Pega o link atraves do atributo 'href' contido na tag se o texto em <a> for igual ao que estão contidos em 'file_list'
for links in data:
    if links.text in file_list:
        file_links.append(links["href"])

zipObj = ZipFile("gov-files.zip","w")

#Pega cada arquivo gerado e passa para dentro do arquivo (.zip)
for file_url in file_links:
    # Pega somendo o nome final do arquivo pela url do arquivo PDF
    filename = file_url.split("/")[-1]
    url = requests.get(file_url, allow_redirects=True)
    open(filename,"wb").write(url.content)
    
    zipObj.write(filename)
    if os.path.isfile(filename):
        os.remove(filename)

zipObj.close()
direct = os.getcwd()
