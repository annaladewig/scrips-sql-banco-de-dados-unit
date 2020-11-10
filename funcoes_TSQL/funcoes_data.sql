-- Funções de Data

-- Data e Hora do Sistema
	-- No SQL Server há algumas formas de sabermos a data atual do sistema via comando SQL:

	-- GETDATE() -> Data e hora atuais do sistema.	
	--				(Só funciona no SQL Server)

	-- CURRENT_TIMESTAMP -> Data e hora atuais do sistema. 
	--                     (Padrão SQL ANSI, ou seja, funciona em qualquer SGBD.)

	-- Outras funções para retornar a data do sistema: SYSDATETIME(), SYSDATETIMEOFFSET(), SYSUTCDATETIME(), GETUTCDATE()

SELECT GETDATE() AS TEST_GETDATE

SELECT CURRENT_TIMESTAMP AS TEST_CURRENT

SELECT SYSDATETIME () AS TEST_SYSUTCDATETIME



-- Função DATEPART(): Retorna um fragmento da data de acordo com o DATEPART escolhido. 
	-- Essa função retorna um valor inteiro, que representa o valor que desejamos obter.
	-- Recebe 2 argumentos:
	-- Primeiro parâmetro: fragmento da data que desejamos.
	-- Segundo parâmetro: data propriamente dita.

	DATEPART (parametro1, parametro2)

SELECT
DATEPART(YEAR, GETDATE()) AS 'ANO',
DATEPART(QUARTER, GETDATE()) AS 'TRIMESTRE DO ANO',
DATEPART(MONTH, GETDATE()) AS 'MÊS',
DATEPART(DAYOFYEAR, GETDATE() ) AS 'DIA DO ANO (DE 1 A 365 )',
DATEPART(DAY, GETDATE() ) AS 'DIA',
DATEPART(WEEK, GETDATE() ) AS 'SEMANA',
DATEPART(WEEKDAY, GETDATE() ) AS 'DIA DA SEMANA',
DATEPART(HOUR, GETDATE() ) AS 'HORA',
DATEPART(MINUTE, GETDATE() ) AS 'MINUTO',
DATEPART(SECOND, GETDATE() ) AS 'SEGUNDO',
DATEPART(MILLISECOND, GETDATE() ) AS 'MILISEGUNDO',
DATEPART(MICROSECOND, GETDATE() ) AS 'MICROSEGUNDO',
DATEPART(NANOSECOND, GETDATE() ) AS 'NANOSEGUNDO'-- Também pode ser assim:SELECTDATEPART(YYYY, GETDATE()) AS 'ANO',
DATEPART(MM, GETDATE()) AS 'MÊS',
DATEPART(DD, GETDATE() ) AS 'DIA'-- E se fosse em uma tabela?SELECTDATEPART(DAY, DATA_NASCIMENTO) AS DIA_ANIVERSARIOFROM TB

-- Função DATEDIFF(): Retorna a diferença em um número inteiro de um intervalo de duas datas usando como argumento o fragmento de comparação.
	-- Recebe 3 parâmetros:
	-- Primeiro parâmetro: fragmento da data (datepart) que desejamos.
	-- Segundo parâmetro: data inicial que será feita a diferença.
	-- Terceiro parâmetro: data final que será feita a diferença.

	DATEDIFF(FRAGMENTO, MENOR_DATA(incial), MAIOR_DATA(final))

SELECT
DATEDIFF(YEAR, '2018-01-01', GETDATE()) AS 'ANO',
DATEDIFF(MONTH, '2018-01-01' , GETDATE()) AS 'MÊS',
DATEDIFF(DAY, '2018-01-01' , GETDATE()) AS 'DIAS',
DATEDIFF(WEEK, '2018-01-01' , GETDATE()) AS 'SEMANA',
DATEDIFF(HOUR, '2018-01-01' , GETDATE()) AS 'HORA',
DATEDIFF(MINUTE, '2018-01-01' , GETDATE()) AS 'MINUTO'



-- Função DATEADD() – Tem como propósito incrementar ou subtrair valores absolutos de uma determinada data.
	-- Recebe 3 parâmetros:
	-- Primeiro parâmetro: fragmento da data (datepart) que desejamos.
	-- Segundo parâmetro: valor inteiro que será adicionado ou subtraído da parte da data ou fragmento.
	-- Terceiro parâmetro: data que será utilizada.

	DATEADD(parametro1, parametro2, parametro3)

SELECT
DATEADD(YEAR, 5, getdate() ) AS 'ANO ADICIONADO',
DATEADD(YEAR, -5, getdate() ) AS 'ANO SUBTRAIDO',
DATEADD(MONTH, 5, getdate() ) AS 'MÊS',
DATEADD(DAY, 5, getdate() ) AS 'DIA',
DATEADD(WEEK, 5, getdate() ) AS 'SEMANA',
DATEADD(HOUR, 5, getdate() ) AS 'HORA'



-- Função DATENAME() – Tem como propósito retornar o nome de uma determinada parte da data passada.
	-- Recebe 2 parâmetros:
	-- Primeiro parâmetro: fragmento da data (datepart) que desejamos.
	-- Segundo parâmetro: data a ser utilizada.

	DATENAME(fragmento, data)

SET LANGUAGE 'BRAZILIAN' -- Para trazer os nomes em português.

SELECT
DATENAME(YEAR,GETDATE()) AS 'ANO', -- Não traz o ano por extenso
DATENAME(MONTH,GETDATE()) AS 'MES',
DATENAME(WEEKDAY,GETDATE()) AS 'DIA DA SEMANA'



-- Funções YEAR(), MONTH(), DAY(): São extensões da função DATEPART, porém com o argumento DATEPART suprimido (implícito).
   -- Ex.: Em vez de usar a função DATEPART(MONTH, GETDATE()) para retornar o mês, podemos apenas utilizar a função MONTH(GETDATE()) que produzirá o mesmo resultado.
	-- As funções DAY, MONTH e YEAR tem somente um parâmetro que é a data informada.
-- A função EOMONTH retorna o último dia do mês da data passada.
-- Na função EOMOTH é possível passar um segundo parâmetro, opcional, para incrementar ou decrementar a data.

	DAY, MONTH, YEAR (data)
	EOMONTH (data, parâmetro_opcional)

SELECT
GETDATE() DATA_SISTEMA,
YEAR(GETDATE() ) AS 'ANO',
MONTH(GETDATE() ) AS 'MÊS',
DAY(GETDATE() ) AS 'DIA',
EOMONTH(GETDATE()) AS 'ULTIMO DIA DO MES'-- Utilizando o parâmetro opcional:SELECTEOMONTH(GETDATE(), 1) AS 'ULTIMO DIA DO MES SEGUINTE', 
EOMONTH(GETDATE(), -1) AS 'ULTIMO DIA DO MES ANTERIOR' 

-- Você pode combinar as funções:
SELECT
DAY(EOMONTH(GETDATE())) AS 'ULTIMO DIA DO MES' -- Retorna exclusivamente o dia



-- ISDATE: função que verifica se uma determinada data é valida ou não.
	-- Recebe somente 1 parâmetro que é a data a ser validada.
	-- Essa função retorna um tipo inteiro, aonde: 0 -> data inválida e 1 -> data válida

	ISDATE (data) 

SELECT ISDATE(GETDATE()) AS TEST_DATE_VALID
SELECT ISDATE('2018-12-33') AS TEST_DATE_INVALID

