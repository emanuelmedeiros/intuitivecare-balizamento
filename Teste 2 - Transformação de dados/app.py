#Necessários instalar as libs: pandas e tabula-py no terminal do computador.
#Caso rode via VS-Code basta instalar as libs via terminal do proprio programa.
# pip3 install pandas
# pip3 install tabula-py

import pandas as pd
import tabula
import os
from zipfile import ZipFile

file = "ANEXO I.pdf"
csv_filename = "file-data.csv"

print('Extraindo dados do PDF, aguarde...')
# Extrai as tabelas do PDF e gera os dataframes no pandas
data = tabula.read_pdf(file , pages='all', multiple_tables=False)
df = data[0]
# Remove a quebra de texto '\r' de cada linha no dataframe e faz substituição da legenda 'OD' e 'AMB' pelos respectivos nomes.
for col in df:
    #Remove quebra de texto
    df[col] = df[col].replace("\r", " ", regex = True)
    #Subsitui as siglas 'OD' e 'AMB' pelos nomes por extenso
    if col == 'OD':
        df[col] = df[col].replace('OD', 'Seg. Odontologica', regex = True)
    if col == 'AMB':
        df[col] = df[col].replace('AMB', 'Seg. Ambulatorial', regex = True)
       
# Remove a quebra de texto '\r' da coluna 'RN (alteração)' no dataframe
df2 = df.rename(columns={'RN\r(alteração)':'RN (alteração)'})

print('Gerando arquivo (.csv)...')
# Transfere os dados filtrados para o arquivo (.csv)
df2.to_csv(csv_filename, index = False)

print('Compactando arquivos...')
#Compacta os arquivos para (.zip)
zipObj = ZipFile('Teste_{Emanuel Medeiros}.zip','w')
zipObj.write(csv_filename)
zipObj.close()
if os.path.isfile(csv_filename):
    os.remove(csv_filename)
direct = os.getcwd()


