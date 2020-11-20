-- Funções de Agregação

-- Objetivo é obter resultados sumarizados sobre os registros de um banco de dados em uso.
-- Funções de Agregação

-- O objetivo é obter resultados sumarizados (agrupados ou com cálculos matemáticos) sobre os registros de um banco de dados em uso. 

CREATE DATABASE BD_AGREGACAO
GO

USE BD_AGREGACAO
GO

CREATE TABLE PRODUTO(
CODIGO INT PRIMARY KEY IDENTITY,
CATEGORIA VARCHAR(100),
TIPO VARCHAR(100),
NOME VARCHAR(100),
PRECO MONEY,
QTD_ESTOQUE INT)

INSERT INTO PRODUTO(CATEGORIA,TIPO,NOME,PRECO,QTD_ESTOQUE)
VALUES ('COZINHA', 'ARMARIO', 'ARMARIO MOGNO A1', 240.5, 10),
('COZINHA', 'ELETRODOMESTICO', 'GELADEIRA BRASTEMP 400 L', 1500.50, 5),
('INFORMATICA', 'SMARTPHONE', 'LG K10 POWER', 750.00, 50),
('INFORMATICA', 'NOTEBOOK', 'ACER GAMER I7', 7500.00, 3),
('INFORMATICA', 'NOTEBOOK', 'DELL I7 16 GB', 5800.00, 1),
('AUTOMOTIVO', 'PNEU', 'FIRESTON ARO 14', 199.99, 100),
('AUTOMOTIVO', 'PNEU', 'PIRELI ARO 16', 339.99, 100),
('AUTOMOTIVO', 'PNEU', 'MICHELAN ARO 15', 449.99, 50),
('INFORMATICA', 'SMARTPHONE', 'IOS 10' ,7000, 50),
('INFORMATICA', 'CONSOLE', 'PS 4', 2000, 20),
('INFORMATICA', 'CONSOLE', 'XBOX', 2200, 60),
('COZINHA', 'ELETRODOMESTICO', 'FOGÃO 8 BOCAS BRASTEMP', 1500, 240),
('INFORMATICA', 'ULTRABOOK', 'SAMSUNG I7 8GB', 3571, NULL)

SELECT * FROM PRODUTO

-- COUNT: Conta a quantidade de registros que um campo específico possui.
	-- A função COUNT(CAMPO) conta a quantidade de registros e ignora os valores nulos.
	-- A função COUNT (*) conta todos os registros com os valores nulos incluídos na contagem.

SELECT
COUNT(*) CONTA_TUDO,				-- Logo, a tabela tem 13 linhas.
COUNT(CATEGORIA) AS IGNORA_NULOS,	-- CATEGORIA não tem valores nulos.
COUNT(QTD_ESTOQUE) AS IGNORA_NULOS	-- Existe um valor nulo em QTD_ESTOQUE, logo não vai contá-lo.
FROM PRODUTO



-- SUM: Retorna o resultado da soma dos valores de um campo numérico da tabela. 	-- Essa função desconsidera na soma os valores do tipo NULL.SELECT
SUM(PRECO) AS SOMANDO_PRECOS
FROM PRODUTO
WHERE CATEGORIA = 'AUTOMOTIVO'

SELECT
SUM(QTD_ESTOQUE) AS SOMANDO_QUANTIDADE
FROM PRODUTO
WHERE CATEGORIA = 'COZINHA'

SELECT
SUM(PRECO) AS SOMANDO_PRECOS,
SUM(QTD_ESTOQUE) AS SOMANDO_QUANTIDADE  -- Não vai somar a quantidade do item 13 pois ela é null.
FROM PRODUTO
WHERE CATEGORIA = 'INFORMATICA'



