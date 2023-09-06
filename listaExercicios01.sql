/*1*/
select titulo from livros;

/*2*/
select nome from autores where nascimento <= '1900-01-01';

/*3*/
select livros.titulo
from livros
inner join autores on livros.autor_id = autores.id where autores.nome = 'J.K. Rowling';

/*4*/
select alunos.nome
from alunos
inner join matriculas on alunos.id = matriculas.id where matriculas.curso = 'Engenharia de Software';
drop table matriculas;

/*5*/
select produto, SUM(receita) as receita_total from vendas group by produto;