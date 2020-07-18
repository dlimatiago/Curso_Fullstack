-- RECURSIVIDADE

create table if not exists funcionarios(
	id serial,
	nome varchar(50),
	gerente integer,
	primary key (id),
	foreign key (gerente) references funcionarios(id)
);

insert into funcionarios(nome, gerente)
	values('Ancelmo', null);
insert into funcionarios(nome, gerente)
	values('Beatriz', 1);
insert into funcionarios(nome, gerente)
	values('Magno', 1);
insert into funcionarios(nome, gerente)
	values('Cremilda', 2);
insert into funcionarios(nome, gerente)
	values('Wagner', 4);
	
select id,
	nome,
	gerente
from funcionarios
	where gerente is null;
union all
select id,
	nome,
	gerente
from funcionarios
	where id = 999 ; -- APenas para exemplificar

create or replace recursive view vw_func(id, gerente, funcionario)
	as(
	select id,
		gerente,
		nome
	from funcionarios
		where gerente is null
		
	union all -- Faz uma bag
		
	select funcionarios.id,
		funcionarios.gerente,
		funcionarios.nome
	from funcionarios
		join vw_func
			on vw_func.id = funcionarios.gerente
);

select id,
	gerente,
	funcionario
from vw_func;

-- DESAFIO: MONTAR UM SELECT COM VIEW RECURSIVA RETORNANDO O NOME DO GERENTE.

-- View com os gerentes e sua id
create or replace view vw_gerentes(id, nome)
	as(
	select id,
		nome
	from funcionarios
		where id in (
			select gerente
			from funcionarios
				where gerente is not null)
);

-- View com as ids, funcionarios e gerentes(nome)
