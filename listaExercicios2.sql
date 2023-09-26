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

/*4*/
delimiter //
create procedure sp_VerificarLivrosCategoria(in categoria_nome varchar(255), out possui_livros bit)
begin
    declare total_livros int;
    
    select count(*) into total_livros
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
    
    if total_livros > 0 then
        set possui_livros = 1;
    else
        set possui_livros = 0;
    end if;
end;
//
delimiter ;

call sp_VerificarLivrosCategoria('História', @possui_livros);
select @possui_livros;
drop procedure sp_VerificarLivrosCategoria;

/*5*/
delimiter //
create procedure sp_LivrosAteAno(in ano_publicacao int)
begin
    select Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID
    from Livro
    where Ano_Publicacao <= ano_publicacao;
end;
//
delimiter ;

call sp_LivrosAteAno('2005');
drop procedure sp_LivrosAteAno;

/*6*/
delimiter //
create procedure sp_TitulosPorCategoria (in categoria_nome varchar(255))
begin
	select Livro.Titulo
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
end;
//
delimiter ;

call sp_TitulosPorCategoria('Ciência');
drop procedure sp_TitulosPorCategoria;