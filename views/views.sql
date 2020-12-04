-- Views

-- View: É um objeto (ou tabela virtual) cujo o conjunto de resultados é extraído de uma query.
	-- As views são usadas como uma camada de abstração por desenvolvedores de banco de dados. Às vezes, também são usadas para dar segurança aos dados de diversas maneiras.

/*
 Observações.: 
 - Não se dever utilizar SELECT * em views.
	- Ele somente é utilizado quando houver alguma alteração em algum campo da tabela, sendo replicado no código da view.
 - A cláusula ORDER BY não é valida em views.
	- Ela só será valida com o uso dos comandos TOP ou OFFSET. Nesse caso, ORDER BY é usado para determinar quais linhas serão retornadas.

 Como criar uma View:
 - Primeiro: o comando CREATE VIEW,
 - Segundo: do nome da view
 - Terceiro: após o nome o prefixo AS
 - Quarto: o último item é a consulta que queremos armazenar dentro da view.

 Boa prática: 
 Criar o nome dos objetos de programação T-SQL com um prefixo seguido de underline. O "u" é de usuário.
 Ex.: Para View (uVW_), para Funcions (uFN_), Triggers (uTR_) e Store Procedures (uSP_).

*/

	CREATE VIEW uVW_NAME AS QUERY	-- Cria uma View
	
	SELECT * FROM uVW_NAME	-- Consulta uma View

	ALTER VIEW uVW_NAME AS QUERY	-- Altera a estrutura de uma View.

	DROP VIEW uVW_NAME	-- Apaga uma View.

	SP_HELPTEXT uVW_NAME	-- Visualiza o código de View já existente.

-- Dica: Antes de criar a VIEW, testa primeiro só o SELECT, vê se está tudo certo, aí sim executa o comando todo e cria a VIEW.

CREATE VIEW uVW_DEMITIDOS 
AS
SELECT
NOME AS 'NOME FUNCIONARIO',
DATAADMISSAO AS 'DATA ADMISSÃO',
DATADEMISSAO AS 'DATA DEMISSÃO'
FROM FUNCIONARIO
WHERE DATADEMISSAO IS NOT NULL		-- Ou seja, retorna todos os funcionários que foram demitidos.

SELECT *				-- Chama a VIEW.
FROM uVW_DEMITIDOS


SP_HELPTEXT uVW_DEMITIDOS		-- Exibe o código fonte da VIEW.

-- E se eu quisesse também trazer a função e o departamento do funcionário?
-- Lembrando que a VIEW já está criada.

ALTER VIEW uVW_DEMITIDOS 
AS
SELECT
NOME AS 'NOME FUNCIONARIO',
DATAADMISSAO AS 'DATA ADMISSÃO',
DATADEMISSAO AS 'DATA DEMISSÃO',
D.DESCRICAO AS 'DEPARTAMENTO',
FUN.DESCRICAO AS 'FUNÇÃO'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.CODDEPTO = D.CODIGO
JOIN FUNCAO AS FUN
	ON F.CODFUNCAO = FUN.CODIGO
WHERE DATADEMISSAO IS NOT NULL

-- E se eu quisesse alterar novamente a VIEW porque agora eu quero que apareça também o tempo do funcionário na empresa?

ALTER VIEW uVW_DEMITIDOS 
AS
SELECT
NOME AS 'NOME FUNCIONARIO',
DATAADMISSAO AS 'DATA ADMISSÃO',
DATADEMISSAO AS 'DATA DEMISSÃO',
DATEDIFF(YEAR, F.DATAADMISSAO,F.DATADEMISSAO) AS 'TEMPO NA EMPRESA',
D.DESCRICAO AS 'DEPARTAMENTO',
FUN.DESCRICAO AS 'FUNÇÃO'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.CODDEPTO = D.CODIGO
JOIN FUNCAO AS FUN
	ON F.CODFUNCAO = FUN.CODIGO
WHERE DATADEMISSAO IS NOT NULL


SELECT *				-- Você pode filtrar normalmente um SELECT em uma VIEW.
FROM uVW_DEMITIDOS
WHERE DEPARTAMENTO = 'RECURSOS HUMANOS'


SELECT *				
FROM uVW_DEMITIDOS
WHERE [DATA ADMISSÃO] >= '2011-05-01'


