DELIMITER //
CREATE PROCEDURE listarComentarios(IN id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al obtener el Listado de Comentarios' AS Message;
    END;
    
    SELECT DISTINCT * FROM comentarios WHERE Cod_Articulo = id;
END //
DELIMITER ;
