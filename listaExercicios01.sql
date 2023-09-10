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

/*6*/
select autores.nome as autor, count(livros.id) as total_livros
from autores
left join livros on autores.id = livros.autor_id
group by autores.nome;

/*7*/
select alunos.nome as aluno, count(alunos.id) as total_alunos
from alunos
inner join matriculas on alunos.id = matriculas.aluno_id
group by alunos.nome;

/*8*/
select produto, AVG(receita) as receita_media from vendas group by produto;

/*9*/
select produto, SUM(receita) as receita_total from vendas group by produto
having SUM(receita) > 10000.00;

/*10*/
select autores.nome as autor, count(livros.id) as total_de_livros from autores
left join livros on autores.id = livros.autor_id group by autores.nome
having count(livros.id) > 2;

/*11*/
select livros.titulo, autores.nome as autor from livros
inner join autores on livros.autor_id = autores.id;

/*12*/
select alunos.nome as Aluno, matriculas.curso as Curso from alunos
left join matriculas on alunos.id = matriculas.aluno_id;

/*13*/
select autores.nome as autor, livros.titulo from autores
left join livros on autores.id = livros.autor_id;

/*14*/
select matriculas.curso as curso, alunos.nome as aluno from matriculas
right join alunos on matriculas.aluno_id = alunos.id;