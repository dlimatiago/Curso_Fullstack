SELECT numero, nome FROM banco;
SELECT banco_numero, numero FROM agencia;
SELECT numero, nome, email FROM cliente;
SELECT banco_numero, agencia_numero, numero, cliente_numero FROM cliente_transacoes;

select * from conta_corrente;

select * from information_schema.columns where table_name = 'banco'; --Forma de saber as colunas sem ficar olhando no menu

select column_name, data_type from information_schema.columns where table_name = 'banco';


-- Funções de agregação:
-- AVG
-- Count (having)
--Max
--Min
--Sum 

select * from cliente_transacoes;
select avg(valor) from cliente_transacoes;

select count(numero)
from cliente;

select count(numero), email --Ao executar assim, irá resultar num erro. Para corrigir, usar GROUP BY
from cliente
where email ilike '%gmail.com'
group by email;


select max(valor), tipo_transacao_id 
from cliente_transacoes
group by tipo_transacao_id;

select min(valor), tipo_transacao_id
from cliente_transacoes
group by tipo_transacao_id;


select column_name, data_type from information_schema.columns where table_name = 'cliente_transacoes';

select count(id), tipo_transacao_id 
from cliente_transacoes
group by tipo_transacao_id
having count(id) > 150;



select sum(valor), tipo_transacao_id
from cliente_transacoes
group by tipo_transacao_id;


select sum(valor), tipo_transacao_id
from cliente_transacoes
group by tipo_transacao_id
order by tipo_transacao_id; --default ascendente (asc)




select sum(valor), tipo_transacao_id
from cliente_transacoes
group by tipo_transacao_id
order by tipo_transacao_id desc;