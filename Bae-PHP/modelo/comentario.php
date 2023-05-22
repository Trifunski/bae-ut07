<?php

require_once 'C:\xampp\htdocs\Bae-PHP\db\db.php';

class Comentario {
        private $db;
        private $cod_comentario;
        private $texto;
        private $fecha_creacion;
        private $likes;
        private $cod_articulo;

        function __construct() { 
            $bd = new bd();
            $this->db = $bd->conectarBD();
        }

        public function listarComentarios($id) {
            try {
                $querySelect = "CALL listar_comentario(:id)";
                $listaComentarios = $this->db->prepare($querySelect);

                $listaComentarios->bindParam(":id", $id);

                $listaComentarios->execute();

                if($listaComentarios){
                    return $listaComentarios->fetchAll(PDO::FETCH_CLASS, "comentario");
                }else{
                    echo "Ocurrió un error inesperado al obtener el Listado de Comentarios";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }

        public function obtenerComentario() {
            try {
                $querySelect = "CALL obtener_comentario(:cod_comentario)";
                $obtenerComentario = $this->db->prepare($querySelect);

                $obtenerComentario->bindParam(":cod_comentario", $this->cod_comentario);

                $obtenerComentario->execute();

                if($obtenerComentario){
                    return $obtenerComentario->fetchAll(PDO::FETCH_CLASS, "comentario");
                }else{
                    echo "Ocurrió un error inesperado al obtener el Comentario";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }

        public function agregarComentario() {
            try {     
                $queryInsert = "CALL agregar_comentario(:texto, :fecha_creacion, :likes, :cod_articulo)";
                $insertarArticulo = $this->db->prepare($queryInsert);

                $insertarArticulo->bindParam(":texto", $this->texto);
                $insertarArticulo->bindParam(":fecha_creacion", $this->fecha_creacion);
                $insertarArticulo->bindParam(":likes", $this->likes);
                $insertarArticulo->bindParam(":cod_articulo", $this->cod_articulo);

                $insertarArticulo->execute();

                if($insertarArticulo){
                    echo "Articulo agregado correctamente";
                    header("Location:../index.php");
                }else{
                    echo "Ocurrió un error inesperado al agregar el Articulo";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
            }
        }

        public function editarComentario() {
            try {
                $queryUpdate = "CALL editar_comentario(:cod_comentario, :texto)";
                $editarComentario = $this->db->prepare($queryUpdate);

                $editarComentario->bindParam(":cod_comentario", $this->cod_comentario);
                $editarComentario->bindParam(":texto", $this->texto);

                $editarComentario->execute();

                if($editarComentario){
                    echo "Comentario editado correctamente";
                    header("Location:../index.php");
                }else{
                    echo "Ocurrió un error inesperado al editar el Comentario";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
            }
        }

        public function eliminarComentario() {
            try {
                $queryDelete = "CALL eliminar_comentario(:cod_comentario)";
                $eliminarComentario = $this->db->prepare($queryDelete);

                $eliminarComentario->bindParam(":cod_comentario", $this->cod_comentario);

                $eliminarComentario->execute();

                if($eliminarComentario){
                    echo "Comentario eliminado correctamente";
                    header("Location:../index.php");
                }else{
                    echo "Ocurrió un error inesperado al eliminar el Comentario";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
            }
        } 

        function getCodComentario() {
            return $this->cod_comentario;
        }

        function getTexto() {
            return $this->texto;
        }

        function getFechaCreacion() {
            return $this->fecha_creacion;
        }

        function getLikes() {
            return $this->likes;
        }

        function getCodArticulo() {
            return $this->cod_articulo;
        }

        function setCodComentario($cod_comentario) {
            $this->cod_comentario = $cod_comentario;
        }

        function setTexto($texto) {
            $this->texto = $texto;
        }

        function setFechaCreacion($fecha_creacion) {
            $this->fecha_creacion = $fecha_creacion;
        }

        function setLikes($likes) {
            $this->likes = $likes;
        }

        function setCodArticulo($cod_articulo) {
            $this->cod_articulo = $cod_articulo;
        }

}

?>