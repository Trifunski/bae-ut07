CREATE PROCEDURE eliminarComentario
    @cod_comentario INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM comentarios WHERE cod_comentario = @cod_comentario;
        SELECT 'Comentario eliminado correctamente' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 'Ocurrió un error inesperado al eliminar el Comentario: ' + ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END
