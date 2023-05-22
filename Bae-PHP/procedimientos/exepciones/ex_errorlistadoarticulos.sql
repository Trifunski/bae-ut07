/* Mensaje de error si el listado de articulo no se ejecuto correctamente o hubo algun error. */

DELIMITER //

CREATE PROCEDURE listar_articulo(
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