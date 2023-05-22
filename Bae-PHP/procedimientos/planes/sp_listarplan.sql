CREATE PROCEDURE listarPlanes(IN Cod_Plan INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Ocurrió un error inesperado al listar los Planes' AS Message;
    END;

    SELECT * FROM planes WHERE PAGINAWEB_Cod_Pagina = Cod_Plan ORDER BY Cod_Plan;
END
