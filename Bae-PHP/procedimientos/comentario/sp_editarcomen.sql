CREATE PROCEDURE editarComentario(
    IN p_cod_comentario INT,
    IN p_texto VARCHAR(255)
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        SELECT 'Ocurrió un error inesperado al editar el Comentario' AS message;
    END;

    UPDATE comentarios
    SET texto = p_texto
    WHERE cod_comentario = p_cod_comentario;

    IF ROW_COUNT() > 0 THEN
        SELECT 'Comentario editado correctamente' AS message;
    ELSE
        SELECT 'El Comentario no existe' AS message;
    END IF;
END
