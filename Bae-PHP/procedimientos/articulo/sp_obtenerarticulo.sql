DELIMITER //

CREATE PROCEDURE obtener_articulo(IN cod_articulo INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error: ' AS mensaje, 
               CONCAT('Error: ', SQLSTATE, ' ', SQLERRM) AS descripcion;
    END;

    SELECT *
    FROM articulos
    WHERE cod_articulo = cod_articulo;
END//

DELIMITER ;
