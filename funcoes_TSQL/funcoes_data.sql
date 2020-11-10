-- Fun��es de Data

-- Data e Hora do Sistema
	-- No SQL Server h� algumas formas de sabermos a data atual do sistema via comando SQL:

	-- GETDATE() -> Data e hora atuais do sistema.	
	--				(S� funciona no SQL Server)

	-- CURRENT_TIMESTAMP -> Data e hora atuais do sistema. 
	--                     (Padr�o SQL ANSI, ou seja, funciona em qualquer SGBD.)

	-- Outras fun��es para retornar a data do sistema: SYSDATETIME(), SYSDATETIMEOFFSET(), SYSUTCDATETIME(), GETUTCDATE()

SELECT GETDATE() AS TEST_GETDATE

SELECT CURRENT_TIMESTAMP AS TEST_CURRENT

SELECT SYSDATETIME () AS TEST_SYSUTCDATETIME



-- Fun��o DATEPART(): Retorna um fragmento da data de acordo com o DATEPART escolhido. 
	-- Essa fun��o retorna um valor inteiro, que representa o valor que desejamos obter.
	-- Recebe 2 argumentos:
	-- Primeiro par�metro: fragmento da data que desejamos.
	-- Segundo par�metro: data propriamente dita.

	DATEPART (parametro1, parametro2)

SELECT
DATEPART(YEAR, GETDATE()) AS 'ANO',
DATEPART(QUARTER, GETDATE()) AS 'TRIMESTRE DO ANO',
DATEPART(MONTH, GETDATE()) AS 'M�S',
DATEPART(DAYOFYEAR, GETDATE() ) AS 'DIA DO ANO (DE 1 A 365 )',
DATEPART(DAY, GETDATE() ) AS 'DIA',
DATEPART(WEEK, GETDATE() ) AS 'SEMANA',
DATEPART(WEEKDAY, GETDATE() ) AS 'DIA DA SEMANA',
DATEPART(HOUR, GETDATE() ) AS 'HORA',
DATEPART(MINUTE, GETDATE() ) AS 'MINUTO',
DATEPART(SECOND, GETDATE() ) AS 'SEGUNDO',
DATEPART(MILLISECOND, GETDATE() ) AS 'MILISEGUNDO',
DATEPART(MICROSECOND, GETDATE() ) AS 'MICROSEGUNDO',
DATEPART(NANOSECOND, GETDATE() ) AS 'NANOSEGUNDO'-- Tamb�m pode ser assim:SELECTDATEPART(YYYY, GETDATE()) AS 'ANO',
DATEPART(MM, GETDATE()) AS 'M�S',
DATEPART(DD, GETDATE() ) AS 'DIA'-- E se fosse em uma tabela?SELECTDATEPART(DAY, DATA_NASCIMENTO) AS DIA_ANIVERSARIOFROM TB

-- Fun��o DATEDIFF(): Retorna a diferen�a em um n�mero inteiro de um intervalo de duas datas usando como argumento o fragmento de compara��o.
	-- Recebe 3 par�metros:
	-- Primeiro par�metro: fragmento da data (datepart) que desejamos.
	-- Segundo par�metro: data inicial que ser� feita a diferen�a.
	-- Terceiro par�metro: data final que ser� feita a diferen�a.

	DATEDIFF(FRAGMENTO, MENOR_DATA(incial), MAIOR_DATA(final))

SELECT
DATEDIFF(YEAR, '2018-01-01', GETDATE()) AS 'ANO',
DATEDIFF(MONTH, '2018-01-01' , GETDATE()) AS 'M�S',
DATEDIFF(DAY, '2018-01-01' , GETDATE()) AS 'DIAS',
DATEDIFF(WEEK, '2018-01-01' , GETDATE()) AS 'SEMANA',
DATEDIFF(HOUR, '2018-01-01' , GETDATE()) AS 'HORA',
DATEDIFF(MINUTE, '2018-01-01' , GETDATE()) AS 'MINUTO'



-- Fun��o DATEADD() � Tem como prop�sito incrementar ou subtrair valores absolutos de uma determinada data.
	-- Recebe 3 par�metros:
	-- Primeiro par�metro: fragmento da data (datepart) que desejamos.
	-- Segundo par�metro: valor inteiro que ser� adicionado ou subtra�do da parte da data ou fragmento.
	-- Terceiro par�metro: data que ser� utilizada.

	DATEADD(parametro1, parametro2, parametro3)

SELECT
DATEADD(YEAR, 5, getdate() ) AS 'ANO ADICIONADO',
DATEADD(YEAR, -5, getdate() ) AS 'ANO SUBTRAIDO',
DATEADD(MONTH, 5, getdate() ) AS 'M�S',
DATEADD(DAY, 5, getdate() ) AS 'DIA',
DATEADD(WEEK, 5, getdate() ) AS 'SEMANA',
DATEADD(HOUR, 5, getdate() ) AS 'HORA'



-- Fun��o DATENAME() � Tem como prop�sito retornar o nome de uma determinada parte da data passada.
	-- Recebe 2 par�metros:
	-- Primeiro par�metro: fragmento da data (datepart) que desejamos.
	-- Segundo par�metro: data a ser utilizada.

	DATENAME(fragmento, data)

SET LANGUAGE 'BRAZILIAN' -- Para trazer os nomes em portugu�s.

SELECT
DATENAME(YEAR,GETDATE()) AS 'ANO', -- N�o traz o ano por extenso
DATENAME(MONTH,GETDATE()) AS 'MES',
DATENAME(WEEKDAY,GETDATE()) AS 'DIA DA SEMANA'



-- Fun��es YEAR(), MONTH(), DAY(): S�o extens�es da fun��o DATEPART, por�m com o argumento DATEPART suprimido (impl�cito).
   -- Ex.: Em vez de usar a fun��o DATEPART(MONTH, GETDATE()) para retornar o m�s, podemos apenas utilizar a fun��o MONTH(GETDATE()) que produzir� o mesmo resultado.
	-- As fun��es DAY, MONTH e YEAR tem somente um par�metro que � a data informada.
-- A fun��o EOMONTH retorna o �ltimo dia do m�s da data passada.
-- Na fun��o EOMOTH � poss�vel passar um segundo par�metro, opcional, para incrementar ou decrementar a data.

	DAY, MONTH, YEAR (data)
	EOMONTH (data, par�metro_opcional)

SELECT
GETDATE() DATA_SISTEMA,
YEAR(GETDATE() ) AS 'ANO',
MONTH(GETDATE() ) AS 'M�S',
DAY(GETDATE() ) AS 'DIA',
EOMONTH(GETDATE()) AS 'ULTIMO DIA DO MES'-- Utilizando o par�metro opcional:SELECTEOMONTH(GETDATE(), 1) AS 'ULTIMO DIA DO MES SEGUINTE', 
EOMONTH(GETDATE(), -1) AS 'ULTIMO DIA DO MES ANTERIOR' 

-- Voc� pode combinar as fun��es:
SELECT
DAY(EOMONTH(GETDATE())) AS 'ULTIMO DIA DO MES' -- Retorna exclusivamente o dia



-- ISDATE: fun��o que verifica se uma determinada data � valida ou n�o.
	-- Recebe somente 1 par�metro que � a data a ser validada.
	-- Essa fun��o retorna um tipo inteiro, aonde: 0 -> data inv�lida e 1 -> data v�lida

	ISDATE (data) 

SELECT ISDATE(GETDATE()) AS TEST_DATE_VALID
SELECT ISDATE('2018-12-33') AS TEST_DATE_INVALID

