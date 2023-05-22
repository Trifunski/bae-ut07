CREATE PROCEDURE agregarComentario (
    IN p_texto VARCHAR(255),
    IN p_fecha_creacion DATETIME,
    IN p_likes INT,
    IN p_cod_articulo INT
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        SELECT 'Ocurrió un error: ', MYSQL_ERRNO, ' - ', MYSQL_ERROR;
    END;

    START TRANSACTION;
    
    INSERT INTO comentarios (texto, fecha_creacion, likes, cod_articulo)
    VALUES (p_texto, p_fecha_creacion, p_likes, p_cod_articulo);
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Comentario agregado correctamente';
    ELSE
        SELECT 'Ocurrió un error inesperado al agregar el Comentario';
    END IF;

    COMMIT;
END
