-- COMANDOS_DCL

-- DCL: DATA CONTROL LANGUAGE
-- O DCL controla a segurança dos dados, definindo quem tem acesso a determinado tipo de operação.

-- GRANT – Usado para dar permissão a um determinado usuário para executar um procedimento ou acessar um determinado objeto.
	GRANT <Privilegio>
	ON OBJETO_BD TO <Usuario>.
-- DENY – Negar permissões de acesso a objetos do banco de dados.	DENY <Privilegio>
	ON OBJETO_BD TO <Usuario>.-- REVOKE – Desfaz uma permissão, seja uma GRANT ou DENY.
	REVOKE <Privilegio>
	ON OBJETO_BD TO <Usuario>.


CREATE USER USER_DCL WITHOUT LOGIN;				
GRANT SELECT, INSERT ON DBO.TB_DML TO USER_DCL   -- Dá permissão para o usuário executar os comandos SELECT e INSERT na tabela.

REVOKE INSERT ON DBO.TB_DML TO USER_DCL			 -- Desfaz a permissão dada anteriormente pelo comando GRANT.

DENY SELECT ON DBO.TB_DML TO USER_DCL		     -- Nega permissão para o usuário dar o SELECT na tabela.

EXECUTE AS USER = 'USER_DCL'				     
SELECT * FROM TB_DML							 -- Executa consulta como usuário criado.
REVERT											 -- O REVERT é para voltar ao usuário original.
		

/* 
Privilégio			Descrição
SELECT				Capacidade de executar instruções SELECT na tabela.
INSERT				Capacidade de executar instruções INSERT na tabela.
UPDATE				Capacidade de executar instruções UPDATE na tabela.
DELETE				Capacidade de executar instruções DELETE na tabela.
REFERENCES			Capacidade de criar uma restrição que se refere à tabela.
ALTER				Capacidade de executar instruções ALTER TABLE para alterar 
					a definição da tabela.
ALL					ALL não concede todas as permissões para a tabela. Em vez 
					disso, concede as permissões ANSI-92 que são SELECT, INSERT,
					UPDATE, DELETE e REFERENCES. 
*/