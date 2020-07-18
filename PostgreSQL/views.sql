-- SELECT, INSERT, UPDATE e DELETE

select numero,
	nome,
	ativo
from banco;

create or replace view vw_bancos
	as(
	select numero,
		nome,
		ativo
	from banco
);

select numero,
	nome,
	ativo
from vw_bancos;

create or replace view vw_banco_2 (banco_numero, banco_nome, banco_ativo)
	as(
	select numero,
		nome,
		ativo
	from banco
);
select banco_numero,
	banco_nome,
	banco_ativo
from vw_banco_2;

insert into vw_banco_2 (banco_numero, banco_nome, banco_ativo)
	values (51,'Banco Boa Ideia', TRUE);
select banco_numero,
	banco_nome,
	banco_ativo
from vw_banco_2 
	where banco_numero = 51;

select numero,
	nome,
	ativo
from banco
	where numero = 51;

update vw_banco_2 
	set banco_ativo = false
	where banco_numero = 51;
	
delete from vw_banco_2
	where banco_numero = 51;
	
	
-- VIEW TEMPORÁRIA

create or replace temporary view vw_agencia
	as(
	select nome
	from agencia
);

select nome
from vw_agencia;

--WITH OPTIONS

create or replace view vw_banco_ativo
	as(
	select numero,
		nome,
		ativo
	from banco
		where ativo is true
);

insert into vw_banco_ativo (numero, nome, ativo)
	values(51, 'Banco Boa Ideia', false); --GERA ERRO
	
create or replace view vw_banco_com_a
	as(
	select numero,
		nome,
		ativo
	from vw_banco_ativo
		where nome ilike 'a%'
) with cascaded check option;

select numero,
	nome,
	ativo
from vw_banco_com_a;

insert into vw_banco_com_a(numero, nome, ativo)
	values(666, 'Alfa & Ômega S.A', true);
insert into vw_banco_com_a(numero, nome, ativo)
	values(443, 'Alfa & Beta S.A', false);

