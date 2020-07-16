select numero, nome from banco;
select banco_numero, numero, nome from agencia;
select numero, nome from cliente;
select banco_numero, agencia_numero, numero, digito, cliente_numero from conta_corrente;
select id, nome from tipo_transacao;
select banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero, valor from cliente_transacoes;

select count(1) from bancos; -- 151
select count(1)  from agencia; --296

-- JOIN

select banco.numero, 
	   banco.nome, 
	   agencia.numero, 
	   agencia.nome --296 registros
from banco
	join agencia 
		on agencia.banco_numero = banco.numero;

-- Quantos bancos apenas possuem agencia?
select count(banco.numero) --296
from banco
	join agencia 
		on agencia.banco_numero = banco.numero;

select banco.numero -- Traz o numero de bancos que possuem agencia
from banco
	join agencia 
		on agencia.banco_numero = banco.numero
group by banco.numero;

-- Outra forma de fazer o que foi feito com o group by
select count(distinct banco.numero) -- Retorna a quantidade de bancos
from banco
	join agencia 
		on agencia.banco_numero = banco.numero;


-- LEFT JOIN

select banco.numero, 
	   banco.nome, 
	   agencia.numero, 
	   agencia.nome
from banco
	left join agencia 
		on agencia.banco_numero = banco.numero; -- Traz os dados com e sem relação: 438 registros

-- RIGT JOIN

select agencia.numero, 
       agencia.nome, 
	   banco.numero, 
	   banco.nome
from agencia
	right join banco 
		on banco.numero = agencia.banco_numero; -- Só funciona para as tabelas que tem mais registros, por isso a troca
-- FULL JOIN

select banco.numero, 
	   banco.nome, 
	   agencia.numero, 
	   agencia.nome
from banco
	full join agencia 
		on agencia.banco_numero = banco.numero; -- Funciona nesse caso igual o right join

create table if not exists teste_a (
	id serial primary key,
	valor varchar(10)
);

create table if not exists teste_b (
	id serial primary key,
	valor varchar(10)
);


insert into teste_a (valor) values ('teste 1');
insert into teste_a (valor) values ('teste 2');
insert into teste_a (valor) values ('teste 3');
insert into teste_a (valor) values ('teste 4');

insert into teste_b (valor) values ('teste a');
insert into teste_b (valor) values ('teste b');
insert into teste_b (valor) values ('teste c');
insert into teste_b (valor) values ('teste d');


-- Para cada valor de tbla ele associa TODOS os valores de tblb
select tbla.valor, 
	   tblb.valor
from teste_a tbla
	cross join teste_b tblb;

drop table if exists teste_a;
drop table if exists teste_b;


select banco.nome, 
	   agencia.nome, 
	   conta_corrente.numero,
	   conta_corrente.digito,
	   cliente.nome
from banco
	join agencia 
		on agencia.banco_numero = banco.numero
	join conta_corrente 
		--on conta_corrente.banco_numero = agencia.banco_numero OU
		on conta_corrente.banco_numero = banco.numero
		and conta_corrente.agencia_numero = agencia.numero
	join cliente
		on cliente.numero = conta_corrente.cliente_numero;
		
		
-- Desafio Fazer um join com o valor das transações de cada cliente e o tipo de transações junto do join acima

select banco.nome,
	   agencia.nome,
	   conta_corrente.numero,
	   conta_corrente.digito,
	   cliente.nome,
	   cliente_transacoes.tipo_transacao_id,
	   tipo_transacao.nome,
	   cliente_transacoes.valor
from banco
	join agencia 
		on agencia.banco_numero = banco.numero
	join conta_corrente
		on conta_corrente.banco_numero = banco.numero
		and conta_corrente.agencia_numero = agencia.numero
	join cliente
		on cliente.numero = conta_corrente.cliente_numero
	join cliente_transacoes
		on cliente_transacoes.banco_numero = banco.numero
	join tipo_transacao
 		on tipo_transacao.id = cliente_transacoes.tipo_transacao_id;















