-- Views

-- View: � um objeto (ou tabela virtual) cujo o conjunto de resultados � extra�do de uma query.
	-- As views s�o usadas como uma camada de abstra��o por desenvolvedores de banco de dados. �s vezes, tamb�m s�o usadas para dar seguran�a aos dados de diversas maneiras.

/*
 Observa��es.: 
 - N�o se dever utilizar SELECT * em views.
	- Ele somente � utilizado quando houver alguma altera��o em algum campo da tabela, sendo replicado no c�digo da view.
 - A cl�usula ORDER BY n�o � valida em views.
	- Ela s� ser� valida com o uso dos comandos TOP ou OFFSET. Nesse caso, ORDER BY � usado para determinar quais linhas ser�o retornadas.

 Como criar uma View:
 - Primeiro: o comando CREATE VIEW,
 - Segundo: do nome da view
 - Terceiro: ap�s o nome o prefixo AS
 - Quarto: o �ltimo item � a consulta que queremos armazenar dentro da view.

 Boa pr�tica: 
 Criar o nome dos objetos de programa��o T-SQL com um prefixo seguido de underline. O "u" � de usu�rio.
 Ex.: Para View (uVW_), para Funcions (uFN_), Triggers (uTR_) e Store Procedures (uSP_).

*/

	CREATE VIEW uVW_NAME AS QUERY	-- Cria uma View
	
	SELECT * FROM uVW_NAME	-- Consulta uma View

	ALTER VIEW uVW_NAME AS QUERY	-- Altera a estrutura de uma View.

	DROP VIEW uVW_NAME	-- Apaga uma View.

	SP_HELPTEXT uVW_NAME	-- Visualiza o c�digo de View j� existente.

-- Dica: Antes de criar a VIEW, testa primeiro s� o SELECT, v� se est� tudo certo, a� sim executa o comando todo e cria a VIEW.

CREATE VIEW uVW_DEMITIDOS 
AS
SELECT
NOME AS 'NOME FUNCIONARIO',
DATAADMISSAO AS 'DATA ADMISS�O',
DATADEMISSAO AS 'DATA DEMISS�O'
FROM FUNCIONARIO
WHERE DATADEMISSAO IS NOT NULL		-- Ou seja, retorna todos os funcion�rios que foram demitidos.

SELECT *				-- Chama a VIEW.
FROM uVW_DEMITIDOS


SP_HELPTEXT uVW_DEMITIDOS		-- Exibe o c�digo fonte da VIEW.

-- E se eu quisesse tamb�m trazer a fun��o e o departamento do funcion�rio?
-- Lembrando que a VIEW j� est� criada.

ALTER VIEW uVW_DEMITIDOS 
AS
SELECT
NOME AS 'NOME FUNCIONARIO',
DATAADMISSAO AS 'DATA ADMISS�O',
DATADEMISSAO AS 'DATA DEMISS�O',
D.DESCRICAO AS 'DEPARTAMENTO',
FUN.DESCRICAO AS 'FUN��O'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.CODDEPTO = D.CODIGO
JOIN FUNCAO AS FUN
	ON F.CODFUNCAO = FUN.CODIGO
WHERE DATADEMISSAO IS NOT NULL

-- E se eu quisesse alterar novamente a VIEW porque agora eu quero que apare�a tamb�m o tempo do funcion�rio na empresa?

ALTER VIEW uVW_DEMITIDOS 
AS
SELECT
NOME AS 'NOME FUNCIONARIO',
DATAADMISSAO AS 'DATA ADMISS�O',
DATADEMISSAO AS 'DATA DEMISS�O',
DATEDIFF(YEAR, F.DATAADMISSAO,F.DATADEMISSAO) AS 'TEMPO NA EMPRESA',
D.DESCRICAO AS 'DEPARTAMENTO',
FUN.DESCRICAO AS 'FUN��O'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.CODDEPTO = D.CODIGO
JOIN FUNCAO AS FUN
	ON F.CODFUNCAO = FUN.CODIGO
WHERE DATADEMISSAO IS NOT NULL


SELECT *				-- Voc� pode filtrar normalmente um SELECT em uma VIEW.
FROM uVW_DEMITIDOS
WHERE DEPARTAMENTO = 'RECURSOS HUMANOS'


SELECT *				
FROM uVW_DEMITIDOS
WHERE [DATA ADMISS�O] >= '2011-05-01'


