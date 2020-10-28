-- UNIÃO DE CONSULTAS

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

INSERT INTO A VALUES (1,'José'), (2,'Maria'), (3,'João')
INSERT INTO B VALUES (2,'Maria'), (3,'Guilherme'), (4,'Vitória')
INSERT INTO C VALUES (5,'Ana','Ativo'), (6,'Pedro','Inativo'), (7,'João','Ativo'), (8,'Joana','Inativo')

SELECT * FROM A
SELECT * FROM B

-- UNION
/*
UNION / UNION ALL 
Cria um único conjunto de resultados baseado na união de varias consultas.
Ou seja, você consegue unir duas ou mais consultas diferentes.

Requisitos para utilização do Union:

- As duas consultas devem conter o mesmo número de colunas;
	(Ou seja, se tiver um número diferente de colunas, na tabela que tem menos colunas vai ter que ser feita uma simulação de colunas, para poder usar o UNION.)
- Os tipos de dados devem corresponder para cada coluna;
- A cláusula ORDER BY deve sempre ser utilizada apenas no último SELECT a ser feito;
- A primeira consulta é o cabeçalho do resultado;
	(Ou seja, é a primeira consulta que vai definir o ALIAS.)


Principal diferença entre o UNION e o UNION ALL:

UNION - Remove qualquer linha duplicada no conjunto de resultados. Ele possui um DISTINCT implícito.

UNION ALL - Inclui os registros duplicados.

*/

	SELECT coluna1, coluna2 FROM TABELA1
	UNION / UNION ALL
	SELECT coluna1, coluna2 FROM TABELA2

-- UNION
SELECT ID, NOME FROM A	-- Vai unir o resultado das duas consultas, só que ele vai remover as duplicatas.
UNION
SELECT ID, NOME FROM B

-- Obs.: Ele verifica a duplicidade coluna a coluna, então todas os campos tem que ser iguais. Basta um campo ser diferente para não ser uma duplicata. 
-- Note que ele não trouxe Maria, pois o nome e o ID eram iguais, mas ele trouxe o ID 3 duas vezes, pois os nomes são diferentes. 

-- UNION ALL
SELECT ID, NOME FROM A
UNION ALL
SELECT ID, NOME FROM B

-- E se o número de colunas for diferente?

SELECT ID, NOME FROM A		-- Vai dar erro.
UNION 
SELECT ID, NOME, STATUS FROM C

SELECT ID, NOME, NULL AS STATUS FROM A	-- Agora vai passar. Lembrando que a primeira consulta é a que define o cabeçalho.
UNION 
SELECT ID, NOME, STATUS FROM C


-- EXCEPT 
-- Realiza a diferença dos conjuntos A,B (A - B), ou seja, o conjunto de elementos que pertencem a A e não pertencem a B.
-- Ele opera nos conjuntos de resultados de duas consultas de entrada e retorna as linhas que aparecem na primeira entrada, mas não na segunda, ou seja, quando se quer que apareçam os registros da tabela A que não são iguais aos da tabela B.
-- O EXCEPT utiliza a mesma regra do UNION referente ao número de campos, cabeçalho e tipo de dado.

	SELECT coluna 1 coluna 2 FROM TABELA 1
	EXCEPT
	SELECT coluna 1 coluna 2 FROM TABELA 2

SELECT ID, NOME FROM A	-- Retorna todo mundo de A que é diferente de B.
EXCEPT
SELECT ID, NOME FROM B

SELECT ID, NOME FROM B	-- Retorna todo mundo de B que é diferente de A.
EXCEPT
SELECT ID, NOME FROM A


-- INTERSECT
-- INTERSECT retorna apenas linhas que são comuns a ambos os conjuntos.
-- Em outras palavras, se uma linha aparecer pelo menos uma vez no primeiro conjunto e pelo menos uma vez no segundo conjunto, ela aparecerá uma vez no resultado do operador INTERSECT.
-- O INTERSECT utiliza a mesma regra do UNION referente ao número de campos, cabeçalho e tipo de dado.

	SELECT coluna 1 coluna 2 FROM TABELA 1
	INTERSECT
	SELECT coluna 1 coluna 2 FROM TABELA 2

SELECT ID, NOME FROM A
INTERSECT
SELECT ID, NOME FROM B
