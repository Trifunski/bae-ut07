DELIMITER //

CREATE PROCEDURE eliminar_pagina(IN cod_pagina INT)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET error_occurred = 1;
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM paginaweb WHERE cod_pagina = cod_pagina;

    IF error_occurred = 0 THEN
        COMMIT;
        SELECT 'Pagina eliminada correctamente' AS message;
    ELSE
        SELECT 'Ocurrió un error inesperado al eliminar la Pagina' AS message;
    END IF;

END //

DELIMITER ;
