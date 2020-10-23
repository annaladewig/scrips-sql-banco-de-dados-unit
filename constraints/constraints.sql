-- CONSTRAINTS
-- A principal finalidade das restri��es de dom�nio � fazer com que os campos (ou atributos) da tabela n�o recebam qualquer tipo de dado e tenham um certo n�vel de valida��o no momento dos comandos DML.

CREATE DATABASE BD_CONSTRAINTS

USE BD_CONSTRAINTS


-- Primary Key (PK)
-- Restri��o que identifica o atributo como identificador da tabela. Ao definir um campo como PK, o SQL Server cria um �ndice clusterizado na tabela.

CREATE TABLE tb_pk (					-- Cria chave prim�ria, no inicio do comando, com constraint (� como se fosse um apelido para a constraint).
Cod INT CONSTRAINT pk_test PRIMARY KEY,
Nome VARCHAR(50)
)

CREATE TABLE tb_pk1 (					-- Cria chave prim�ria, no inicio do comando, sem constraint. Nesse caso, em Keys, o nome dessa chave fica hexadecimal.
Cod INT PRIMARY KEY,
Nome VARCHAR(50)
)

CREATE TABLE tb_pk2	(					-- Cria chave prim�ria no final do comando, ent�o, deve-se referenciar o campo entre par�nteses.
Cod INT,
Nome VARCHAR(50),
PRIMARY KEY(Cod)
)

INSERT INTO tb_pk (Cod, Nome)
VALUES (1, 'LINHA 1'),
(2, 'LINHA 2')

INSERT INTO tb_pk (Cod, Nome)			-- Vai apresentar erro, pois o cod 2 j� existe e a chave prim�ria � �nica.
VALUES (2,'LINHA 3')


SELECT * FROM tb_pk 


CREATE TABLE tb_pk3(					-- Cria tabela com duas chaves primarias (chave composta)
Cod INT,
Cod2 INT,
nome VARCHAR(50),
PRIMARY KEY (Cod, Cod2)
)

INSERT INTO tb_pk3 (Cod, Cod2, Nome)
VALUES (1, 55,'LINHA 1')

SELECT * FROM tb_pk3

CREATE TABLE tb_pk4(
Cod INT NOT NULL,
Nome VARCHAR(50)
)

ALTER TABLE tb_pk4						-- Adiciona chave prim�ria, ap�s cria��o de uma tabela sem PK.
ADD PRIMARY KEY(Cod)
-- Obs.: Nesses casos, a coluna que vai receber a constraint PK, deve ter sido criada como NOT NULL.

CREATE TABLE tb_pk5(
Cod INT NOT NULL,
Nome VARCHAR(50)
)

ALTER TABLE tb_pk5						-- Adiciona chave prim�ria, ap�s cria��o de uma tabela sem pk, informando o nome da constraint
ADD CONSTRAINT pk_test1
PRIMARY KEY(cod)


ALTER TABLE tb_pk5						-- Apaga uma constraint PK. Se voc� colocou a apelido, apaga pelo apelido, sen�o, apaga pelo hexadecimal que foi gerado.
DROP CONSTRAINT pk_test1

ALTER TABLE tb_pk4						
DROP CONSTRAINT PK__tb_pk4__C1FE6AA9F064E8DF   



-- Foreign Key (FK)
-- Restri��o que define que um atributo A faz refer�ncia ao atributo B que � chave de outra tabela
-- Obs1.: Para a chave estrangeira funcionar, a tabela que cont�m o atributo chave deve ser criada primeiro.
-- Obs2.: O atributo (FK) deve fazer refer�ncia a qual atributo da tabela de origem ele faz correla��o. Para um registro ser referenciado na tabela com a FK, o registro tem que existir na tabela de origem.

CREATE TABLE tb_fk_marca (
Cod INT PRIMARY KEY IDENTITY,
Nome VARCHAR(50)
)

