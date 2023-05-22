DELIMITER //

CREATE TRIGGER trigger_eliminar_articulo
    AFTER DELETE ON articulos
    FOR EACH ROW
    BEGIN
        IF NOT EXISTS (
            SELECT 1
            FROM historico_articulos
            WHERE cod_articulo = OLD.cod_articulo
        ) THEN
            INSERT INTO historico_articulos (
                cod_articulo, 
                nombre, 
                texto, 
                fecha_creacion, 
                categoria, 
                cod_pagina
            )
            VALUES (
                OLD.cod_articulo, 
                OLD.nombre, 
                OLD.texto, 
                OLD.fecha_creacion, 
                OLD.categoria, 
                OLD.cod_pagina
            );
        END IF;
    END //

DELIMITER ;