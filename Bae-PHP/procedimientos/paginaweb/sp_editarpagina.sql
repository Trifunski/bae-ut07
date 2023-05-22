DELIMITER //
CREATE PROCEDURE modificar_pagina(
    IN p_cod_pagina INT,
    IN p_nombre VARCHAR(255),
    IN p_estado VARCHAR(255)
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al modificar la página' AS message;
    END;
    
    DECLARE exit handler for sqlwarning
    BEGIN
        ROLLBACK;
        SELECT 'Advertencia: Ocurrió una advertencia al modificar la página' AS message;
    END;

    START TRANSACTION;

    UPDATE paginaweb
    SET nombre = p_nombre, estado = p_estado
    WHERE cod_pagina = p_cod_pagina;

    IF ROW_COUNT() > 0 THEN
        COMMIT;
        SELECT 'Página modificada correctamente' AS message;
    ELSE
        ROLLBACK;
        SELECT 'No se encontró la página con el código especificado' AS message;
    END IF;
END //
DELIMITER ;
