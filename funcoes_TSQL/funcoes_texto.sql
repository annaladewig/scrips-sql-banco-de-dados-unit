-- Fun��es de Texto

-- SUBSTRING: Extrai uma parte do texto de um texto existente.
	-- Essa fun��o utiliza 3 par�metros:
	-- Primeiro par�metro: texto (ou campo da tabela) do qual ser� extra�da a substring. 
	-- Segundo par�metro: posi��o inicial do texto. 
	-- Terceiro par�metro: quantos caracteres ele vai percorrer.

	SUBSTRING (TEXTO (OU CAMPO), PARAMETRO1, PARAMETRO2) 

DECLARE @TXT VARCHAR(10) = 'ABCDE'
SELECT SUBSTRING(@TXT,2,3) AS TEST_SUBSTRING

DECLARE @TXT2 VARCHAR(30) = 'ANNA MARIA LADEWIG'  -- Retorna apenas o nome Maria 
SELECT SUBSTRING(@TXT2,6,5) AS TEST_SUBSTRING

SELECT SUBSTRING('1234-AB55-BBF4-88DG', 11,4)	-- Retorna o BBF4

-- E se fosse o campo de uma tabela?
SELECT SUBSTRING(NOME,2,3) AS TEST_SUBSTRING
FROM TB



-- LEFT e RIGHT: Retorna os caracteres solicitados da esquerda ou da direita do par�metro de entrada.
	-- Estas fun��es recebem 2 par�metros:
	-- Primeiro par�metro: texto (ou campo da tabela)
	-- Segundo par�metro: n�mero de palavras a serem extra�das do texto.

	LEFT (texto (ou campo), par�metro2)	
	RIGHT (texto (ou campo), par�metro2) 

DECLARE @TXT3 VARCHAR(10) = 'ABCDE'
SELECT LEFT (@TXT3, 2) TEST_LEFT
SELECT RIGHT(@TXT3, 2) TEST_RIGHT

DECLARE @TXT4 VARCHAR(14) = '111.222.333-44'
SELECT LEFT (@TXT4, 3) TEST_LEFT
SELECT RIGHT(@TXT4, 2) TEST_RIGHT

SELECT RIGHT(LEFT(@TXT4, 7),3)  -- Voc� pode encadear as fun��es. Nesse caso, primeiro ele faz o LEFT e depois o RIGHT.



-- LEN: retorna o n�mero de caracteres de um texto passado como par�metro de entrada.
	-- O �nico par�metro desta fun��o � o texto (ou campo da tabela) a ser contado.	LEN(texto(campo))DECLARE @TXT5 VARCHAR(10) = 'ABCDE'  -- Retorna 5
SELECT LEN (@TXT5) AS TEST_LENDECLARE @TXT6 VARCHAR(30) = 'ANNA MARIA LADEWIG'  -- Retorna 18
SELECT LEN (@TXT6) AS TEST_LENDECLARE @TXT7 VARCHAR(20) = '111.222.333-44'SELECT LEN(@TXT7) AS TEST_LEN,	CASE 		WHEN LEN(@TXT7) = 14 THEN 'CPF V�LIDO'	ELSE 'CPF INCORRETO'	END VALIDACAO_CPF-- CHARINDEX: Retorna a posi��o da primeira ocorr�ncia de uma palavra (ou parte da palavra) de um texto completo.
	-- Recebe 2 par�metros:
	-- Primeiro par�metro: o texto que queremos encontrar.
	-- Segundo par�metro: a palavra, o texto ou o campo em que ser� realizada a pesquisa do item do par�metro 1.	CHARINDEX(parametro1, texto(ou campo)) DECLARE @TXT8 VARCHAR(20) = 'ANNA MARIA LADEWIG'
SELECT CHARINDEX(' ', @TXT8) TEST_CHARINDEX  -- Retorna em qual posi��o ocorre o 1� espa�o em branco. SELECT CHARINDEX('LADEWIG', @TXT8) TEST_CHARINDEX  -- Retorna em qual posi��o come�a a palavra Ladewig.-- Voc� pode tamb�m encadear as fun��es:SELECT SUBSTRING(@TXT8, CHARINDEX('MARIA', @TXT8), 13) -- Retorna Maria HolandaSELECT LEFT( SUBSTRING(@TXT8, CHARINDEX('MARIA', @TXT8), LEN(@TXT8)), 5)  -- Retorna Maria-- REPLACE: Substitui todas as ocorr�ncias de uma palavra por outra.
	-- Recebe 3 par�metros:
	-- Primeiro par�metro: texto ou campo da tabela.
	-- Segundo par�metro: palavra ou caractere que ser� alterado na palavra.
	-- Terceiro par�metro: palavra, texto ou informa��o que substituir� a palavra informado no segundo par�metro.

	REPLACE (texto(ou campo),parametro2, parametro3) -- Pode ser usado com o campo de uma tabela

