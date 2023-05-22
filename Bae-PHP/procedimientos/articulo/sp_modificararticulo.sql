CREATE PROCEDURE modificarArticulo
(
    IN p_cod_articulo INT,
    IN p_nombre VARCHAR(255),
    IN p_texto TEXT,
    IN p_fecha_creacion DATE,
    IN p_categoria VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT CONCAT('Ocurrió un error: ', MYSQL_ERRNO(), ' - ', MYSQL_ERROR()) AS ErrorMessage;
    END;

    UPDATE articulos
    SET nombre = p_nombre,
        texto = p_texto,
        fecha_creacion = p_fecha_creacion,
        categoria = p_categoria
    WHERE cod_articulo = p_cod_articulo;

    IF ROW_COUNT() > 0 THEN
        SELECT 'Articulo modificado correctamente' AS Message;
    ELSE
        SELECT 'No se encontró el Articulo con el código especificado' AS Message;
    END IF;
END