-- MAX: Retorna o maior valor de uma lista de valores numéricos ou de tipo data.SELECT
MAX(QTD_ESTOQUE) MAIOR_ESTOQUE,
MAX(PRECO) MAIOR_PRECO
FROM PRODUTO-- MIN: Retorna o menor valor de uma lista de valores numéricos ou de tipo data.SELECT
MIN(QTD_ESTOQUE) MENOR_ESTOQUE,
MIN(PRECO) MENOR_PRECO
FROM PRODUTO-- AVG: Retorna a média de valores numéricos de um determinado campo, ou seja, ele soma os valores e divide pela quantidade de linhas dele. 	-- Na existência de valores do tipo NULL, eles são ignorados pela função.SELECT
AVG(QTD_ESTOQUE) MEDIA_AUTOMOTIVO,
AVG(PRECO) MEDIA_PRECO
FROM PRODUTO
WHERE CATEGORIA = 'AUTOMOTIVO'-- GROUP BY é responsável por determinar em quais colunas devem ser colocadas as linhas de saída, ou seja, quais colunas você deseja exibir além das funções de agregação.
	-- Caso a cláusula SELECT contenha funções de agregação, a cláusula GROUP BY realiza um cálculo a fim de chegar ao valor sumarizado para cada uma das colunas, ou seja, agrupar os valores agregados por uma(s) das colunas de saída.SELECT
	CATEGORIA,
	SUM(PRECO) SOMA_PRECO,		-- Soma os preços dos produtos e exibe por categoria.
	SUM(QTD_ESTOQUE) QTD_ESTOQUE
FROM PRODUTO
GROUP BY CATEGORIA


SELECT
CATEGORIA,
TIPO,
SUM(PRECO) SOMA_PRECO		-- Aqui aumenta o detalhamento da consulta, pois traz o somatório por categoria e por tipo.
FROM PRODUTO
GROUP BY CATEGORIA, TIPO	-- Qualquer coluna a mais que você queira exibir, você tem que colocar também no GROUP BY. Ou então dá erro.
ORDER BY CATEGORIA

-- O GROUP BY é o agrupamento, ele é o responsável por agrupar baseado no rótulo (no caso abaixo, o rótulo é a descrição).
-- O rótulo é o que você quer exibir para o usuário. 
-- Sempre que você quiser trazer um rótulo junto com a função de agregação (que faz o cálculo), você tem que usar o GROUP BY.

SELECT
	D.DESCRICAO AS DEPARTAMENTO,
	COUNT(*) AS QTD_FUNCIONARIOS_POR_DEPARTAMENTO,
	SUM(SALARIO) AS SOMA_SALARIOS_POR_DEPARTAMENTO
FROM FUNCIONARIO F
	INNER JOIN DEPARTAMENTO D
		ON F.CODDEPTO = D.CODIGO
GROUP BY D.DESCRICAO

-- E se eu quisesse saber a quantidade de turmas de um determinado professor da academia?

SELECT
	I.NOME AS INSTRUTOR,
	COUNT(*) AS QTD_TURMAS_PROF		-- Poderia também ser COUNT(T.CODIGO), tanto faz.
FROM INSTRUTOR
	LEFT JOIN TURMA T				-- Porque pode ter instrutor sem turma.
		ON I.MATROCULA = T.CODINSTRUTOR
GROUP BY I.NOME



-- HAVING utilizado para filtrar os valores agrupados das funções de agregação. 
	-- É importante lembrar que essa cláusula só pode ser usada em parceria com GROUP BY (ele vem depois do GROUP BY).
	-- Obs.: O HAVING é diferente do WHERE:
			-- O WHERE restringe os resultados obtidos sempre após o uso da cláusula FROM.
			-- A cláusula HAVING filtra o retorno do agrupamento, sendo necessário a utilização do GROUP BY.

SELECT 
CATEGORIA,
SUM(PRECO) SOMA_PRECO
FROM PRODUTO
WHERE CATEGORIA IS NOT NULL
GROUP BY CATEGORIA
HAVING SUM(PRECO) > 1500	-- o HAVING é como se fosse o WHERE do GROUP BY.


SELECT
CATEGORIA,
TIPO,
SUM(PRECO) SOMA_PRECO
FROM PRODUTO
GROUP BY CATEGORIA, TIPO
HAVING SUM(PRECO) >= 2500
ORDER BY CATEGORIA, TIPO