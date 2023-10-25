exercicio 1
create trigger cliente_auditoria after insert on Clientes for each row
insert into Auditoria (mensagem, data_hora) values ('Inserção em', now());