CREATE TABLE tb_fk_carro (			-- Cria chave estrangeira na cria��o da tabela
Placa varchar (7) PRIMARY KEY,
Modelo VARCHAR(50),
cod_marca INT FOREIGN KEY REFERENCES tb_fk_marca(Cod)
)

INSERT INTO tb_fk_marca (Nome)
VALUES ('Fiat'), ('Chevrolet'), ('Toyota'), ('Hyundai'), ('Honda'), ('Nissan') 

SELECT * FROM tb_fk_marca

INSERT INTO tb_fk_carro (Placa, Modelo, cod_marca)
VALUES ('PLA0001', 'ONIX', 2),
('PLA0002', 'Argo', 1),
('PLA0003', 'Civic', 5),
('PLA0004', 'Versa', 6),
('PLA0005', 'Kicks', 6)

SELECT * FROM tb_fk_marca
SELECT * FROM tb_fk_carro

INSERT INTO tb_fk_carro (Placa, Modelo, cod_marca)  -- D� erro, pois esse c�digo n�o existe na origem.
VALUES ('PLA0006', 'ONIX SEDAN', 7)


CREATE TABLE tb_fk_carro2 (			
Placa varchar (7) PRIMARY KEY,
Modelo VARCHAR(50),
cod_marca INT
)

ALTER TABLE tb_fk_carro2			-- Adiciona uma chave estrangeira ap�s a cria��o da tabela.
ADD FOREIGN KEY (cod_marca)
REFERENCES tb_fk_marca(Cod)


CREATE TABLE tb_fk_carro3 (			
Placa varchar (7) PRIMARY KEY,
Modelo VARCHAR(50),
fk_marca INT
)

ALTER TABLE tb_fk_carro3				-- Adiciona uma chave estrangeira, com constraint, ap�s a cria��o de tabela.
ADD CONSTRAINT fk_marca_carro
FOREIGN KEY (fk_marca) REFERENCES tb_fk_marca (cod)

ALTER TABLE tb_fk_carro3				-- Apaga a constraint, pelo nome da constraint. 
DROP CONSTRAINT fk_marca_carro


CREATE TABLE Aluno (
Matricula INT PRIMARY KEY,
Nome VARCHAR(20)
)

INSERT INTO Aluno (Matricula, Nome)
VALUES (100, 'Anna'), (101, 'Andr�')

CREATE TABLE Disciplina (
Cod_Disc CHAR(3) PRIMARY KEY,
Descricao VARCHAR(20)
)

INSERT INTO Disciplina(Cod_Disc, Descricao)
VALUES ('A23', 'L�gica'), ('A24', 'Orienta��o a Objetos'), ('A25', 'Banco de Dados')

SELECT * FROM Aluno
SELECT * FROM Disciplina

--Disciplina N x N Aluno (Relacionamento N para N gera uma nova tabela)
CREATE TABLE Aluno_Disciplina (						-- Cria foreing key em um relacionamento N x N
PK_Aluno_Disciplina INT PRIMARY KEY IDENTITY,
FK_Matricula INT FOREIGN KEY REFERENCES Aluno(Matricula),
FK_Cod_Disc CHAR(3) FOREIGN KEY REFERENCES Disciplina(Cod_Disc)
)

INSERT INTO Aluno_Disciplina(FK_Matricula, FK_Cod_Disc)
VALUES (100, 'A23'), (100, 'A24'), (101, 'A23'), (101, 'A25')

SELECT * FROM Aluno
SELECT * FROM Disciplina
SELECT * FROM Aluno_Disciplina



-- Unique
-- Restri��o que garante que o valor de um determinado campo n�o se repita dentro de uma tabela, ou seja, os valores ser�o �nicos. Ele cria um �ndice n�o clusterizado na tabela
-- Obs1.: A restri��o PRIMARY KEY possui uma restri��o UNIQUE impl�cita. Em uma tabela pode haver v�rias restri��es Unique, por�m s� pode conter uma PK.
-- Obs2.: A coluna com essa restri��o pode aceitar apenas um valor nulo (NULL).

