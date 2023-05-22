DELIMITER //

CREATE PROCEDURE eliminar_articulo(
    IN p_cod_articulo INT, 
    OUT p_resultado VARCHAR(100)
)
BEGIN
    DELETE FROM articulos WHERE cod_articulo = p_cod_articulo;

    IF ROW_COUNT() > 0 THEN
        SET p_resultado = 'Articulo eliminado correctamente';
    ELSE
        SET p_resultado = 'No se encontró ningún artículo con el código especificado';
    END IF;
END //

DELIMITER ;
