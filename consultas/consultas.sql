CREATE DATABASE BD_CONSULTAS

USE BD_CONSULTAS

CREATE TABLE TB_FUNC (
MATRICULA INT PRIMARY KEY IDENTITY,
NOME VARCHAR (200) NOT NULL,
DATANASCIMENTO DATE NOT NULL,
SALARIO SMALLMONEY NULL,
DATAADMISSAO DATE DEFAULT (GETDATE()),
DATADEMISSAO DATE NULL,
INICIOFERIAS DATE NULL,
FIMFERIAS DATE NULL,
STATUS_FUNC VARCHAR(20) CHECK (STATUS_FUNC IN ('ATIVO','INATIVO','FERIAS','LICENÇA','INSS')),
VALOR TINYINT)

INSERT INTO TB_FUNC (NOME, DATANASCIMENTO,SALARIO,DATAADMISSAO,DATADEMISSAO,INICIOFERIAS,FIMFERIAS,STATUS_FUNC, VALOR)
VALUES ('ANA MARIA', '2000-01-01', 1200.55, '2018-05-01',NULL,NULL,NULL, 'ATIVO', 1),
('JOSE HENRIQUE', '1998-11-20', 2575.55, '2005-09-01','2017-12-01',NULL,NULL, 'INATIVO', 7),
('ANA MARIA', '2002-08-21', 950.00, '2019-01-01',NULL,NULL,NULL, 'ATIVO', 6),
('LUAN FELIX', '1991-09-28', 3500.00, '2013-04-01',NULL,NULL,NULL, 'ATIVO', 1),
('FELIPE JOSE DOS SANTOS', '1996-01-11', 4000, '2011-05-01','2015-01-29',NULL,NULL, 'INATIVO', 2),
('MARCELO JOSE', '1980-10-05', 7000, '2000-05-01',NULL,'2019-05-01','2019-06-01', 'ATIVO', 2),
('MARIANA MARIA', '1987-02-08', 4500, '2010-01-01',NULL,NULL,NULL, 'INSS', 3),
('JULIANA MARIA DOS SANTOS', '2002-01-01', 2000, '2017-05-01',NULL,NULL,NULL, 'LICENÇA', 5),
('MARIA ALICIA', '2001-01-01', 950, '2018-05-01',NULL,NULL,NULL, 'ATIVO', 4)

INSERT INTO TB_FUNC (NOME, DATANASCIMENTO,SALARIO,STATUS_FUNC, VALOR)
VALUES ('MARIA ALICIA', '2003-09-18', 950, 'ATIVO', 3),
('POLIANA', '2006-04-15', 1050, 'ATIVO', 5),
('ANA','2020-09-22', 750, 'ATIVO', 3)

SELECT * FROM TB_FUNC

-- SELECT
/*
Cláusulas:
SELECT - Seleciona a lista de colunas
FROM - Aonde vai se buscar os dados
WHERE - O que eu quero filtrar dos dados
GROUP BY - Agrupa os dados
HAVING - Filtra o valor do agrupamento
ORDER BY - Ordena o resultado

SELECT
<campos_da_tabela>
FROM <tabela/view/functions_tablevalue>
WHERE <filtros>
ORDER BY <campos> ASC/DESC

Uma consulta é executada logicamente nessa ordem:

1: FROM  <table source>
2: WHERE  <search condition>
3: GROUP BY  <group by list>
4: HAVING  <search condition>
5: SELECT  <select list>
6: ORDER BY  <order by list>

O SELECT nunca é o primeiro a ser executado, a não ser que você coloque ele sozinho.
*/


-- ORDER BY 
-- Maneira em que os dados são ordenados após a realização de uma consulta a uma tabela. 
-- Obs.: Quando não for informado como se quer ordenar, o SQL coloca como padrão o ASC.

SELECT *			-- ASC ou Ascendente ou Crescente
FROM TB_FUNC
ORDER BY NOME

