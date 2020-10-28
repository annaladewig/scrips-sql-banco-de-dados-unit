-- UNI�O DE CONSULTAS

CREATE
DATABASE BD_UNIAO_CONSULTAS
GO

USE
BD_UNIAO_CONSULTAS
GO

CREATE
TABLE A(
ID INT NOT NULL,
NOME VARCHAR(10) NOT NULL)

CREATE
TABLE B(
ID INT NOT NULL,
NOME VARCHAR(10) NOT NULL)

CREATE
TABLE C(
ID INT NOT NULL,
NOME VARCHAR(10) NOT NULL,
STATUS VARCHAR(7) NOT NULL CHECK (STATUS IN ('Ativo', 'Inativo')))

INSERT INTO A VALUES (1,'Jos�'), (2,'Maria'), (3,'Jo�o')
INSERT INTO B VALUES (2,'Maria'), (3,'Guilherme'), (4,'Vit�ria')
INSERT INTO C VALUES (5,'Ana','Ativo'), (6,'Pedro','Inativo'), (7,'Jo�o','Ativo'), (8,'Joana','Inativo')

SELECT * FROM A
SELECT * FROM B

-- UNION
/*
UNION / UNION ALL 
Cria um �nico conjunto de resultados baseado na uni�o de varias consultas.
Ou seja, voc� consegue unir duas ou mais consultas diferentes.

Requisitos para utiliza��o do Union:

- As duas consultas devem conter o mesmo n�mero de colunas;
	(Ou seja, se tiver um n�mero diferente de colunas, na tabela que tem menos colunas vai ter que ser feita uma simula��o de colunas, para poder usar o UNION.)
- Os tipos de dados devem corresponder para cada coluna;
- A cl�usula ORDER BY deve sempre ser utilizada apenas no �ltimo SELECT a ser feito;
- A primeira consulta � o cabe�alho do resultado;
	(Ou seja, � a primeira consulta que vai definir o ALIAS.)


Principal diferen�a entre o UNION e o UNION ALL:

UNION - Remove qualquer linha duplicada no conjunto de resultados. Ele possui um DISTINCT impl�cito.

UNION ALL - Inclui os registros duplicados.

*/

	SELECT coluna1, coluna2 FROM TABELA1
	UNION / UNION ALL
	SELECT coluna1, coluna2 FROM TABELA2

-- UNION
SELECT ID, NOME FROM A	-- Vai unir o resultado das duas consultas, s� que ele vai remover as duplicatas.
UNION
SELECT ID, NOME FROM B

-- Obs.: Ele verifica a duplicidade coluna a coluna, ent�o todas os campos tem que ser iguais. Basta um campo ser diferente para n�o ser uma duplicata. 
-- Note que ele n�o trouxe Maria, pois o nome e o ID eram iguais, mas ele trouxe o ID 3 duas vezes, pois os nomes s�o diferentes. 

-- UNION ALL
SELECT ID, NOME FROM A
UNION ALL
SELECT ID, NOME FROM B

-- E se o n�mero de colunas for diferente?

SELECT ID, NOME FROM A		-- Vai dar erro.
UNION 
SELECT ID, NOME, STATUS FROM C

SELECT ID, NOME, NULL AS STATUS FROM A	-- Agora vai passar. Lembrando que a primeira consulta � a que define o cabe�alho.
UNION 
SELECT ID, NOME, STATUS FROM C


-- EXCEPT 
-- Realiza a diferen�a dos conjuntos A,B (A - B), ou seja, o conjunto de elementos que pertencem a A e n�o pertencem a B.
-- Ele opera nos conjuntos de resultados de duas consultas de entrada e retorna as linhas que aparecem na primeira entrada, mas n�o na segunda, ou seja, quando se quer que apare�am os registros da tabela A que n�o s�o iguais aos da tabela B.
-- O EXCEPT utiliza a mesma regra do UNION referente ao n�mero de campos, cabe�alho e tipo de dado.

	SELECT coluna 1 coluna 2 FROM TABELA 1
	EXCEPT
	SELECT coluna 1 coluna 2 FROM TABELA 2

SELECT ID, NOME FROM A	-- Retorna todo mundo de A que � diferente de B.
EXCEPT
SELECT ID, NOME FROM B

SELECT ID, NOME FROM B	-- Retorna todo mundo de B que � diferente de A.
EXCEPT
SELECT ID, NOME FROM A


-- INTERSECT
-- INTERSECT retorna apenas linhas que s�o comuns a ambos os conjuntos.
-- Em outras palavras, se uma linha aparecer pelo menos uma vez no primeiro conjunto e pelo menos uma vez no segundo conjunto, ela aparecer� uma vez no resultado do operador INTERSECT.
-- O INTERSECT utiliza a mesma regra do UNION referente ao n�mero de campos, cabe�alho e tipo de dado.

	SELECT coluna 1 coluna 2 FROM TABELA 1
	INTERSECT
	SELECT coluna 1 coluna 2 FROM TABELA 2

SELECT ID, NOME FROM A
INTERSECT
SELECT ID, NOME FROM B
