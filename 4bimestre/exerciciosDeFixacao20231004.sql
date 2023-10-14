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
DELIMITER //

CREATE FUNCTION listar_livros_por_autor(
    primeiro_nome_autor VARCHAR(255),
    ultimo_nome_autor VARCHAR(255)
) RETURNS TEXT
BEGIN
    DECLARE lista_livros TEXT;
    DECLARE autor_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE livro_id INT;
    DECLARE livro_titulo VARCHAR(255);

    SELECT id INTO autor_id FROM Autor WHERE primeiro_nome = primeiro_nome_autor AND ultimo_nome = ultimo_nome_autor;

    SET lista_livros = '';

    DECLARE cur CURSOR FOR 
        SELECT LA.id_livro 
        FROM Livro_Autor LA 
        WHERE LA.id_autor = autor_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livro_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT titulo INTO livro_titulo FROM Livro WHERE id = livro_id;
        SET lista_livros = CONCAT(lista_livros, livro_titulo, '; ');

    END LOOP;

    CLOSE cur;

    RETURN lista_livros;
END //

DELIMITER ;

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