SELECT *			
FROM TB_FUNC
ORDER BY SALARIO

SELECT *			
FROM TB_FUNC
ORDER BY DATAADMISSAO ASC

SELECT *			-- Primeiro ele ordena por nome e depois por salário.			
FROM TB_FUNC
ORDER BY
NOME ASC, SALARIO ASC

SELECT *			-- Primeiro ele ordena por nome, depois por salário e depois por valor.			
FROM TB_FUNC
ORDER BY
NOME, SALARIO, VALOR


SELECT *			-- DESC ou Descendente ou Decrescente
FROM TB_FUNC
ORDER BY NOME DESC

SELECT *			
FROM TB_FUNC
ORDER BY VALOR DESC

SELECT *			-- Misturando ASC e DESC
FROM TB_FUNC
ORDER BY NOME ASC, SALARIO DESC


-- Utilizando Operadores Relacionais

SELECT *
FROM TB_FUNC
WHERE NOME = 'ANA MARIA'		-- O valor tem que ser exatamente igual.

SELECT *
FROM TB_FUNC
WHERE DATANASCIMENTO >= '1999-01-01'

SELECT *
FROM TB_FUNC
WHERE SALARIO <= 4000

SELECT *
FROM TB_FUNC
WHERE STATUS_FUNC <> 'ATIVO'          -- Diferente pode ser <> ou !=


-- Utilizando Operadores Lógicos

SELECT
MATRICULA, NOME, SALARIO, STATUS_FUNC
FROM TB_FUNC
WHERE SALARIO = 950
AND STATUS_FUNC = 'ATIVO'

SELECT
MATRICULA, NOME, DATADEMISSAO, STATUS_FUNC
FROM TB_FUNC
WHERE
DATADEMISSAO IS NULL
OR STATUS_FUNC = 'ATIVO'

SELECT
MATRICULA, NOME, SALARIO, STATUS_FUNC
FROM TB_FUNC
WHERE
NOT STATUS_FUNC = 'ATIVO'

SELECT
MATRICULA, NOME, SALARIO, STATUS_FUNC
FROM TB_FUNC
WHERE
NOT SALARIO != 950
AND (STATUS_FUNC = 'ATIVO' OR STATUS_FUNC = 'INSS')

SELECT *
FROM TB_FUNC
WHERE SALARIO >= 2000
AND SALARIO <= 4000


-- Utilizando Operadores Aritméticos

SELECT
NOME,
SALARIO,
SALARIO + 50 AS ADICAO,
SALARIO - 20 AS SUBTRACAO,
SALARIO * 1.20 AS AJUSTE_20_PCENTO,
SALARIO / 2 AS DIVISAO
FROM TB_FUNC
WHERE STATUS_FUNC = 'ATIVO'

SELECT						-- Podem ser feitas as operações entre campos também.
NOME, SALARIO, VALOR,
SALARIO + VALOR AS ADICAO,
SALARIO - VALOR AS SUBTRACAO,
SALARIO * VALOR AS MULTIPLICACAO,
SALARIO / VALOR AS DIVISAO,
(SALARIO * VALOR)/2 AS EXPRESSAO_MATEMATICA
FROM TB_FUNC
WHERE NOT STATUS_FUNC = 'ATIVO'


-- Operadores Auxiliares
-- São operadores que facilitam a definição de condições a serem utilizadas com o comando DQL.
/*
IS NULL - Verifica se o campo é nulo
IS NOT NULL - Verifica se o campo não está nulo
BETWEEN - Verifica se o valor está em uma faixa de valores
IN - Verifica se o valor existe em uma lista de valores
LIKE - Faz uma busca melhorada de valores do tipo texto.

Obs.: Vazio é diferente de nulo. O campo vazio tem informação enquanto o nulo não.
*/

SELECT *
FROM TB_FUNC
WHERE DATADEMISSAO IS NULL

