DELIMITER //

CREATE PROCEDURE ListarPaginas
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT *
        FROM paginaweb
        ORDER BY Estado DESC;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END//

DELIMITER ;