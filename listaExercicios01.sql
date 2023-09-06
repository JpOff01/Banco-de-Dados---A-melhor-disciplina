/*1*/
select titulo from livros;

/*2*/
select nome from autores where nascimento <= '1900-01-01';

/*3*/
select livros.titulo
from livros
inner join autores on livros.autor_id = autores.id where autores.nome = 'J.K. Rowling';