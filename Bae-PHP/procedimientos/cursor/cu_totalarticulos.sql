DELIMITER //

CREATE PROCEDURE GetTotalArticulos()
BEGIN
    DECLARE total INT;
    DECLARE error_msg VARCHAR(255) DEFAULT NULL;

    -- Declarar el cursor para obtener los datos
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM articulo;

    -- Handler para capturar errores
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_msg = MESSAGE_TEXT;
    END;

    -- Inicializar variables
    SET @done = FALSE;

    -- Abrir el cursor y obtener el resultado
    OPEN cur;
    FETCH cur INTO total;

    -- Verificar si se produjo un error
    IF error_msg IS NOT NULL THEN
        SELECT error_msg;
    ELSE
        SELECT total;
    END IF;

    -- Cerrar el cursor
    CLOSE cur;
END//

DELIMITER ;