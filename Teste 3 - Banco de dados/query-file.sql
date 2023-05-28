CREATE DATABASE dados_inventario;

USE dados_inventario;

SET GLOBAL local_infile=1; #Permite importação de dados locais (para os arquivos (.csv)), utilizado na importação posterior a criação de tabelas.

# CRIAÇÃO TABELA RELAÇÃO EMPRESAS ATIVAS ANS
CREATE TABLE rel_ativas_ans(
reg_ans int unsigned primary key,
cnpj varchar(20),
razao_social varchar(200),
nome_fantasia varchar(100),
modalidade varchar(60),
logradouro varchar(60),
numero varchar(20),
complemento varchar(50),
bairro varchar(50),
cidade varchar(50),
uf varchar(2),
cep varchar(20),
ddd varchar(5),
telefone varchar(40),
fax varchar(40),
email varchar(60),
representante_nome varchar(100),
representante_cargo varchar(100),
data_reg_ans varchar(20)
);

# CRIAÇÃO TABELA DEMONSTRATIVOS CONTABEIS 2021
CREATE TABLE contabeis_2021(
	data_dem varchar(15),
    reg_ans int unsigned,
    cd_conta_contabil varchar(60),
    desc_evento varchar(500),
    saldo_inicial varchar(100),
    saldo_final varchar(100)
);

# CRIAÇÃO TABELA DEMONSTRATIVOS CONTABEIS 2022
CREATE TABLE contabeis_2022(
	data_dem varchar(15),
    reg_ans int unsigned,
    cd_conta_contabil varchar(60),
    desc_evento varchar(500),
	saldo_inicial varchar(100),
    saldo_final varchar(100)
);

#QUERYS DE IMPORTAÇÕES DOS ARQUIVOS CSV
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/Relatorio_cadop.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE rel_ativas_ans 
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 3 ROWS; #ignora o título, nome das colunas e a linha embaixo no inicio do arquivo.

#DEMONSTRATIVOS CONTABEIS 1T 2021
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/1T2021.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2021
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS #ignora o título das colunas
(data_dem, reg_ans, cd_conta_contabil, desc_evento, saldo_final); #especifica as colunas para importação pois do 1T2021 até 3T2021 há a ausencia da coluna "VL_SALDO_INICIAL"

#DEMONSTRATIVOS CONTABEIS 2T 2021
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/2T2021.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2021
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS #ignora o título das colunas
(data_dem, reg_ans, cd_conta_contabil, desc_evento, saldo_final); #especifica as colunas para importação pois do 1T2021 até 3T2021 há a ausencia da coluna "VL_SALDO_INICIAL"

#DEMONSTRATIVOS CONTABEIS 3T 2021
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/3T2021.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2021
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS 
(data_dem, reg_ans, cd_conta_contabil, desc_evento, saldo_final); #especifica as colunas para importação pois do 1T2021 até 3T2021 há a ausencia da coluna "VL_SALDO_INICIAL"

#DEMONSTRATIVOS CONTABEIS 4T 2021
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/4T2021.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2021 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS; #ignora o título das colunas

#DEMONSTRATIVOS CONTABEIS 1T 2022
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/1T2022.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2022
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS; #ignora o título das colunas

#DEMONSTRATIVOS CONTABEIS 2T 2022
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/2T2022.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2022
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS; #ignora o título das colunas

#DEMONSTRATIVOS CONTABEIS 3T 2022
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/3T2022.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2022
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS; #ignora o título das colunas

#DEMONSTRATIVOS CONTABEIS 4T 2022
LOAD DATA LOCAL INFILE 'C:/IMPORTACOES_SQL/4T2022.csv' #local da importação, será necessário criar a pasta nesse local e por o arquivo csv ou alterar o destino para onde ele esta localizado.
INTO TABLE contabeis_2022
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS; #ignora o título das colunas


# APARTIR DO LINK ENCAMINHADO PELA LIBIANA MARONN VIA EMAIL: https://www.gov.br/ans/pt-br/acesso-a-informacao/perfil-do-setor/dados-abertos-1
# IMPORTADOS OS DADOS DISPONIVEIS DOS ULTIMOS DOIS ANOS: https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/

#Criando Indices para otimizar a busca no banco de dados
create index desc_contabeis on contabeis_2021 ( desc_evento(5));
create index desc_contabeis on contabeis_2022 ( desc_evento(5));

#QUERYS SOLICITADAS:

# 1. Quais as 10 operadoras que mais tiveram despesas com "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
SELECT rel_ativas_ans.reg_ans AS 'REG. ANS', rel_ativas_ans.razao_social AS 'EMPRESA', contabeis_2022.desc_evento AS 'DESCRICÃO EVENTO', contabeis_2022.saldo_final AS 'SALDO' FROM rel_ativas_ans 
INNER JOIN contabeis_2022
ON rel_ativas_ans.reg_ans = contabeis_2022.reg_ans
WHERE contabeis_2022.desc_evento = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
#AND data_dem BETWEEN '01/10/2022' AND '31/12/2022'
AND data_dem BETWEEN '01/01/2023' AND '31/03/2023'
ORDER BY contabeis_2022.saldo_final DESC
LIMIT 10;

#Quais as 10 operadoras que mais tiveram despesas com "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último ano?
SELECT rel_ativas_ans.reg_ans AS 'REG. ANS', rel_ativas_ans.razao_social AS 'EMPRESA', contabeis_2022.desc_evento AS 'DESCRICÃO EVENTO', contabeis_2022.saldo_final AS 'SALDO' FROM rel_ativas_ans 
INNER JOIN contabeis_2022
ON rel_ativas_ans.reg_ans = contabeis_2022.reg_ans
WHERE contabeis_2022.desc_evento = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
AND data_dem BETWEEN '01/01/2022' AND '31/12/2022'
ORDER BY contabeis_2022.saldo_final DESC
LIMIT 10; 


