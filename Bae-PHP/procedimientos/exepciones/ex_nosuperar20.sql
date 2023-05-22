/* Codigos de agregar y modificar plan con la exepcion de que si supero 20 el numero de grafico salta un error. */

DELIMITER //

CREATE PROCEDURE agregar_plan(
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END;

    START TRANSACTION;

    IF p_NumGrafico > 20 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END IF;

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

DELIMITER //

CREATE PROCEDURE modificar_plan
(
    IN p_CodPlan INT,
    IN p_Nombre VARCHAR(255),
    IN p_Precio DECIMAL(10,2),
    IN p_NumGrafico INT,
    IN p_NumUsuario INT,
    IN p_NumIndicadores INT
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END;

    START TRANSACTION;

    IF p_NumGrafico > 20 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de gráficos no puede superar 20';
    END IF;

    UPDATE planes
    SET Nombre = p_Nombre,
        Precio = p_Precio,
        NumGrafico = p_NumGrafico,
        NumUsuario = p_NumUsuario,
        NumIndicadores = p_NumIndicadores
    WHERE Cod_Plan = p_CodPlan;

    IF ROW_COUNT() > 0 THEN
        SELECT 'Plan modificado correctamente' AS Result;
        COMMIT;
    ELSE
        ROLLBACK;
        SELECT 'Ocurrió un error inesperado al modificar el Plan' AS Result;
    END IF;
END //

DELIMITER ;