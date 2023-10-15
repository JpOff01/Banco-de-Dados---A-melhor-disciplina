/*01*/
DELIMITER //

CREATE FUNCTION total_livros_por_genero(nome_genero_param VARCHAR(255)) 
RETURNS INT 
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;

    -- Obter o total de livros do gênero fornecido
    SELECT COUNT(*) INTO total FROM Livro
    WHERE id_genero = (SELECT id FROM Genero WHERE nome_genero = nome_genero_param LIMIT 1);

    RETURN total;
END;
//

DELIMITER ;


SELECT total_livros_por_genero('Romance');

/*02*/
delimiter //
CREATE FUNCTION listar_livros_por_autor(
    primeiro_nome_autor VARCHAR(255),
    ultimo_nome_autor VARCHAR(255)
) 
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE lista_livros TEXT;
    
    SET lista_livros = '';

    SELECT GROUP_CONCAT(l.titulo SEPARATOR ', ') INTO lista_livros
    FROM Livro l
    JOIN Livro_Autor la ON l.id = la.id_livro
    JOIN Autor a ON la.id_autor = a.id
    WHERE a.primeiro_nome = primeiro_nome_autor AND a.ultimo_nome = ultimo_nome_autor;
    
    IF lista_livros IS NOT NULL THEN
        RETURN lista_livros;
    ELSE
        RETURN 'Autor não encontrado.';
    END IF;
END;
//
delimiter ;

select listar_livros_por_autor('Carlos', 'Menezes');

/*03*/
DELIMITER //

CREATE FUNCTION atualizar_resumos() RETURNS INT DETERMINISTIC
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE livro_id INT;
    DECLARE resumo_atual TEXT;

    -- Cursor para percorrer os livros
    DECLARE cur CURSOR FOR SELECT id, resumo FROM Livro;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livro_id, resumo_atual;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Atualizar o resumo com a frase adicional
        UPDATE Livro
        SET resumo = CONCAT(resumo_atual, ' Este é um excelente livro!')
        WHERE id = livro_id;
    END LOOP;

    CLOSE cur;

    RETURN 1; -- Indicação de conclusão
END //

DELIMITER ;

SELECT atualizar_resumos();

/*04*/
DELIMITER //

CREATE FUNCTION media_livros_por_editora() RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE total_editoras INT;
    DECLARE total_livros INT;
    DECLARE media FLOAT;

    -- Obtendo o número total de editoras e de livros
    SELECT COUNT(id) INTO total_editoras FROM Editora;
    SELECT COUNT(id) INTO total_livros FROM Livro;

    -- Inicializando a média como 0
    SET media = 0;

    -- Calculando a média diretamente
    SELECT SUM(total_livros_por_editora) / total_editoras INTO media 
    FROM (
        SELECT COUNT(id) AS total_livros_por_editora 
        FROM Livro 
        GROUP BY id_editora
    ) AS editora_count;

    RETURN media;
END //

DELIMITER ;

SELECT media_livros_por_editora();
