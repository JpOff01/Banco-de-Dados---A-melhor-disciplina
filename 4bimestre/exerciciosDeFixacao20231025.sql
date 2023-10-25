exercicio 1
create trigger cliente_auditoria after insert on Clientes for each row
insert into Auditoria (mensagem, data_hora) values ('Inserção em', now());

exercicio 2
create trigger remover_cliente before insert on Clientes for each row
insert into Auditoria (mensagem, data_hora) values ('Tentativa de remover nome do indivíduo...', now());
