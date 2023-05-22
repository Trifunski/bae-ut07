CREATE PROCEDURE eliminarPlan(IN p_Cod_Plan INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT CONCAT('Ocurrió un error: ', ERROR_MESSAGE()) AS ErrorMessage;
    END;
    
    DELETE FROM planes WHERE Cod_Plan = p_Cod_Plan;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Plan eliminado correctamente' AS Message;
    ELSE
        SELECT 'Ocurrió un error inesperado al eliminar el Plan' AS ErrorMessage;
    END IF;
END
