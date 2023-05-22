DELIMITER //
CREATE PROCEDURE agregarPlan(
    IN p_Nombre VARCHAR(255),
    IN p_Precio DECIMAL(10, 2),
    IN p_NumGrafico INT,
    IN p_NumUsuario INT,
    IN p_NumIndicadores INT,
    IN p_CodPagina INT
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al agregar el Plan';
    END;

    START TRANSACTION;

    INSERT INTO planes (Nombre, Precio, NumGrafico, NumUsuario, NumIndicadores, PAGINAWEB_Cod_Pagina)
    VALUES (p_Nombre, p_Precio, p_NumGrafico, p_NumUsuario, p_NumIndicadores, p_CodPagina);

    IF ROW_COUNT() > 0 THEN
        SELECT 'Plan agregado correctamente';
        COMMIT;
    ELSE
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al agregar el Plan';
    END IF;
END //
DELIMITER ;