CREATE TABLE tb_unique (		-- Cria tabela com a restri��o UNIQUE.
Cod INT PRIMARY KEY,
Nome VARCHAR(50),
CPF CHAR(11) UNIQUE
)

CREATE TABLE tb_unique1 (		-- Cria tabela com a restri��o UNIQUE, especificando o nome da constraint.
Cod INT PRIMARY KEY,
Nome VARCHAR(50),
CPF CHAR(11) CONSTRAINT UQ_CPF UNIQUE
)

INSERT INTO tb_unique1 (Cod, Nome, CPF)
VALUES(1, 'Licia', '11122233311'),
(2, 'Anna', '11122244423')

SELECT * FROM tb_unique1

INSERT INTO tb_unique1 (Cod, Nome, CPF)	 -- Vai dar erro porque esse CPF j� foi usado em L�cia.
VALUES(3, 'Raphael', '11122233311')


CREATE TABLE tb_unique2 (		
Cod INT PRIMARY KEY,
Nome VARCHAR(50),
Matricula INT,
CPF CHAR(11) 
)

ALTER TABLE tb_unique2			-- Adiciona o Unique em um campo j� criado.
ADD UNIQUE (Matricula)

ALTER TABLE tb_unique2			-- Adiciona o Unique em um campo j� criado, especificando o nome da constraint.
ADD CONSTRAINT UQ_CPF2 UNIQUE (cpf)

ALTER TABLE tb_unique2			-- Apaga uma constraint Unique.
DROP CONSTRAINT UQ_CPF2



-- Not Null
-- Not Null � a restri��o que impede a coluna de receber valores nulos no momento da inser��o ou atualiza��o
-- Obs1.: O SQL Server coloca como padr�o NULL quando n�o � informado nada sobre ser ou n�o Not Null.
-- Obs2.: Quando uma coluna recebe a restri��o Primary Key, ela � automaticamente NOT NULL.

CREATE TABLE tb_notnull (		-- Cria tabela com campos n�o nulos e campos nulos.
Cod INT PRIMARY KEY,
NOME VARCHAR(50) NOT NULL ,
DT DATE NULL
)

INSERT INTO tb_notnull (Cod, Nome, DT)
VALUES (1, 'Luiz', '1991-11-23')

INSERT INTO tb_notnull (Cod, Nome, DT)  -- Vai dar erro pois a coluna Nome � not null
VALUES (2, NULL, '1991-11-23')

ALTER TABLE tb_notnull			-- Coloca not null em um campo j� criado.
ALTER COLUMN DT DATE NOT NULL

ALTER TABLE tb_notnull			-- Remove o not null em um campo j� criado.
ALTER COLUMN DT DATE NULL



-- Default
-- Restri��o que coloca um valor como padr�o em uma determinada coluna.
-- Ao realizar um comando de Insert e o valor de um determinado campo n�o for informado, a restri��o Default ir� preencher o campo n�o informado com o valor padr�o definido pela Constraint.
-- Obs.: N�o � obrigat�rio informar o campo no momento no INSERT.

CREATE TABLE tb_default (		-- Cria tabela com a restri��o default.
Cod INT PRIMARY KEY IDENTITY,
Nome VARCHAR(50),
Data DATE DEFAULT (GETDATE()),
Valor SMALLMONEY DEFAULT(1000)
)

CREATE TABLE tb_default1 (		-- Cria tabela com a restri��o default, especificando o nome da constraint.
Cod INT PRIMARY KEY IDENTITY,
Nome VARCHAR(50),
Local VARCHAR(20),
Data DATE CONSTRAINT DF_DATA
DEFAULT (GETDATE()),
Valor SMALLMONEY CONSTRAINT DF_VALOR 
DEFAULT(1000)
)

ALTER TABLE tb_default1				-- Adiciona uma nova coluna com a restri��o default.
ADD Numero TINYINT DEFAULT(0)

