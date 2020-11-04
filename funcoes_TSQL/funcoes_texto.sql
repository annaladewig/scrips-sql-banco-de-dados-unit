-- Funções de Texto

-- SUBSTRING: Extrai uma parte do texto de um texto existente.
	-- Essa função utiliza 3 parâmetros:
	-- Primeiro parâmetro: texto (ou campo da tabela) do qual será extraída a substring. 
	-- Segundo parâmetro: posição inicial do texto. 
	-- Terceiro parâmetro: quantos caracteres ele vai percorrer.

	SUBSTRING (TEXTO (OU CAMPO), PARAMETRO1, PARAMETRO2) 

DECLARE @TXT VARCHAR(10) = 'ABCDE'
SELECT SUBSTRING(@TXT,2,3) AS TEST_SUBSTRING

DECLARE @TXT2 VARCHAR(30) = 'ANNA MARIA LADEWIG'  -- Retorna apenas o nome Maria 
SELECT SUBSTRING(@TXT2,6,5) AS TEST_SUBSTRING

SELECT SUBSTRING('1234-AB55-BBF4-88DG', 11,4)	-- Retorna o BBF4

-- E se fosse o campo de uma tabela?
SELECT SUBSTRING(NOME,2,3) AS TEST_SUBSTRING
FROM TB



-- LEFT e RIGHT: Retorna os caracteres solicitados da esquerda ou da direita do parâmetro de entrada.
	-- Estas funções recebem 2 parâmetros:
	-- Primeiro parâmetro: texto (ou campo da tabela)
	-- Segundo parâmetro: número de palavras a serem extraídas do texto.

	LEFT (texto (ou campo), parâmetro2)	
	RIGHT (texto (ou campo), parâmetro2) 

DECLARE @TXT3 VARCHAR(10) = 'ABCDE'
SELECT LEFT (@TXT3, 2) TEST_LEFT
SELECT RIGHT(@TXT3, 2) TEST_RIGHT

DECLARE @TXT4 VARCHAR(14) = '111.222.333-44'
SELECT LEFT (@TXT4, 3) TEST_LEFT
SELECT RIGHT(@TXT4, 2) TEST_RIGHT

SELECT RIGHT(LEFT(@TXT4, 7),3)  -- Você pode encadear as funções. Nesse caso, primeiro ele faz o LEFT e depois o RIGHT.



-- LEN: retorna o número de caracteres de um texto passado como parâmetro de entrada.
	-- O único parâmetro desta função é o texto (ou campo da tabela) a ser contado.	LEN(texto(campo))DECLARE @TXT5 VARCHAR(10) = 'ABCDE'  -- Retorna 5
SELECT LEN (@TXT5) AS TEST_LENDECLARE @TXT6 VARCHAR(30) = 'ANNA MARIA LADEWIG'  -- Retorna 18
SELECT LEN (@TXT6) AS TEST_LENDECLARE @TXT7 VARCHAR(20) = '111.222.333-44'SELECT LEN(@TXT7) AS TEST_LEN,	CASE 		WHEN LEN(@TXT7) = 14 THEN 'CPF VÁLIDO'	ELSE 'CPF INCORRETO'	END VALIDACAO_CPF-- CHARINDEX: Retorna a posição da primeira ocorrência de uma palavra (ou parte da palavra) de um texto completo.
	-- Recebe 2 parâmetros:
	-- Primeiro parâmetro: o texto que queremos encontrar.
	-- Segundo parâmetro: a palavra, o texto ou o campo em que será realizada a pesquisa do item do parâmetro 1.	CHARINDEX(parametro1, texto(ou campo)) DECLARE @TXT8 VARCHAR(20) = 'ANNA MARIA LADEWIG'
SELECT CHARINDEX(' ', @TXT8) TEST_CHARINDEX  -- Retorna em qual posição ocorre o 1º espaço em branco. SELECT CHARINDEX('LADEWIG', @TXT8) TEST_CHARINDEX  -- Retorna em qual posição começa a palavra Ladewig.-- Você pode também encadear as funções:SELECT SUBSTRING(@TXT8, CHARINDEX('MARIA', @TXT8), 13) -- Retorna Maria HolandaSELECT LEFT( SUBSTRING(@TXT8, CHARINDEX('MARIA', @TXT8), LEN(@TXT8)), 5)  -- Retorna Maria-- REPLACE: Substitui todas as ocorrências de uma palavra por outra.
	-- Recebe 3 parâmetros:
	-- Primeiro parâmetro: texto ou campo da tabela.
	-- Segundo parâmetro: palavra ou caractere que será alterado na palavra.
	-- Terceiro parâmetro: palavra, texto ou informação que substituirá a palavra informado no segundo parâmetro.

	REPLACE (texto(ou campo),parametro2, parametro3) -- Pode ser usado com o campo de uma tabela

DECLARE @TXT9 VARCHAR(50)
SET @TXT9 = 'APELIDO : PADAWAN'

