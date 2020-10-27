-- Joins
/* 
A cláusula JOIN é utilizada para realizar a combinação das tabelas do banco de dados.
Toda essa combinação é baseada no processo de modelagem do negócio. 
A ligação das tabelas é geralmente feita através dos campos de chave primária e de chave estrangeira.

Os JOINs possuem uma cláusula chamada ON, que é responsável por iniciar a combinação dos campos utilizados na junção.
Ou seja, através dessa cláusula ON eu vou ligar a chave primária da tabela A com a chave estrangeira da tabela B
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
STATUS_FUNC VARCHAR (20) CHECK (STATUS_FUNC IN ('ATIVO','INATIVO','FERIAS','LICENÇA','INSS')),
CODDEPTO INT FOREIGN KEY REFERENCES DEPARTAMENTO (CODIGO),
CODSUPERVISOR INT FOREIGN KEY REFERENCES FUNCIONARIO (MATRICULA),
CODFUNCAO INT FOREIGN KEY REFERENCES FUNCAO (CODIGO))
GO

INSERT INTO DEPARTAMENTO
VALUES ('TECNOLOGIA DA INFORMACAO'),
('RECURSOS HUMANOS'),
('JURIDICO'),('SELEÇÃO'),
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
('JULIANA MARIA DOS SANTOS', '2002-01-01','12345678918', 2000, '2017-05-01',NULL,NULL,NULL, 'LICENÇA', 5, NULL, 2 ),
('MARIA ALICIA', '2001-01-01','12345678919', 950, '2018-05-01',NULL,NULL,NULL, 'ATIVO', 1, 6, 1)
GO

INSERT INTO FUNCIONARIO (NOME, DATANASCIMENTO,CPF, SALARIO,STATUS_FUNC, CODDEPTO,CODSUPERVISOR,CODFUNCAO)
VALUES ('MARIA ALICIA', '2003-09-18','12345678920', 950, 'ATIVO', NULL, NULL,1)

SELECT * FROM DEPARTAMENTO
SELECT * FROM FUNCAO
SELECT * FROM FUNCIONARIO



-- INNER JOIN 
-- Retorna linhas quando há uma correspondência em ambas as tabelas. É a intersecção entre as tabelas.
-- Somente exibe o que é correspondente entre a tabela A e a tabela B.

SELECT				-- Só retorna funcinários que tem departamento e departamentos que tem funcionário(s).
	F.NOME,			-- Não retorna uma das Marias Alicia(10), pois o Departamento dela é nulo. E não retorna o Departamento Seleção(4), pois esse departamento não tem funcionário.
	D.DESCRICAO
FROM FUNCIONARIO AS F
	INNER JOIN DEPARTAMENTO AS D
		ON F.CODDEPTO = D.CODIGO

SELECT						-- Você pode fazer mais de uma vinculação.
	F.NOME AS FUNCIONARIO,			
	D.DESCRICAO AS DEPARTAMENTO,
	FUN.DESCRICAO AS FUNCAO
FROM FUNCIONARIO AS F	-- ESQUERDA
	INNER JOIN DEPARTAMENTO AS D	-- DIREITA (em relação a Funcionário) e ESQUERDA (em relação a Função)
		ON F.CODDEPTO = D.CODIGO
	INNER JOIN FUNCAO AS FUN	-- DIREITA
		ON F.CODFUNCAO = FUN.CODIGO

		

-- LEFT JOIN ou LEFT OUTER JOIN 
-- Retorna todas as linhas da tabela da esquerda (tabela de cima), mesmo se não houver nenhuma correspondência na tabela da direita (tabela de baixo). 
-- Exibe todas as linhas da tabela A que tenham ou não correspondente com a tabela B.

SELECT			-- Traz todos os Funcionários que tenham ou não relação com Departamento.
	F.NOME,
	D.DESCRICAO
FROM FUNCIONARIO as F	-- ESQUERDA
	LEFT JOIN DEPARTAMENTO as D		-- DIREITA
		ON F.CODDEPTO = D.CODIGO


SELECT			-- Traz todos os Departamentos que tenham ou não relação com Funcionário.
	F.NOME,
	D.DESCRICAO
FROM DEPARTAMENTO AS D
	LEFT JOIN FUNCIONARIO AS F
		ON F.CODDEPTO = D.CODIGO

-- Left Join Exclusivo

SELECT			-- Exibe somente registros de Funcionário que NÃO possuem correspondência com Departamento.
	F.CODDEPTO,
	F.NOME,
	D.CODIGO,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	LEFT JOIN DEPARTAMENTO AS D
		ON F.CODDEPTO = D.CODIGO
		WHERE D.CODIGO IS NULL



-- RIGHT JOIN ou RIGHT OUTER JOIN 
-- Retorna todas as linhas da tabela da direita (tabela de baixo), mesmo que não haja correspondências na tabela da esquerda (tabela de cima). 
-- Exibe todas as linhas da tabela B que tenham ou não correspondente com a tabela A

SELECT		-- Traz todos os Departamentos que tenham ou não relação com Funcionário.
	F.NOME,
	D.DESCRICAO
FROM FUNCIONARIO AS F	-- ESQUERDA
	RIGHT JOIN DEPARTAMENTO AS D	-- DIREITA
ON F.CODDEPTO = D.CODIGO


-- Left Join Exclusivo

SELECT			-- Exibe somente registros de Departamento que NÃO possuem correspondência com Funcionário.
	F.CODDEPTO,
	F.NOME,
	D.CODIGO,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	RIGHT JOIN DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO
WHERE F.CODDEPTO IS NULL



-- FULL JOIN ou FULL OUTER JOIN 
-- Combina os resultados da esquerda e da direita. A tabela conterá todos os registros de ambas as tabelas.
-- Caso uma linha de dados não esteja associada a qualquer linha da outra tabela, esse valores serão mostrados como nulos.

SELECT				-- Exibe os Funcionários que tem Departamento e os Departamentos que tem Funcionário, assim como os Funcionários que não tem Departamento e os Departamentos que não tem Funcionário. 
	F.NOME,
	D.DESCRICAO
FROM FUNCIONARIO AS F
	FULL JOIN DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO


-- Full Join Exclusivo

SELECT				-- Exibe os registros de Funcionário e de Departamento que NÃO possuem correspondência de chave. Ou seja, Funcionários que não tem Departamento e Departamentos que não tem Funcionários.
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
-- Este tipo de JOIN não utiliza a clausula ON. Ele faz uma multiplicação dos registros de uma tabela com a outra.
-- EX.: Se na Tabela A tiver 10 registros e na Tabbela B tiver 7 registros, ele vai retornar 70 registros.

SELECT			-- Ele vai pegar cada Funcionário e vai vincular ao primeiro Departamento, depois vai vincular ao segundo Departamento, e assim sucessivamente.
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
-- É um CONCEITO de join e não um comando propriamente dito. 
-- Ele é caracterizado na modelagem como auto relacionamento, ou seja, a tabela se relacionando com ela mesma. 
-- Pode ser utilizado em qualquer tipo de JOIN (INNER, LEFT, RIGHT, FULL, CROSS).

SELECT		-- Traz todos os Funcionários que tem Supervisor.
	F.MATRICULA,
	F.NOME AS FUNCIONARIO,
	F.CODSUPERVISOR,
	S.MATRICULA,
	S.NOME AS SUPERVISOR
FROM FUNCIONARIO AS F	
	INNER JOIN FUNCIONARIO AS S
ON F.CODSUPERVISOR = S.MATRICULA


SELECT		-- Traz todos os Funcionários que tem ou não Supervisor.
	F.MATRICULA,
	F.NOME AS FUNCIONARIO,
	F.CODSUPERVISOR,
	S.MATRICULA,
	S.NOME AS SUPERVISOR
FROM FUNCIONARIO AS F	
	LEFT JOIN FUNCIONARIO AS S
ON F.CODSUPERVISOR = S.MATRICULA
