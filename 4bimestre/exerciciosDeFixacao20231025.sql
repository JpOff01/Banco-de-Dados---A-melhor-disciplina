exercicio 1
create trigger cliente_auditoria after insert on Clientes for each row
insert into Auditoria (mensagem, data_hora) values ('Inserção em', now());

exercicio 2
create trigger remover_cliente before delete on Clientes for each row
insert into Auditoria (mensagem, data_hora) values ('Tentativa de remover nome do indivíduo...', now());

exercicio 3
create trigger update_cliente after update on Clientes for each row
set 
nome = OLD.nome,
nome = NEW.nome;
insert into Auditoria (mensagem, data_hora) values ('Atualização de cliente em', now());
