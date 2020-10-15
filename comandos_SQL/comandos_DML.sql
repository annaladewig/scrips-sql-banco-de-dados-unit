-- COMANDOS_DML

-- DML: DATA MANIPULATION LANGUAGE
-- O DML é usado para a manipulação dos registros no banco de dados.

-- INSERT - Insere registros na tabela do banco de dados.

	INSERT INTO NOME_TABELA (CAMPOS)	-- Maneira 1 de fazer o INSERT
	VALUES (VALORES)

	INSERT INTO NOME_TABELA				-- Maneira 2 de fazer o INSERT
	VALUES (VALORES)

-- Obs.: Quando não se especifica os campos no momento do INSERT, deve-se assumir a ordem de criação dos campos na tabela.

-- UPDATE - Atualiza registros na tabela do banco de dados.
	UPDATE NOME_TABELA
	SET CAMPO = NOVO_VALOR
	WHERE CONDICAO = VALOR

-- Obs.: Sempre utilizar filtros para executar este comando

-- DELETE - Deleta registros na tabela do banco de dados.

	DELETE FROM NOME_TABELA
	WHERE CONDICAO = VALOR

	DELETE NOME_TABELA
	WHERE CONDICAO = VALOR

-- Obs1.: Sempre utilizar filtros para executar este comando.
-- Obs2.: Se existir ligação de chave estrangeira na tabela que esta sendo executado o comando, o DELETE não será realizado.

-- MERGE - Executa operações de inserção, atualização ou exclusão em uma tabela de destino com base nos resultados de uma junção com uma tabela de origem.

CREATE DATABASE BD_DML

USE BD_DML

CREATE TABLE TB_DML(
MATRICULA TINYINT PRIMARY KEY,
NOME VARCHAR(100),
SEXO CHAR(1),
DT_NASC DATE)


INSERT INTO TB_DML (MATRICULA, NOME, DT_NASC, SEXO)  -- Inserindo um registro
VALUES (1, 'PESSOA_A', '2000-12-10','M')

SELECT * FROM TB_DML

INSERT INTO TB_DML (MATRICULA, NOME, DT_NASC, SEXO)	 -- Inserindo vários registros
VALUES (2, 'PESSOA_B', '2000-12-10','M'),
(3,'PESSOA_C','2000-01-01','F'),
(4,'PESSOA_D', '2000-04-23','F')

INSERT INTO TB_DML										-- Inserindo um registro na tabela sem especificar os campos.
VALUES (5, 'PESSOA_E','M', '2000-07-10')				-- Lembrar da ordem das colunas no momento da criação da tabela.
UPDATE TB_DML
SET SEXO = 'F'											-- Atualizando o registro de um campo da tabela funcionário
WHERE NOME = 'PESSOA_B'SELECT * FROM TB_DMLUPDATE TB_DML
SET SEXO = 'M', DT_NASC = '1997-07-01'					-- Atualizando dois campos de um registro da tabela funcionário.
WHERE MATRICULA = '3'
DELETE FROM TB_DML										-- Apagando o registro da tabela funcionário.
WHERE MATRICULA = 3

DELETE FROM TB_DML										-- Apagando o registro da tabela funcionário.
WHERE NOME = 'PESSOA_B' AND DT_NASC = '2000-12-10'

DELETE TB_DML											-- Apagando todos os registros da tabela funcionário.
