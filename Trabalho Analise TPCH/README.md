# Estudo sobre índices

Nessa tarefa vocês irão trabalhar com o benchmark TPC-H. O TPC é uma organização sem fins lucrativos, tendo como objetivo principal estabelecer critérios para se obter informações a respeito do desempenho de processamento de transações e de banco de dados por meio de benchmarks. Baseia-se em testes padronizados tais como o TPC-C, o TPC-W e o TPC-H para obter tais resultados e só assim divulgar os dados reais desse desempenho. Estes testes do TPC seguem normas extremamente rigorosas que testam diversos pontos do sistema - principalmente nos quesitos confiabilidade e durabilidade.

O benchmark TPC-H que utilizaremos nessa tarefa simulam um ambiente de Data Warehouse, sincronizado com bancos de dados de produção online. Ele se utiliza de consultas aleatórias de alto grau de complexidade, projetadas para responder a algumas questões de negócios do mundo real, como: perguntas sobre pré e promoções, oferta e demanda, lucro e receita e participação de mercado.

O schema em mysql se encontra anexo a esta tarefa, porém, quem quiser fazer "do zero" para aprender, basta seguir as instruções abaixo.

Como configurar o TPC-H

1) Download TPC-H:
http://www.tpc.org

2) Descompactar o tpc(versão).zip

3) Entrar na pasta do tpc $ cd /home/"nome_da_maquina"/tpc

4) Criar o makefile. $ cp makefile.suite Makefile

5) Editar o Makefile de acordo como abaixo:
$ vi Makefile
CC = gcc
DATABASE = MYSQL
MACHINE = ICL
WORKLOAD = TPCH

Sair do vi com o comando:

$ :wq!

6) Editar o arquivo tpcd.h
$ vi tpcd.h
ifdef MYSQL
define GEN_QUERY_PLAN "SET CURRENT EXPLAIN SNAPSHOT ON;"
define START_TRAN "START TRANSACTION;"
define END_TRAN "COMMIT;"
define SET_OUTPUT ""
define SET_ROWCOUNT "--
SET ROWS_FETCH %d\n"
define SET_DBASE "CONNECT TO %s ;\n"
endif

Salvar e sair:

$ :wq!

7) Instalar o GCC no yast

8) Realizar a compilação do sistema.
$ Make

9) Criar pasta data:
$ mkdir /var/data

10) Gerar base de 1gb.
$ cp /home/nome_da_maquina/tpc/dists.dss /var/data
$ cd /var/data
$ ~nome_da_maquina/tpc/dbgen -v -s 1

Apos concluir a criação da base de dados entre novamente na pasta /var e crie a pasta "Consultas".

11) Gerar consultas:
$ cd ..
$ mkdir consultas
$ ~nome_da_maquina/tpc/qgen > /var/data/consultas/all.sql

Cada grupo deve criar o esquema do TPC-H em um dos seguintes SGBDs:

a. mySQL - https://www.mysql.com/
b. Oracle - http://www.oracle.com/index.html
c. SQL Server - www.microsoft.com/SQL_Server
d. PostgreSQL - www.postgresql.org/

O TPC-H nativo não possui índices para acelerar as consultas. A sua tarefa será propor uma série de índices para melhorar o desempenho das consultas do TPC-H. Cada grupo deve instanciar dois bancos no SGBD escolhido: um deles com o uso de índices e o outro sem o uso de indices (como vimos na última aula).

Nesse relatório devem ser apresentadas as quantidades de registros do BD, os parâmetros utilizados na ferramenta DBGen para geração dos dados, o tempo de execução da consulta e uma explicação sobre a diferença de desempenho das mesmas.

Att.,

Daniel

Links úteis:

http://kejser.org/tpc-h-data-and-query-generation/
http://planet.mysql.com/entry/?id=27807
http://www.tpc.org/tpch/
