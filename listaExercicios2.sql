/*1*/
delimiter //
create procedure sp_ListarAutores ()
begin
	select * from Autor;
end;
//
delimiter ;
call sp_ListarAutores();
drop procedure sp_ListarAutores;

/*2*/
DELIMITER //
create procedure sp_LivrosPorCategoria (in categoria_nome varchar(255))
begin
    select Livro.Titulo, Livro.Editora_ID, Livro.Ano_Publicacao, Livro.Numero_Paginas
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoria_nome;
end;
//
DELIMITER ;
call sp_LivrosPorCategoria('Romance');
call sp_LivrosPorCategoria('Ciência');
drop procedure sp_LivrosPorCategoria;

/*3*/
delimiter //
create procedure sp_ContarLivrosPorCategoria(in categoria_nome varchar(255), out total_livros int)
begin
    select COUNT(*) into total_livros
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
end;
//
delimiter ;

CALL sp_ContarLivrosPorCategoria('História', @total);
select @total;
drop procedure sp_ContarLivrosPorCategoria;