SELECT *
FROM TB_FUNC
WHERE DATADEMISSAO IS NOT NULL


SELECT *					-- Note que ele inclui os parâmetros, ele funciona como um >= e <=.
FROM TB_FUNC
WHERE MATRICULA BETWEEN 4 AND 7

SELECT *
FROM TB_FUNC
WHERE DATAADMISSAO BETWEEN '2012-01-01' AND '2018-12-20'

SELECT *					-- Note que ele inclui os parâmetros, ele funciona como um >= e <=.
FROM TB_FUNC
WHERE MATRICULA NOT BETWEEN 4 AND 7

SELECT *
FROM TB_FUNC
WHERE DATAADMISSAO NOT BETWEEN '2017-01-01' AND '2017-12-20'


SELECT *				-- Se algum dos dados da lista existir (exatamente como está escrito), ele vai mostrar.
FROM TB_FUNC
WHERE STATUS_FUNC IN ('ATIVO','FERIAS')

SELECT *
FROM TB_FUNC
WHERE VALOR NOT IN (2, 3, 6, 10, 15, 23)

SELECT *
FROM TB_FUNC
WHERE MONTH(DATAADMISSAO) IN (1, 2)

SELECT *
FROM TB_FUNC
WHERE MONTH(DATAADMISSAO) NOT IN (5, 10, 11)


/* LIKE
Obs.: Podemos utilizar a porcentagem para ajudar na busca.  % é considerado um caractere coringa em conjunto com a clausula LIKE

Palavra + % : retorna todos os registros que começam com o nome da palavra informada.

% + palavra : retorna todos os registros que terminam com a palavra informada.

% + palavra + % : retorna todos os registros que contenham a palavra no inicio, no meio ou ao final.
*/

SELECT *				-- Funciona da mesma maneira que o =, ou seja, espera o nome exato.
FROM TB_FUNC
WHERE NOME LIKE 'ANA'

SELECT *
FROM TB_FUNC
WHERE NOME LIKE 'ANA%'

SELECT *
FROM TB_FUNC
WHERE NOME LIKE '%ANA'

SELECT *
FROM TB_FUNC
WHERE NOME LIKE '%ANA%'

SELECT *				
FROM TB_FUNC
WHERE NOME LIKE 'JOSE'

SELECT *
FROM TB_FUNC
WHERE NOME LIKE 'JOSE%'

SELECT *
FROM TB_FUNC
WHERE NOME LIKE '%JOSE'

SELECT *
FROM TB_FUNC
WHERE NOME LIKE '%JOSE%'


-- Operadores EXTRAS

-- ALIAS 
-- São apelidos utilizados para renomear tabelas e colunas a nível de consulta, ou seja, somente no momento em que o SELECT é executado. Os apelidos ficam ativos durante a consulta assumindo o valor do campo ou tabela.
-- Obs1.: Caso for utilizar ALIAS de tabela, o mesmo deve ser utilizado durante toda a construção da consulta.
-- Obs2.: Em casos de ALIAS de coluna não se torna obrigatório, pois são utilizados para exibir um nome amigável para a coluna em questão.
/*
	COLUNA AS APELIDO				-- Maneira 1 (é a mais utilizada)
	Ex.: NOME AS 'NOME FUNCIONARIO'

	APELIDO = COLUNA				-- Maneira 2
	Ex.: 'NOME FUNCIONARIO' = NOME

	COLUNA APELIDO					-- Maneira 3
	Ex.: NOME 'NOME FUNCIONARIO'
*/

SELECT					-- ALIAS de tabela 
F.NOME,
F.DATAADMISSAO,
F.SALARIO,
SALARIO * VALOR			-- Obs: Se você faz algum cálculo e não coloca um apelido, a coluna fica sem nome.
FROM TB_FUNC AS F


