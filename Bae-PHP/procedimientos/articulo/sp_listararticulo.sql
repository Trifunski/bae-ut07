DELIMITER //

CREATE PROCEDURE listarArticulos(
    IN cod_pagina_param INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al obtener el Listado de Articulos' AS error_message;
    END;

    SELECT DISTINCT cod_articulo, nombre, texto, fecha_creacion, categoria
    FROM articulos
    WHERE cod_pagina = cod_pagina_param;
END//

DELIMITER ;