ALTER TABLE tb_default1				-- Adiciona default em uma coluna j� criada.
ADD CONSTRAINT df_dt_insert
DEFAULT ('Brasil') FOR Local

INSERT INTO tb_default1 (Nome, Local, Data, Valor) 
VALUES ('Andr�', 'Canad�', '2020-09-25', 10)

INSERT INTO tb_default1 (Nome, Local, Valor) 
VALUES ('Cinara', 'Chile', 20)

INSERT INTO tb_default1 (Nome) 
VALUES ('Ana Elisa'), ('Naiana'), ('Diego')

SELECT * FROM tb_default1

ALTER TABLE tb_default1				-- Apaga constraint DEFAULT.
DROP CONSTRAINT DF_VALOR



--Check
-- A restri��o CHECK � usada para limitar os valores que podem ser inseridos em uma coluna.
-- Se voc� definir uma restri��o CHECK em uma coluna, ela permitir� apenas inserir determinados valores que atendam � l�gica da checagem.

CREATE TABLE tb_check (			-- Cria tabela com o check
Cod INT PRIMARY KEY,
Nome VARCHAR(50) NOT NULL,
Valor NUMERIC(6,2) CONSTRAINT CK_VAL CHECK (Valor > 0),
Letra CHAR(1) CHECK (Letra IN ('A', 'B', 'C'))
)

INSERT INTO tb_check (Cod, Nome, Valor, Letra)
VALUES (1, 'Gabriela', 140, 'A')

INSERT INTO tb_check (Cod, Nome, Valor, Letra)	-- Vai dar erro no valor, pois ele � 0 ou menor que 0.
VALUES (2, 'JOANNA', 0, 'A')

INSERT INTO tb_check (Cod, Nome, Valor, Letra)	-- Vai dar erro na letra, pois ela � diferente de A B ou C.
VALUES (3, 'JOANNA', 1, 'F')

SELECT * FROM tb_check

CREATE TABLE tb_check1 (			
Cod INT PRIMARY KEY,
Nome VARCHAR(50) NOT NULL,
Valor NUMERIC(6,2),
Numero INT
)

ALTER TABLE tb_check1			-- Adiciona o check a um campo j� criado.
ADD CHECK (Numero > 0)

ALTER TABLE tb_check1			-- Adiciona o check, atribuindo nome � constraint.
ADD CONSTRAINT CHK_VALOR CHECK (Valor > 0)

ALTER TABLE tb_check1			-- Apaga a constraint check.
DROP CONSTRAINT CHK_VALOR



-- Identity
-- Faz com que o atributo selecionado seja incrementado automaticamente, ou seja, ele ir� gerar uma numera��o automatica sem que seja necess�rio informar o valor no Insert
-- Obs1.: O campo precisa ser do tipo INTEIRO.
-- Obs2.: No identity voc� pode informar qual o inicio da numera��o e quanto ser� o incremento. Caso n�o seja informado, implicitamente o SQL Server aplica o valor(1,1), ou seja, inicia em 1 e incrementa em 1.

CREATE TABLE tb_identity(					-- Cria uma tabela com um campo auto incremental.
Cod SMALLINT IDENTITY PRIMARY KEY,
NOME VARCHAR(50)
)

INSERT INTO tb_identity (NOME)
VALUES ('Anna'), ('L�cia'), ('Raphael')

SELECT * FROM tb_identity


CREATE TABLE tb_identity2 (					-- Cria uma tabela com a numera��o come�ando do n�mero 1000 e incrementando de 1 em 1.
Cod INT IDENTITY (1000,1),
Nome VARCHAR (20)
)

INSERT INTO tb_identity2 (Nome)				-- Basta adicionar os nomes, porque os valores da coluna IDENTITY ser�o gerados automaticamente.
VALUES ('Anna'), ('L�cia'), ('Raphael')

SELECT * FROM tb_identity2

INSERT INTO tb_identity2 (Cod, Nome)		-- Se voc� tentar colocar um valor numa coluna IDENTITY, vai dar erro.
VALUES (1003, 'Naiana')

