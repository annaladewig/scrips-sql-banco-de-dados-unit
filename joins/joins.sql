-- Joins
/* 
A cl�usula JOIN � utilizada para realizar a combina��o das tabelas do banco de dados.
Toda essa combina��o � baseada no processo de modelagem do neg�cio. 
A liga��o das tabelas � geralmente feita atrav�s dos campos de chave prim�ria e de chave estrangeira.

Os JOINs possuem uma cl�usula chamada ON, que � respons�vel por iniciar a combina��o dos campos utilizados na jun��o.
Ou seja, atrav�s dessa cl�usula ON eu vou ligar a chave prim�ria da tabela A com a chave estrangeira da tabela B
*/


CREATE DATABASE BD_JOINS
GO

USE BD_JOINS
GO

CREATE TABLE DEPARTAMENTO (
CODIGO INT PRIMARY KEY IDENTITY,
DESCRICAO VARCHAR(100) NOT NULL);
GO

CREATE TABLE FUNCAO (
CODIGO INT PRIMARY KEY IDENTITY,
DESCRICAO VARCHAR(100))
GO

CREATE TABLE FUNCIONARIO(
MATRICULA INT PRIMARY KEY IDENTITY,
NOME VARCHAR (255) NOT NULL,
DATANASCIMENTO DATE NOT NULL,
CPF CHAR(11) UNIQUE CHECK (LEN(CPF) = 11),
SALARIO MONEY NULL,
DATAADMISSAO DATE DEFAULT (GETDATE()),
DATADEMISSAO DATE NULL,
INICIOFERIAS DATE NULL,
FIMFERIAS DATE NULL,
STATUS_FUNC VARCHAR (20) CHECK (STATUS_FUNC IN ('ATIVO','INATIVO','FERIAS','LICEN�A','INSS')),
CODDEPTO INT FOREIGN KEY REFERENCES DEPARTAMENTO (CODIGO),
CODSUPERVISOR INT FOREIGN KEY REFERENCES FUNCIONARIO (MATRICULA),
CODFUNCAO INT FOREIGN KEY REFERENCES FUNCAO (CODIGO))
GO

INSERT INTO DEPARTAMENTO
VALUES ('TECNOLOGIA DA INFORMACAO'),
('RECURSOS HUMANOS'),
('JURIDICO'),('SELE��O'),
('CONTABILIDADE'),
('CONTAS A PAGAR E RECEBER'),
('DEPARTAMENTO PESSOAL')
GO

INSERT INTO FUNCAO
VALUES ('ESTAGIARIO'), ('ANALISTA JR'),('ANALISTA PL'),('ANALISTA SR'),('COORDENADOR'),('GERENTE')
GO

INSERT INTO FUNCIONARIO (NOME, DATANASCIMENTO,CPF, SALARIO,DATAADMISSAO,DATADEMISSAO,INICIOFERIAS,FIMFERIAS, STATUS_FUNC, CODDEPTO, CODSUPERVISOR, CODFUNCAO)
VALUES ('ANA MARIA', '2000-01-01','12345678911', 1200.55, '2018-05-01',NULL,NULL,NULL, 'ATIVO', 1, 6, 2 ),
('JOSE HENRIQUE', '1998-11-20','12345678912', 2575.55, '2005-09-01','2017-12-01',NULL,NULL, 'INATIVO', 7, NULL, 3 ),
('ANA MARIA', '2002-08-21','12345678913', 950.00, '2019-01-01',NULL,NULL,NULL, 'ATIVO', 6, NULL, 1),
('LUAN FELIX', '1991-09-28','12345678914', 3500.00, '2013-04-01',NULL,NULL,NULL, 'ATIVO', 3,NULL,2),
('FELIPE JOSE DOS SANTOS', '1996-01-11','12345678915', 4000, '2011-05-01','2015-01-29',NULL,NULL, 'INATIVO', 2, NULL, 3),
('MARCELO JOSE', '1980-10-05','12345678916', 7000, '2000-05-01',NULL,'2019-05-01','2019-06-01', 'ATIVO', 1, NULL, 1),
('MARIANA MARIA', '1987-02-08','12345678917', 4500, '2010-01-01',NULL,NULL,NULL, 'INSS', 1, 6, 3 ),
('JULIANA MARIA DOS SANTOS', '2002-01-01','12345678918', 2000, '2017-05-01',NULL,NULL,NULL, 'LICEN�A', 5, NULL, 2 ),
('MARIA ALICIA', '2001-01-01','12345678919', 950, '2018-05-01',NULL,NULL,NULL, 'ATIVO', 1, 6, 1)
GO

