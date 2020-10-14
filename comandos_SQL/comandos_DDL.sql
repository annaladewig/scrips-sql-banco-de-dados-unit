-- COMANDOS_DDL

-- DDL: DATA DEFINITION LANGUAGE
-- O DDL é usado para criar, alterar e deletar objetos do banco de dados.
	
-- USE – Muda o contexto (BD) da janela de consulta.
	USE NOME_BANCO_DE_DADOS

	USE BD_DDL
	USE BD_DML
	USE BD_JOINS

-- CREATE – Cria OBJETOS no banco de dados. 
	CREATE OBJETO NOME_OBJETO
	
	CREATE DATABASE BD_DDL
	CREATE TABLE 
	CREATE VIEW
	CREATE SEQUENCE
	CREATE PROCEDURE

-- ALTER – Altera a estrutura dos OBJETOS no banco da dados.
	ALTER OBJETO NOME_OBJETO

	ALTER TABLE
	ALTER COLUMN -- altera a estrutura da coluna (Ex. Você quer mudar o tipo do dado daquela coluna) 
	ALTER VIEW
	ALTER SEQUENCE
	ALTER PROCEDURE

-- DROP – Apaga OBJETOS do banco de dados.
	DROP OBJETO NOME_OBJETO

	DROP DATABASE TB_X -- literalmente apaga o banco de dados inteiro (tabelas, registros...tudo).
	DROP TABLE -- apaga a tabela
	DROP COLUMN -- apaga a coluna da tabela
	DROP VIEW
	DROP PROCEDURE
	DROP TRIGGER

-- TRUNCATE – Apaga todos os REGISTROS de uma tabela, reiniciando o índice das colunas auto incrementais.
-- Obs.: O truncate só funciona com tabela.
	TRUNCATE TABLE NOME_TABELA
	
	TRUNCATE TABLE TB_X

/* Truncate e Delete, diferentemente do Drop, eles apagam os REGISTROS e não o objeto. 
   A diferença do truncate para o delete é que o delete não reinicia o índice das colunas auto incrementais, recomeça de onde parou.
   Outra diferença é que o truncate não tem a cláusula WHERE e, além disso, ele é mais rápido que o delete.
   Truncar remove todos os registros e não aciona gatilhos.
   Se existir ligação de chave estrangeira na tabela em que está sendo executado o comando, o TRUNCATE não será realizado. */

CREATE DATABASE BD_DDL

USE BD_DDL

CREATE TABLE TB_DDL
(MATRICULA TINYINT PRIMARY KEY,     -- Campos (colunas) da tabela
NOME VARCHAR(100),
SEXO CHAR(1))

ALTER TABLE TB_DDL					-- Alterando a tabela, adicionando novos campos.
ADD DT_NASC DATETIME2, 
CPF CHAR(11)

ALTER TABLE TB_DDL					-- Alterando a tabela, alterando o tipo de dados do campo DT_NASC. 
ALTER COLUMN DT_NASC DATE

ALTER TABLE TB_DDL					-- Alterando a tabela, excluindo o campo SEXO.
DROP COLUMN SEXO

TRUNCATE TABLE TB_DDL				-- Apagando todos os registros da tabela.

DROP TABLE TB_DDL					-- Apagando a tabela do banco de dados.

DROP DATABASE BD_DDL				-- Apagando o banco de dados.
