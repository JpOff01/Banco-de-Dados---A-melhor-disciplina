/*01*/
DELIMITER //

CREATE FUNCTION total_livros_por_genero(nome_genero VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE total_livros INT;
    DECLARE genero_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE livro_id INT;

    SELECT id INTO genero_id FROM Genero WHERE nome = nome_genero;

    DECLARE cur CURSOR FOR SELECT id FROM Livro WHERE id_genero = genero_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livro_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET total_livros = total_livros + 1;
    END LOOP;

    CLOSE cur;

    RETURN total_livros;
END //

DELIMITER ;
