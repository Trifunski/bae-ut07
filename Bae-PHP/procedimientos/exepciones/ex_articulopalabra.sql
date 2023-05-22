DELIMITER //

CREATE PROCEDURE agregar_articulo(
    IN p_nombre VARCHAR(255), 
    IN p_texto TEXT, 
    IN p_fecha_creacion DATE, 
    IN p_categoria VARCHAR(255), 
    IN p_cod_pagina INT
)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM articulos
    WHERE nombre = p_nombre;
    
    IF v_count > 0 THEN
        SELECT 'Ya existe un artículo con el mismo nombre' AS mensaje;
    ELSEIF INSTR(p_texto, 'hola') > 0 THEN
        SELECT 'El texto del artículo no puede contener la palabra hola' AS mensaje;
    ELSE
        INSERT INTO articulos (nombre, texto, fecha_creacion, categoria, Cod_Pagina)
        VALUES (p_nombre, p_texto, p_fecha_creacion, p_categoria, p_cod_pagina);
    
        IF ROW_COUNT() > 0 THEN
            SELECT 'Articulo agregado correctamente' AS mensaje;
        ELSE
            SELECT 'Ocurrió un error inesperado al agregar el Articulo' AS mensaje;
        END IF;
    END IF;
END//

DELIMITER ;