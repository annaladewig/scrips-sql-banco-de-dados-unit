-- Stored Procedures (Procedimentos Armazenados)

/*
- São um conjunto (uma ou mais) de instruções SQL normalmente agrupadas para executar uma rotina específica.

- As stored procedures são comparáveis com as functions, mas possuem flexibilidade e recursos que são impossíveis dentro de funções.

 - Vantagens da utilização de Stored Procedures
	- Oferecem maior desempenho, devido ao código compilado.
	- São fáceis de manter, pois as alterações são centralizadas, em vez de serem feitas com código.
	- Oferecem um alto nível de segurança. Pois em vez de o acesso ser concedido ao objeto, a permissão pode ser dada somente para o stored procedure.
	- Aceitam cláusulas de tratamento de erro.
	- Possível realizar operações complexas com T-SQL.

 - Basicamente, as stored procedures criam um nível de abstração para permissões. 
 - Ou seja, em vez de se conceder ao usuário direitos SELECT, INSERT, UPDATE ou DELETE, ele pode receber direitos de EXECUTE para um stored procedure.

 - As procedures podem receber ou não parâmetros.

 - Podemos criar procedures que irão nos retornar os dados de uma tabela (SELECT) ou para inserir / atualizar / remover dados de uma tabela.
*/

	CREATE PROC OU PROCEDURE uSP_NAME	-- Cria Procedure com parâmetro.
	(@PARAMETER TYPE_PARAMETER)
	AS
	BEGIN 
		SQL_CODE
	END


	CREATE PROC OU PROCEDURE uSP_NAME	-- Cria Procedure sem parâmetro.
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


	SP_HELPTEXT uSP_NAME				-- Visualiza o código de uma Procedure já existente.


-- Como fazer para chamar (executar) uma Procedure?
	-- MODO 1: Comando EXEC / EXECUTE + nome da procedure criada + parâmetros passados na criação se existirem.
	-- MODO 2: Apenas passando o nome da Procedure e executando a mesma.

	EXEC | EXECUTE uSP_NAME				-- Chama a Procedure (Modo 1).
	
	uSP_NAME							-- Chama a Procedure (Modo 2).


	EXEC uSP_NAME @Param1 = 'TEXTO',	-- Chama a Procedure passando parâmetros.
	@Param2 = 'TEXTO'

	EXEC uSP_NAME 'TEXTO'				-- Chama a Procedure passando parâmetro.


CREATE PROCEDURE uSP_INSERT_FUNCAO		-- Procedure para inserir uma função na tabela Função.
(@FUNCAO VARCHAR(100))
AS
BEGIN
	INSERT INTO FUNCAO
	VALUES (@FUNCAO)
END


-- Como executar essa Procedure?
EXECUTE uSP_INSERT_FUNCAO 'DIRETOR'		-- Insere a função Diretor na tabela Função através da Procedure.

EXECUTE uSP_INSERT_FUNCAO				-- Insere a função CEO na tabela Função através da Procedure.
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


EXEC uSP_SELECT_FUNCIONARIOS 1000, 'ATIVO'		-- Modo 1 (os parâmetros tem que estar na mesma ordem da criação dos parâmetros).

EXEC uSP_SELECT_FUNCIONARIOS @SALARIO = 2500, @STATUS_FUNC = 'INATIVO'	-- Modo 2


-- E se eu quiser alterar a estrutura da Stored Procedure que já está pronta?

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


-- E se eu quisesse fazer uma procedure sem parâmetro?
CREATE PROC uSP_SELECT_FUNCAO
AS
BEGIN
	SELECT * FROM FUNCAO
END

EXEC uSP_SELECT_FUNCAO 