CREATE PROCEDURE modificarPlan
(
    IN p_CodPlan INT,
    IN p_Nombre VARCHAR(255),
    IN p_Precio DECIMAL(10,2),
    IN p_NumGrafico INT,
    IN p_NumUsuario INT,
    IN p_NumIndicadores INT
)
BEGIN
    UPDATE planes
    SET Nombre = p_Nombre,
        Precio = p_Precio,
        NumGrafico = p_NumGrafico,
        NumUsuario = p_NumUsuario,
        NumIndicadores = p_NumIndicadores
    WHERE Cod_Plan = p_CodPlan;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Plan modificado correctamente' AS Result;
    ELSE
        SELECT 'Ocurrió un error inesperado al modificar el Plan' AS Result;
    END IF;
END;