SELECT					-- ALIAS de tabela e de coluna 
F.NOME AS 'NOME FUNCIONÁRIO',		 -- Maneira 1 (é a mais utilizada)
'DATA DE ADMISSÃO' = F.DATAADMISSAO, -- Maneira 2
F.SALARIO 'SALÁRIO FUNCIONÁRIO' 	 -- Maneira 3
FROM TB_FUNC AS F

SELECT					
F.NOME AS 'NOME FUNCIONÁRIO',		 
F.DATAADMISSAO AS 'DATA DE ADMISSÃO',
F.SALARIO AS 'SALÁRIO FUNCIONÁRIO',
(SALARIO * VALOR) AS MULTIPLICAÇÃO
FROM TB_FUNC AS F


-- CASE 
-- Utilizado para fazer uma análise lógica do valor da coluna e retornar caso seja verdadeiro ou falso.

SELECT
NOME, STATUS_FUNC,
	CASE STATUS_FUNC			  -- Leia: No caso de Status_Func, quando for ATIVO, então substitua por A. E assim por diante.
		WHEN 'ATIVO' THEN 'A'		
		WHEN 'INATIVO' THEN 'I'
		WHEN 'FERIAS' THEN 'F'
	ELSE						  -- Quando não for nenhum dos casos, coloque O.
		'O'		
	END AS SIGLA_STATUS			  -- Toda vez que você abre um CASE, você tem que fechar com a cláusula END. E você pode colocar um ALIAS.	
FROM TB_FUNC


-- Você pode passar valores, como no case anterior, ou pode fazer comparações, como nesse próximo case.  


SELECT NOME, SALARIO,		-- O ELSE não é obrigatório, pode ou não ter.
	CASE		
		WHEN SALARIO BETWEEN 1200 AND 1500 THEN SALARIO * 1.1  -- Dá uma aumento de 10%
		WHEN SALARIO BETWEEN 1501 AND 2000 THEN SALARIO * 1.2  -- Dá uma aumento de 20%
		WHEN SALARIO < 1000 THEN SALARIO		
	END SALARIO_COM_REAJUSTE			-- O ALIAS pode ou não ter o AS.
FROM TB_FUNC


-- DISTINCT 
-- Elimina linhas duplicadas de um determinado campo, retornando apenas 1 registro daquele dado. 
-- Obs1.: Ao adicionar outro campo à consulta, o DISTINCT irá somente remover as duplicatas caso os dois campos possuam valores iguais.
-- Obs2.: Ele elimina os valores duplicados somente no momento da consulta. Não altera no banco, só na consulta.

SELECT DISTINCT NOME       -- Mesmo tendo 2 Ana Marias e 2 Maria Alicias no Banco, só vai mostrar uma de cada.
FROM TB_FUNC

SELECT DISTINCT NOME, SALARIO  -- Ele vai verificar se há registros iguais, tanto no nome, quanto no salário e vai remover a duplicata.
FROM TB_FUNC				   -- Se a duplicata é só de nome ou só de salário, não vai remover. Tem que ser dos dois!

-- Quanto mais campos você coloca, mais ele vai restringindo, e ele vai vendo se todos os campos são iguais, um a um. E só remove a duplicata se todos forem iguais. 

SELECT DISTINCT NOME, SALARIO, DATANASCIMENTO 
FROM TB_FUNC


-- TOP 
-- Permite limitar o número de registros que serão mostrados na consulta. 
-- Obs1.: O comando recebe como parâmetro o número de registros a serem mostrados.
-- Obs2.: A cláusula ORDER BY irá influenciar diretamente no retorno dos registros.

SELECT TOP 3 
	MATRICULA, 
	NOME
FROM TB_FUNC


SELECT TOP 5 
	MATRICULA, 
	NOME, 
	SALARIO
FROM TB_FUNC
ORDER BY NOME ASC


SELECT TOP 10 
	MATRICULA, 
	NOME, 
	SALARIO
FROM TB_FUNC
ORDER BY SALARIO DESC