INSERT INTO FUNCIONARIO (NOME, DATANASCIMENTO,CPF, SALARIO,STATUS_FUNC, CODDEPTO,CODSUPERVISOR,CODFUNCAO)
VALUES ('MARIA ALICIA', '2003-09-18','12345678920', 950, 'ATIVO', NULL, NULL,1)

SELECT * FROM DEPARTAMENTO
SELECT * FROM FUNCAO
SELECT * FROM FUNCIONARIO



-- INNER JOIN 
-- Retorna linhas quando h� uma correspond�ncia em ambas as tabelas. � a intersec��o entre as tabelas.
-- Somente exibe o que � correspondente entre a tabela A e a tabela B.

SELECT				-- S� retorna funcin�rios que tem departamento e departamentos que tem funcion�rio(s).
	F.NOME,			-- N�o retorna uma das Marias Alicia(10), pois o Departamento dela � nulo. E n�o retorna o Departamento Sele��o(4), pois esse departamento n�o tem funcion�rio.
	D.DESCRICAO
FROM FUNCIONARIO AS F
	INNER JOIN DEPARTAMENTO AS D
		ON F.CODDEPTO = D.CODIGO

SELECT						-- Voc� pode fazer mais de uma vincula��o.
	F.NOME AS FUNCIONARIO,			
	D.DESCRICAO AS DEPARTAMENTO,
	FUN.DESCRICAO AS FUNCAO
FROM FUNCIONARIO AS F	-- ESQUERDA
	INNER JOIN DEPARTAMENTO AS D	-- DIREITA (em rela��o a Funcion�rio) e ESQUERDA (em rela��o a Fun��o)
		ON F.CODDEPTO = D.CODIGO
	INNER JOIN FUNCAO AS FUN	-- DIREITA
		ON F.CODFUNCAO = FUN.CODIGO

		

-- LEFT JOIN ou LEFT OUTER JOIN 
-- Retorna todas as linhas da tabela da esquerda (tabela de cima), mesmo se n�o houver nenhuma correspond�ncia na tabela da direita (tabela de baixo). 
-- Exibe todas as linhas da tabela A que tenham ou n�o correspondente com a tabela B.

SELECT			-- Traz todos os Funcion�rios que tenham ou n�o rela��o com Departamento.
	F.NOME,
	D.DESCRICAO
FROM FUNCIONARIO as F	-- ESQUERDA
	LEFT JOIN DEPARTAMENTO as D		-- DIREITA
		ON F.CODDEPTO = D.CODIGO


SELECT			-- Traz todos os Departamentos que tenham ou n�o rela��o com Funcion�rio.
	F.NOME,
	D.DESCRICAO
FROM DEPARTAMENTO AS D
	LEFT JOIN FUNCIONARIO AS F
		ON F.CODDEPTO = D.CODIGO

-- Left Join Exclusivo

SELECT			-- Exibe somente registros de Funcion�rio que N�O possuem correspond�ncia com Departamento.
	F.CODDEPTO,
	F.NOME,
	D.CODIGO,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	LEFT JOIN DEPARTAMENTO AS D
		ON F.CODDEPTO = D.CODIGO
		WHERE D.CODIGO IS NULL



