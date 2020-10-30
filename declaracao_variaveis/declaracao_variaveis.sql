-- Declaração de Variáveis

/*
Para declarar variáveis no SQL Server deve se seguir algumas condições:

Primeiro: Utilizar a palavra reservada DECLARE

Segundo: O nome da variável é composto do Arroba + nome = @nome

Terceiro: Tipo da variável (int, varchar, date)

Quarto: O valor que a variável irá receber deve ser declarado com a palavra reservada SET @nome valor 

Obs.: O @ é uma variável local, ou seja, é uma variável que funciona apenas naquela query.
*/

DECLARE @NOME VARCHAR(20)		-- Maneira 1 de declarar uma variável e atribuir um valor.
SET @NOME = 'CURSO MTA DBF'		

SELECT @NOME	-- Exibe o valor de uma variável. 

-- Obs.: Para executar o select, tem que selecionar com a declaração da variável.

DECLARE @NOME2 VARCHAR(20) = 'CURSO MTA DBF'	-- Maneira 2 de declarar uma variável e atribuir um valor.
	
SELECT @NOME2


DECLARE @TABELA TABLE	-- Você pode declarar uma variável do tipo tabela. Assim dá para simular uma tabela em uma variável.
(
MATRICULA TINYINT IDENTITY,
NOME VARCHAR(20),
NOTA NUMERIC (5,2)
)

INSERT INTO @TABELA (NOME, NOTA)
VALUES ('ELISA', 10), ('LUCAS', 9.5)

SELECT * FROM @TABELA

-- Dá para, por exemplo, você fazer um filtro da sua tabela a partir de uma variável.
/*
DECLARE @VALOR FLOAT
SET @VALOR = 2500.00

SELECT * 
FROM FUNCIONARIO
WHERE SALARIO > @VALOR
*/