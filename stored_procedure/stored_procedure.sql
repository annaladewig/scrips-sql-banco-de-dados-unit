-- Stored Procedures (Procedimentos Armazenados)

/*
- S�o um conjunto (uma ou mais) de instru��es SQL normalmente agrupadas para executar uma rotina espec�fica.

- As stored procedures s�o compar�veis com as functions, mas possuem flexibilidade e recursos que s�o imposs�veis dentro de fun��es.

 - Vantagens da utiliza��o de Stored Procedures
	- Oferecem maior desempenho, devido ao c�digo compilado.
	- S�o f�ceis de manter, pois as altera��es s�o centralizadas, em vez de serem feitas com c�digo.
	- Oferecem um alto n�vel de seguran�a. Pois em vez de o acesso ser concedido ao objeto, a permiss�o pode ser dada somente para o stored procedure.
	- Aceitam cl�usulas de tratamento de erro.
	- Poss�vel realizar opera��es complexas com T-SQL.

 - Basicamente, as stored procedures criam um n�vel de abstra��o para permiss�es. 
 - Ou seja, em vez de se conceder ao usu�rio direitos SELECT, INSERT, UPDATE ou DELETE, ele pode receber direitos de EXECUTE para um stored procedure.

 - As procedures podem receber ou n�o par�metros.

 - Podemos criar procedures que ir�o nos retornar os dados de uma tabela (SELECT) ou para inserir / atualizar / remover dados de uma tabela.
*/

	CREATE PROC OU PROCEDURE uSP_NAME	-- Cria Procedure com par�metro.
	(@PARAMETER TYPE_PARAMETER)
	AS
	BEGIN 
		SQL_CODE
	END


	CREATE PROC OU PROCEDURE uSP_NAME	-- Cria Procedure sem par�metro.
	AS
	BEGIN
		SQL_CODE
	END


	ALTER PROC OU PROCEDURE uSP_NAME	-- Altera uma Procedure.
	(@PARAMETER TYPE_PARAMETER)
	AS
	BEGIN
		SQL_CODE
	END


	DROP PROC OU PROCEDURE uSP_NAME		-- Remove um objeto Procedure.


	SP_HELPTEXT uSP_NAME				-- Visualiza o c�digo de uma Procedure j� existente.


-- Como fazer para chamar (executar) uma Procedure?
	-- MODO 1: Comando EXEC / EXECUTE + nome da procedure criada + par�metros passados na cria��o se existirem.
	-- MODO 2: Apenas passando o nome da Procedure e executando a mesma.

	EXEC | EXECUTE uSP_NAME				-- Chama a Procedure (Modo 1).
	
	uSP_NAME							-- Chama a Procedure (Modo 2).


	EXEC uSP_NAME @Param1 = 'TEXTO',	-- Chama a Procedure passando par�metros.
	@Param2 = 'TEXTO'

	EXEC uSP_NAME 'TEXTO'				-- Chama a Procedure passando par�metro.


CREATE PROCEDURE uSP_INSERT_FUNCAO		-- Procedure para inserir uma fun��o na tabela Fun��o.
(@FUNCAO VARCHAR(100))
AS
BEGIN
	INSERT INTO FUNCAO
	VALUES (@FUNCAO)
END


-- Como executar essa Procedure?
EXECUTE uSP_INSERT_FUNCAO 'DIRETOR'		-- Insere a fun��o Diretor na tabela Fun��o atrav�s da Procedure.

EXECUTE uSP_INSERT_FUNCAO				-- Insere a fun��o CEO na tabela Fun��o atrav�s da Procedure.
@FUNCAO = 'CEO'	

SELECT * FROM FUNCAO


-- E se fosse uma procedure para retornar um SELECT?

CREATE PROC uSP_SELECT_FUNCIONARIOS
(
@SALARIO SMALLMONEY,
@STATUS_FUNC VARCHAR(10)
)
AS
BEGIN
	SELECT * FROM FUNCIONARIO
	WHERE SALARIO >= @SALARIO
	AND STATUS_FUNC = @STATUS_FUNC
END


EXEC uSP_SELECT_FUNCIONARIOS 1000, 'ATIVO'		-- Modo 1 (os par�metros tem que estar na mesma ordem da cria��o dos par�metros).

EXEC uSP_SELECT_FUNCIONARIOS @SALARIO = 2500, @STATUS_FUNC = 'INATIVO'	-- Modo 2


-- E se eu quiser alterar a estrutura da Stored Procedure que j� est� pronta?

ALTER PROC uSP_SELECT_FUNCIONARIOS
(
@SALARIO SMALLMONEY,
@STATUS_FUNC VARCHAR(10)
)
AS
BEGIN
	SELECT * FROM FUNCIONARIO
	WHERE SALARIO < @SALARIO
	AND STATUS_FUNC = @STATUS_FUNC
END

EXEC uSP_SELECT_FUNCIONARIOS 1000, 'ATIVO'


-- E se eu quisesse fazer uma procedure sem par�metro?
CREATE PROC uSP_SELECT_FUNCAO
AS
BEGIN
	SELECT * FROM FUNCAO
END

EXEC uSP_SELECT_FUNCAO 