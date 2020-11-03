-- Funções de Conversão de dados
/*
Funções de conversão são utilizadas quando precisamos transformar um tipo de dados em outro.

Conversão implícita: É quando um determinado tipo de dado é convertido sem a utilização das funções de conversão.
	Na conversão implícita utiliza a precedência de tipos de dados:
	A precedência do tipo de dados determina qual tipo de dado será escolhido quando expressões de tipos diferentes forem combinadas.
	Obs1.: Por padrão, o tipo de dado com a precedência mais baixa é convertido no tipo de dados com a precedência mais alta. 
	Obs2.: A conversão para um tipo de dado de menor precedência deve ser explicitada.

	Exemplo de precedência (da mais baixa para a mais alta)
	- Texto -> Números -> Data -> XML
	- char -> varchar -> nvarchar -> tinyint -> int -> decimal -> hora -> data -> datetime2 -> xml
		Ex.: 10 + 2.20. Ele converte o tipo inteiro para decimal.
	Nem todas as combinações de tipos de dados têm uma conversão.

Conversão explicita: É necessário a utilização das funções CAST e CONVERT para alterar o tipo do dado.


CAST: Função de conversão Padrão ANSI (ou seja, funciona em qualquer SGBD).
	Obs.: O CAST é mais performático do que a função CONVERT (Por ser padrão ANSI, a performance dele é melhor).

TRY_CAST: Realiza o tratamento do dado, retornando o valor NULL, quando não consegue converter o valor para o tipo desejado. 
		 (Só funciona no SQL Server.)

Ambos (CAST E TRY_CAST) recebem 2 parâmetros:
	- Primeiro parâmetro: campo a ser convertido
	- Segundo parâmetro: tipo de dado para qual será convertido o campo.
*/

	CAST (campo AS novo_tipo)	-- Esse "campo" pode ser o campo de uma tabela.
	TRY_CAST (campo AS novo_tipo)	-- Esse "campo" pode ser o campo de uma tabela.

DECLARE @DT DATETIME
SET @DT = GETDATE()

SELECT @DT

SELECT CAST(@DT AS DATE) TEST_CAST	-- Converte de DATETIME para DATE, logo, vai trazer só a data.

SELECT TRY_CAST(@DT AS TINYINT) TEST_TRYCAST -- Retorna NULL porque não vai conseguir converter (porque data é um tipo mais forte que número).

-- No mesmo caso acima, como seria se tivesse sido usado o CAST?
SELECT CAST(@DT AS TINYINT) TEST_CAST -- Trava a aplicação, por isso é melhor usar o TRY_CAST. 

-- E se fosse a partir de uma tabela e não de uma variável?
SELECT CAST(DATA_VENDA AS DATE) TEST_CAST
FROM TB



/* 
CONVERT: O Convert é ideal para quando queremos converter de data para string, pois é possível passar a formatação que você quer que a data apareça.
		 A função CONVERT só funciona no SQL Server.

TRY_CONVERT: Realiza o tratamento dos dado, retornando o valor NULL, quando não consegue converter o valor para o tipo desejado.

Ambas podem receber 2 ou 3 parâmetros:
	Primeiro parâmetro: tipo de dado para qual será convertido o campo.
	Segundo parâmetro: campo que será convertido.
	Terceiro parâmetro: Opcional, utilizado para formatação de campos de data.
*/

	CONVERT(TIPO_DE_DADO, campo, formatacao_data(opcional))	-- Esse "campo" pode ser o campo de uma tabela.
	TRY_CONVERT(TIPO_DE_DADO, campo, formatacao_data(opcional)) -- Esse "campo" pode ser o campo de uma tabela.

DECLARE @DT DATETIME
SET @DT = GETDATE()

SELECT CONVERT(DATE, @DT) TEST_CONVERT

SELECT CONVERT(VARCHAR(10), @DT, 103) TEST_CONVERT_DT
-- Esse 103 significa padrão britânico/francês que vem no formato: dd/mm/aaaa

SELECT TRY_CONVERT(TINYINT, @DT) TEST_TRYCCONVERT


