DELIMITER //

CREATE PROCEDURE obtener_comentario(IN cod_comentario INT)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET error_occurred = 1;
        SELECT CONCAT('Ocurrió un error: ', SQLEXCEPTION.MESSAGE) AS error_message;
    END;

    SELECT * FROM comentarios WHERE cod_comentario = cod_comentario;

    IF error_occurred = 0 THEN
        SELECT * FROM comentarios WHERE cod_comentario = cod_comentario;
    ELSE
        SELECT 'Ocurrió un error inesperado al obtener el Comentario' AS error_message;
    END IF;
END //

DELIMITER ;
