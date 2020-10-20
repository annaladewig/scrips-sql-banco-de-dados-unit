-- COMANDOS_DCL

-- DCL: DATA CONTROL LANGUAGE
-- O DCL controla a seguran�a dos dados, definindo quem tem acesso a determinado tipo de opera��o.

-- GRANT � Usado para dar permiss�o a um determinado usu�rio para executar um procedimento ou acessar um determinado objeto.
	GRANT <Privilegio>
	ON OBJETO_BD TO <Usuario>.
-- DENY � Negar permiss�es de acesso a objetos do banco de dados.	DENY <Privilegio>
	ON OBJETO_BD TO <Usuario>.-- REVOKE � Desfaz uma permiss�o, seja uma GRANT ou DENY.
	REVOKE <Privilegio>
	ON OBJETO_BD TO <Usuario>.


CREATE USER USER_DCL WITHOUT LOGIN;				
GRANT SELECT, INSERT ON DBO.TB_DML TO USER_DCL   -- D� permiss�o para o usu�rio executar os comandos SELECT e INSERT na tabela.

REVOKE INSERT ON DBO.TB_DML TO USER_DCL			 -- Desfaz a permiss�o dada anteriormente pelo comando GRANT.

DENY SELECT ON DBO.TB_DML TO USER_DCL		     -- Nega permiss�o para o usu�rio dar o SELECT na tabela.

EXECUTE AS USER = 'USER_DCL'				     
SELECT * FROM TB_DML							 -- Executa consulta como usu�rio criado.
REVERT											 -- O REVERT � para voltar ao usu�rio original.
		

/* 
Privil�gio			Descri��o
SELECT				Capacidade de executar instru��es SELECT na tabela.
INSERT				Capacidade de executar instru��es INSERT na tabela.
UPDATE				Capacidade de executar instru��es UPDATE na tabela.
DELETE				Capacidade de executar instru��es DELETE na tabela.
REFERENCES			Capacidade de criar uma restri��o que se refere � tabela.
ALTER				Capacidade de executar instru��es ALTER TABLE para alterar 
					a defini��o da tabela.
ALL					ALL n�o concede todas as permiss�es para a tabela. Em vez 
					disso, concede as permiss�es ANSI-92 que s�o SELECT, INSERT,
					UPDATE, DELETE e REFERENCES. 
*/