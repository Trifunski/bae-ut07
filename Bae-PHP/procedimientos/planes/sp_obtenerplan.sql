DELIMITER //

CREATE PROCEDURE obtenerPlan(IN p_Cod_Plan INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error: ' || SQLERRM;
        ROLLBACK;
    END;

    START TRANSACTION;

    SELECT * FROM planes WHERE Cod_Plan = p_Cod_Plan;

    IF FOUND_ROWS() > 0 THEN
        SELECT * FROM planes WHERE Cod_Plan = p_Cod_Plan LIMIT 1;
    ELSE
        SELECT 'Ocurrió un error inesperado al obtener el Plan';
    END IF;

    COMMIT;
END //

DELIMITER ;
