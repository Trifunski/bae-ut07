CREATE PROCEDURE obtener_pagina (
    IN cod_pagina INT
)
BEGIN
    DECLARE resultado VARCHAR(255);

    SELECT * FROM paginaweb WHERE cod_pagina = cod_pagina INTO resultado;

    IF resultado IS NULL THEN
        SELECT 'No se encontró ninguna página con el código especificado' AS resultado;
    ELSE
        SELECT resultado;
    END IF;
END;

