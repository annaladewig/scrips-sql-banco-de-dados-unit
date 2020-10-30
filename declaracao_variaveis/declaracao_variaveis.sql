-- Declara��o de Vari�veis

/*
Para declarar vari�veis no SQL Server deve se seguir algumas condi��es:

Primeiro: Utilizar a palavra reservada DECLARE

Segundo: O nome da vari�vel � composto do Arroba + nome = @nome

Terceiro: Tipo da vari�vel (int, varchar, date)

Quarto: O valor que a vari�vel ir� receber deve ser declarado com a palavra reservada SET @nome valor 

Obs.: O @ � uma vari�vel local, ou seja, � uma vari�vel que funciona apenas naquela query.
*/

DECLARE @NOME VARCHAR(20)		-- Maneira 1 de declarar uma vari�vel e atribuir um valor.
SET @NOME = 'CURSO MTA DBF'		

SELECT @NOME	-- Exibe o valor de uma vari�vel. 

-- Obs.: Para executar o select, tem que selecionar com a declara��o da vari�vel.

DECLARE @NOME2 VARCHAR(20) = 'CURSO MTA DBF'	-- Maneira 2 de declarar uma vari�vel e atribuir um valor.
	
SELECT @NOME2


DECLARE @TABELA TABLE	-- Voc� pode declarar uma vari�vel do tipo tabela. Assim d� para simular uma tabela em uma vari�vel.
(
MATRICULA TINYINT IDENTITY,
NOME VARCHAR(20),
NOTA NUMERIC (5,2)
)

INSERT INTO @TABELA (NOME, NOTA)
VALUES ('ELISA', 10), ('LUCAS', 9.5)

SELECT * FROM @TABELA

-- D� para, por exemplo, voc� fazer um filtro da sua tabela a partir de uma vari�vel.
/*
DECLARE @VALOR FLOAT
SET @VALOR = 2500.00

SELECT * 
FROM FUNCIONARIO
WHERE SALARIO > @VALOR
*/