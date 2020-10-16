-- COMANDOS_DQL

-- DQL: DATA QUERY LANGUAGE
-- O DQL � usado para consultar dados no banco de dados.

-- SELECT � Usado para consultar informa��o aos registros das tabelas/views ou Function_table_valued do banco de dados.
	SELECT <valor a ser exibido>

	SELECT <valor a ser exibido>						--OPCIONAL 
	FROM TABELA ou VIEW ou FUNCTION OU outros objetos.

	SELECT * FROM TABLE_X
	SELECT * FROM VIEW_Y

-- Obs.: � poss�vel executar um SELECT sem uma tabela. Podemos execut�-lo para mostrar um valor fixo ou exibir o nome de uma vari�vel.


SELECT *		-- Lista todas as colunas da tabela com todos os registros.
FROM TB_DML

SELECT			-- Seleciona apenas algumas colunas da tabela.
NOME, DT_NASC
FROM TB_DML
WHERE SEXO = 'F'

SELECT *		-- Seleciona todas as colunas da tabela, filtrando por v�rias informa��es.
FROM TB_DML
WHERE DT_NASC > '1999-10-25'
AND SEXO = 'F'
