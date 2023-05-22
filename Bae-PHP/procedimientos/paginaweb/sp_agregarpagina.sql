DELIMITER //

CREATE PROCEDURE agregar_pagina (
    IN p_nombre VARCHAR(255),
    IN p_estado VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al agregar la Pagina' AS mensaje;
    END;

    START TRANSACTION;

    INSERT INTO paginaweb (nombre, estado)
    VALUES (p_nombre, p_estado);

    IF ROW_COUNT() > 0 THEN
        COMMIT;
        SELECT 'Creado correctamente' AS mensaje;
    ELSE
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al agregar la Pagina' AS mensaje;
    END IF;
END //

DELIMITER ;