DECLARE @TXT9 VARCHAR(50)
SET @TXT9 = 'APELIDO : PADAWAN'

SELECT REPLACE(@TXT9, ':', '>>>') TEST_REPLACE  -- Troca o : por >>>

-- Voc� pode usar de forma encadeada:
DECLARE @TXT10 VARCHAR(50)
SET @TXT10 = '111.222.333-44'

SELECT REPLACE( REPLACE(@TXT10, '.', ''), '-', '') -- Remove os pontos e o tra�o. Note que o primeiro REPLACE usa o segundo como o texto. 

-- Obs: Todas essas fun��es s�o a n�vel de SELECT. Mas, d� pra voc� fazer um REPLACE que realmente altera o conte�do de um campo da tabela:
	UPDATE TB
	SET REPLACE (NOME, "/", "-")  
	WHERE ID = 123



-- UPPER e LOWER: Retorna as palavras com todos os caracteres mai�sculos ou min�sculos.
	-- Recebe como par�metro somente o texto.

	UPPER (texto(ou campo) 
	LOWER (texto(ou campo) 

DECLARE @TXT11 VARCHAR(10) = 't-SQL'

SELECT UPPER(@TXT11) TEST_UPPER	-- Retorna tudo mai�sculo
SELECT LOWER(@TXT11) TEST_LOWER	-- Retorna tudo min�sculo

-- E se voc� quiser deixar s� a primeira letra da palavra mai�scula?
DECLARE @TXT12 VARCHAR(20) = 'brasil'
SELECT UPPER(LEFT(@TXT12, 1)) + SUBSTRING(@TXT12, 2, 5)


-- RTRIM e LTRIM: Remove os espa�os da esquerda ou da direita da palavra passada como par�metro.
-- TRIM: remove os espa�os em ambos os lados.
	-- Essas fun��es recebem como par�metro apenas o texto

	TRIM, RTRIM ou LTRIM (texto(ou campo)) 

DECLARE @TXT13 VARCHAR(20) = '   T-SQL   '

SELECT RTRIM(@TXT13) TEST_RTRIM  -- Retorna '   T-SQL'

SELECT LTRIM(@TXT13) TEST_LTRIM	 -- Retorna 'T-SQL   '

SELECT RTRIM(LTRIM(@TXT13)) TEST_RTRIM_LTRIM  -- Retorna 'T-SQL'

SELECT TRIM (@TXT13) TEST_TRIM	-- Retorna 'T-SQL'



-- CONCAT: Retorna uma cadeia de caracteres que � o resultado da concatena��o de dois ou mais valores.
	-- Substitui o uso do + no momento de concatenar os campos numa consulta.
	-- Tamb�m reduz a utiliza��o do Cast ou Convert, pois ele converte os valores em string automaticamente.

	CONCAT ('valor1', 'valor2', valor3)

DECLARE @TXT14 VARCHAR(20) = 'SQL SERVER'

SELECT CONCAT(@TXT14, ' ' ,2020, ' ', '2020-10-17') AS TEST_CONCAT  -- Voc� pode concatenar texto, com n�mero, com data, sem precisar converter.

-- J� quando utilizamos o operador '+' para realizar concatena��o, devemos nos atentar para a convers�o dos tipos de dado.

	SELECT CAMPO + ' ' + CAST (CAMPO2 AS VARCHAR(20))


DECLARE @TXT15 VARCHAR(20) = 'SQL SERVER'


SELECT @TXT15 + ' ' + CONVERT (VARCHAR (4), 2017) AS TEST_PLUS_CONVERT  -- Para juntar n�mero com texto voc� precisa converter.

SELECT CONCAT(@TXT14, ' ' ,2020) AS TEST_CONCAT  -- Usando o CONCAT voc� n�o precisa converter.

SELECT @TXT14 + 2017 AS TEST_PLUS  -- D� erro pois voc� est� usando o + e quer juntar um texto com um n�mero.



-- EXTRA:
-- Fun��es para tratamento de nulos

-- ISNULL: Verifica se primeiro par�metro � nulo e substituiu pelo valor utilizado no segundo par�metro.

-- NULLIF: Retorna nulo se os dois par�metros passados foram iguais, caso sejam diferentes, ele retorna o valor do primeiro par�metro.

-- COALESCE: � uma fun��o do SQL ANSI que retorna o primeiro valor N�O nulo em uma lista de valores.

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
ISNULL(COD_DEP, 0) AS 'C�digo Departamento' -- Quando o c�digo do Departamento for NULL, ele vai substituir por 0.
FROM TB