SELECT REPLACE(@TXT9, ':', '>>>') TEST_REPLACE  -- Troca o : por >>>

-- Você pode usar de forma encadeada:
DECLARE @TXT10 VARCHAR(50)
SET @TXT10 = '111.222.333-44'

SELECT REPLACE( REPLACE(@TXT10, '.', ''), '-', '') -- Remove os pontos e o traço. Note que o primeiro REPLACE usa o segundo como o texto. 

-- Obs: Todas essas funções são a nível de SELECT. Mas, dá pra você fazer um REPLACE que realmente altera o conteúdo de um campo da tabela:
	UPDATE TB
	SET REPLACE (NOME, "/", "-")  
	WHERE ID = 123



-- UPPER e LOWER: Retorna as palavras com todos os caracteres maiúsculos ou minúsculos.
	-- Recebe como parâmetro somente o texto.

	UPPER (texto(ou campo) 
	LOWER (texto(ou campo) 

DECLARE @TXT11 VARCHAR(10) = 't-SQL'

SELECT UPPER(@TXT11) TEST_UPPER	-- Retorna tudo maiúsculo
SELECT LOWER(@TXT11) TEST_LOWER	-- Retorna tudo minúsculo

-- E se você quiser deixar só a primeira letra da palavra maiúscula?
DECLARE @TXT12 VARCHAR(20) = 'brasil'
SELECT UPPER(LEFT(@TXT12, 1)) + SUBSTRING(@TXT12, 2, 5)


-- RTRIM e LTRIM: Remove os espaços da esquerda ou da direita da palavra passada como parâmetro.
-- TRIM: remove os espaços em ambos os lados.
	-- Essas funções recebem como parâmetro apenas o texto

	TRIM, RTRIM ou LTRIM (texto(ou campo)) 

DECLARE @TXT13 VARCHAR(20) = '   T-SQL   '

SELECT RTRIM(@TXT13) TEST_RTRIM  -- Retorna '   T-SQL'

SELECT LTRIM(@TXT13) TEST_LTRIM	 -- Retorna 'T-SQL   '

SELECT RTRIM(LTRIM(@TXT13)) TEST_RTRIM_LTRIM  -- Retorna 'T-SQL'

SELECT TRIM (@TXT13) TEST_TRIM	-- Retorna 'T-SQL'



-- CONCAT: Retorna uma cadeia de caracteres que é o resultado da concatenação de dois ou mais valores.
	-- Substitui o uso do + no momento de concatenar os campos numa consulta.
	-- Também reduz a utilização do Cast ou Convert, pois ele converte os valores em string automaticamente.

	CONCAT ('valor1', 'valor2', valor3)

DECLARE @TXT14 VARCHAR(20) = 'SQL SERVER'

SELECT CONCAT(@TXT14, ' ' ,2020, ' ', '2020-10-17') AS TEST_CONCAT  -- Você pode concatenar texto, com número, com data, sem precisar converter.

-- Já quando utilizamos o operador '+' para realizar concatenação, devemos nos atentar para a conversão dos tipos de dado.

	SELECT CAMPO + ' ' + CAST (CAMPO2 AS VARCHAR(20))


DECLARE @TXT15 VARCHAR(20) = 'SQL SERVER'


SELECT @TXT15 + ' ' + CONVERT (VARCHAR (4), 2017) AS TEST_PLUS_CONVERT  -- Para juntar número com texto você precisa converter.

SELECT CONCAT(@TXT14, ' ' ,2020) AS TEST_CONCAT  -- Usando o CONCAT você não precisa converter.

SELECT @TXT14 + 2017 AS TEST_PLUS  -- Dá erro pois você está usando o + e quer juntar um texto com um número.



-- EXTRA:
-- Funções para tratamento de nulos

-- ISNULL: Verifica se primeiro parâmetro é nulo e substituiu pelo valor utilizado no segundo parâmetro.

-- NULLIF: Retorna nulo se os dois parâmetros passados foram iguais, caso sejam diferentes, ele retorna o valor do primeiro parâmetro.

-- COALESCE: É uma função do SQL ANSI que retorna o primeiro valor NÃO nulo em uma lista de valores.

	ISNULL (param_1, param_2)
	NULLIF(param_1, param_2)
	COALESCE (param_1, param_2, param_3, etc...)

SELECT
ISNULL(NULL, 'SQL') AS TEST_ISNULL,
NULLIF('SQL','SQL') AS TEST_NULLIF,
NULLIF('T-SQL','SQL') AS TEST_NULLIF2,
COALESCE(NULL, NULL, 'SQL') AS TEST_COALESCE,
COALESCE(NULL, 'T-SQL', 'SQL') AS TEST_COALESCE2

-- Como seria em uma tabela?
SELECT
ISNULL(COD_DEP, 0) AS 'Código Departamento' -- Quando o código do Departamento for NULL, ele vai substituir por 0.
FROM TB
