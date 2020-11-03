-- Fun��es de Convers�o de dados
/*
Fun��es de convers�o s�o utilizadas quando precisamos transformar um tipo de dados em outro.

Convers�o impl�cita: � quando um determinado tipo de dado � convertido sem a utiliza��o das fun��es de convers�o.
	Na convers�o impl�cita utiliza a preced�ncia de tipos de dados:
	A preced�ncia do tipo de dados determina qual tipo de dado ser� escolhido quando express�es de tipos diferentes forem combinadas.
	Obs1.: Por padr�o, o tipo de dado com a preced�ncia mais baixa � convertido no tipo de dados com a preced�ncia mais alta. 
	Obs2.: A convers�o para um tipo de dado de menor preced�ncia deve ser explicitada.

	Exemplo de preced�ncia (da mais baixa para a mais alta)
	- Texto -> N�meros -> Data -> XML
	- char -> varchar -> nvarchar -> tinyint -> int -> decimal -> hora -> data -> datetime2 -> xml
		Ex.: 10 + 2.20. Ele converte o tipo inteiro para decimal.
	Nem todas as combina��es de tipos de dados t�m uma convers�o.

Convers�o explicita: � necess�rio a utiliza��o das fun��es CAST e CONVERT para alterar o tipo do dado.


CAST: Fun��o de convers�o Padr�o ANSI (ou seja, funciona em qualquer SGBD).
	Obs.: O CAST � mais perform�tico do que a fun��o CONVERT (Por ser padr�o ANSI, a performance dele � melhor).

TRY_CAST: Realiza o tratamento do dado, retornando o valor NULL, quando n�o consegue converter o valor para o tipo desejado. 
		 (S� funciona no SQL Server.)

Ambos (CAST E TRY_CAST) recebem 2 par�metros:
	- Primeiro par�metro: campo a ser convertido
	- Segundo par�metro: tipo de dado para qual ser� convertido o campo.
*/

	CAST (campo AS novo_tipo)	-- Esse "campo" pode ser o campo de uma tabela.
	TRY_CAST (campo AS novo_tipo)	-- Esse "campo" pode ser o campo de uma tabela.

DECLARE @DT DATETIME
SET @DT = GETDATE()

SELECT @DT

SELECT CAST(@DT AS DATE) TEST_CAST	-- Converte de DATETIME para DATE, logo, vai trazer s� a data.

SELECT TRY_CAST(@DT AS TINYINT) TEST_TRYCAST -- Retorna NULL porque n�o vai conseguir converter (porque data � um tipo mais forte que n�mero).

-- No mesmo caso acima, como seria se tivesse sido usado o CAST?
SELECT CAST(@DT AS TINYINT) TEST_CAST -- Trava a aplica��o, por isso � melhor usar o TRY_CAST. 

-- E se fosse a partir de uma tabela e n�o de uma vari�vel?
SELECT CAST(DATA_VENDA AS DATE) TEST_CAST
FROM TB



/* 
CONVERT: O Convert � ideal para quando queremos converter de data para string, pois � poss�vel passar a formata��o que voc� quer que a data apare�a.
		 A fun��o CONVERT s� funciona no SQL Server.

TRY_CONVERT: Realiza o tratamento dos dado, retornando o valor NULL, quando n�o consegue converter o valor para o tipo desejado.

Ambas podem receber 2 ou 3 par�metros:
	Primeiro par�metro: tipo de dado para qual ser� convertido o campo.
	Segundo par�metro: campo que ser� convertido.
	Terceiro par�metro: Opcional, utilizado para formata��o de campos de data.
*/

	CONVERT(TIPO_DE_DADO, campo, formatacao_data(opcional))	-- Esse "campo" pode ser o campo de uma tabela.
	TRY_CONVERT(TIPO_DE_DADO, campo, formatacao_data(opcional)) -- Esse "campo" pode ser o campo de uma tabela.

DECLARE @DT DATETIME
SET @DT = GETDATE()

SELECT CONVERT(DATE, @DT) TEST_CONVERT

SELECT CONVERT(VARCHAR(10), @DT, 103) TEST_CONVERT_DT
-- Esse 103 significa padr�o brit�nico/franc�s que vem no formato: dd/mm/aaaa

SELECT TRY_CONVERT(TINYINT, @DT) TEST_TRYCCONVERT


