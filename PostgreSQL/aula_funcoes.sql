--FUNÇÃO EM SQL
create or replace function somar(integer, integer)
	returns integer
	security definer
	called on null input
	--returns null on null input
	language sql
	as $$
		select coalesce($1,0) + coalesce($2,0) -- essa função retorna o primeiro valor n nulo dentro de uma lista
$$;

select somar(1,100);
select somar(1,null);
-----------------------------------------------------------------------------------------------------------------
--FUNÇÃO EM PLPSQL
create or replace function bancos_add(b_numero integer,b_nome varchar, b_ativo boolean)
	returns integer
	security invoker
	language plpgsql
	called on null input
	as $$
		declare v_id integer;
		begin
			if b_nome is null or b_numero is null or b_ativo is null then
				return 0;
			end if;
			
			select into v_id numero
			from banco
				where numero = b_numero;
			if v_id is null then
				insert into banco(numero, nome, ativo)
					values(b_numero, b_nome, b_ativo);
			else
				return v_id;
			end if;
			
			select into v_id numero
			from banco
				where numero = b_numero;
			
			return v_id;
		end;
$$;

select bancos_add(5433, 'Banco do Ovo em nova porta', true);

select numero,
	nome,
	ativo
from banco
	where numero = 5433;



	