-- RIGHT JOIN ou RIGHT OUTER JOIN 
-- Retorna todas as linhas da tabela da direita (tabela de baixo), mesmo que n�o haja correspond�ncias na tabela da esquerda (tabela de cima). 
-- Exibe todas as linhas da tabela B que tenham ou n�o correspondente com a tabela A

SELECT		-- Traz todos os Departamentos que tenham ou n�o rela��o com Funcion�rio.
	F.NOME,
	D.DESCRICAO
FROM FUNCIONARIO AS F	-- ESQUERDA
	RIGHT JOIN DEPARTAMENTO AS D	-- DIREITA
ON F.CODDEPTO = D.CODIGO


-- Left Join Exclusivo

SELECT			-- Exibe somente registros de Departamento que N�O possuem correspond�ncia com Funcion�rio.
	F.CODDEPTO,
	F.NOME,
	D.CODIGO,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	RIGHT JOIN DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO
WHERE F.CODDEPTO IS NULL



-- FULL JOIN ou FULL OUTER JOIN 
-- Combina os resultados da esquerda e da direita. A tabela conter� todos os registros de ambas as tabelas.
-- Caso uma linha de dados n�o esteja associada a qualquer linha da outra tabela, esse valores ser�o mostrados como nulos.

SELECT				-- Exibe os Funcion�rios que tem Departamento e os Departamentos que tem Funcion�rio, assim como os Funcion�rios que n�o tem Departamento e os Departamentos que n�o tem Funcion�rio. 
	F.NOME,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	FULL JOIN DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO


-- Full Join Exclusivo

SELECT				-- Exibe os registros de Funcion�rio e de Departamento que N�O possuem correspond�ncia de chave. Ou seja, Funcion�rios que n�o tem Departamento e Departamentos que n�o tem Funcion�rios.
	F.CODDEPTO,
	F.NOME,
	D.CODIGO,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	FULL JOIN DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO
WHERE F.CODDEPTO IS NULL OR D.CODIGO IS NULL



-- CROSS JOIN 
-- Combina os dados das duas tabelas formando um produto cartesiano. 
-- Este tipo de JOIN n�o utiliza a clausula ON. Ele faz uma multiplica��o dos registros de uma tabela com a outra.
-- EX.: Se na Tabela A tiver 10 registros e na Tabbela B tiver 7 registros, ele vai retornar 70 registros.

SELECT			-- Ele vai pegar cada Funcion�rio e vai vincular ao primeiro Departamento, depois vai vincular ao segundo Departamento, e assim sucessivamente.
	F.NOME,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	CROSS JOIN DEPARTAMENTO AS D

SELECT
	F.NOME,
	FUN.DESCRICAO
FROM FUNCIONARIO AS F
	CROSS JOIN FUNCAO AS FUN



-- SELF JOIN 
-- � um CONCEITO de join e n�o um comando propriamente dito. 
-- Ele � caracterizado na modelagem como auto relacionamento, ou seja, a tabela se relacionando com ela mesma. 
-- Pode ser utilizado em qualquer tipo de JOIN (INNER, LEFT, RIGHT, FULL, CROSS).

SELECT		-- Traz todos os Funcion�rios que tem Supervisor.
	F.MATRICULA,
	F.NOME AS FUNCIONARIO,
	F.CODSUPERVISOR,
	S.MATRICULA,
	S.NOME AS SUPERVISOR
FROM FUNCIONARIO AS F	
	INNER JOIN FUNCIONARIO AS S
ON F.CODSUPERVISOR = S.MATRICULA


SELECT		-- Traz todos os Funcion�rios que tem ou n�o Supervisor.
	F.MATRICULA,
	F.NOME AS FUNCIONARIO,
	F.CODSUPERVISOR,
	S.MATRICULA,
	S.NOME AS SUPERVISOR
FROM FUNCIONARIO AS F	
	LEFT JOIN FUNCIONARIO AS S
ON F.CODSUPERVISOR = S.MATRICULA
