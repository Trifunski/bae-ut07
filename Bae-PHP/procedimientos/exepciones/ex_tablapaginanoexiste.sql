DELIMITER //

CREATE PROCEDURE listar_pagina()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al listar la página' AS Result;
    END;

    IF EXISTS (SELECT * FROM information_schema.tables WHERE table_name = 'paginaweb') THEN
        SELECT *
        FROM paginaweb
        ORDER BY Estado DESC;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La tabla paginaweb no existe';
    END IF;
END //

DELIMITER ;