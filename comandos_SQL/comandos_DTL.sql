-- COMANDOS_DTL

-- DTL: DATA TRANSACTION LANGUAGE
-- O DTL é usado para a manipulação de transações (create, alter, drop, truncate, inserção, alteração, remoção e consulta) no banco de dados.

-- BEGIN TRAN ou BEGIN TRANSACTION – Utilizado para iniciar uma transação.
	BEGIN TRAN  
	COMANDO SQL (DML,DCL, DDL)

	BEGIN TRANSACTION
	COMANDO SQL (DML,DCL, DDL)

-- COMMIT – Utilizado para gravar as transações no banco de dados.
	COMMIT

-- ROLLBACK – Utilizado para desfazer as alterações de uma transação no banco de dados.
	ROLLBACK

-- Toda transação que você abre, você tem que fechar, ou com o COMMIT ou com o ROLLBACK. 

BEGIN TRAN
DROP TABLE TABLE_X

COMMIT		-- salva a alteração no banco de dados

ROLLBACK	-- volta ao estado anterior.

--

BEGIN TRAN				-- Abre uma transação no banco de dados para execução do comando UPDATE
UPDATE TB_DML
SET SEXO = 'M'
WHERE NOME = 'PESSOA_D'

COMMIT					-- Salvará a operação realizada na  base de dados e fechará a transação.

ROLLBACK				-- Irá desfazer a operação realizada e fechará a transação.

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

