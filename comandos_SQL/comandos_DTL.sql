-- COMANDOS_DTL

-- DTL: DATA TRANSACTION LANGUAGE
-- O DTL � usado para a manipula��o de transa��es (create, alter, drop, truncate, inser��o, altera��o, remo��o e consulta) no banco de dados.

-- BEGIN TRAN ou BEGIN TRANSACTION � Utilizado para iniciar uma transa��o.
	BEGIN TRAN  
	COMANDO SQL (DML,DCL, DDL)

	BEGIN TRANSACTION
	COMANDO SQL (DML,DCL, DDL)

-- COMMIT � Utilizado para gravar as transa��es no banco de dados.
	COMMIT

-- ROLLBACK � Utilizado para desfazer as altera��es de uma transa��o no banco de dados.
	ROLLBACK

-- Toda transa��o que voc� abre, voc� tem que fechar, ou com o COMMIT ou com o ROLLBACK. 

BEGIN TRAN
DROP TABLE TABLE_X

COMMIT		-- salva a altera��o no banco de dados

ROLLBACK	-- volta ao estado anterior.

--

BEGIN TRAN				-- Abre uma transa��o no banco de dados para execu��o do comando UPDATE
UPDATE TB_DML
SET SEXO = 'M'
WHERE NOME = 'PESSOA_D'

COMMIT					-- Salvar� a opera��o realizada na  base de dados e fechar� a transa��o.

ROLLBACK				-- Ir� desfazer a opera��o realizada e fechar� a transa��o.

--

BEGIN TRAN
TRUNCATE TABLE PESSOA

SELECT * FROM PESSOA
ROLLBACK

--

BEGIN TRAN
DELETE TABLE PRODUTO

SELECT * FROM PRODUTO
COMMIT

