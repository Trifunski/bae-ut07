<?php

require_once 'C:\xampp\htdocs\Bae-PHP\db\db.php';

class Articulo {
        private $db;
        private $cod_articulo;
        private $nombre;
        private $texto;
        private $fecha_creacion;
        private $categoria;
        private $cod_pagina;
        private $cod_usuario = 1;

        function __construct() {
            $bd = new bd();
            $this->db = $bd->conectarBD();
        }

        public function listarArticulos() {
            try {
                $querySelect = "CALL listar_articulo(:cod_pagina)";
                $listaArticulos = $this->db->prepare($querySelect); 

                $listaArticulos->bindParam(":cod_pagina", $this->cod_pagina);

                $listaArticulos->execute();

                if($listaArticulos){
                    return $listaArticulos->fetchAll(PDO::FETCH_CLASS, "articulo");
                }else{
                    echo "Ocurrió un error inesperado al obtener el Listado de Articulos";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            } 
        }

        public function obtenerArticulo() {
            try {
                $querySelect = "CALL obtener_articulo(:cod_articulo)";
                $obtenerArticulo = $this->db->prepare($querySelect);

                $obtenerArticulo->bindParam(":cod_articulo", $this->cod_articulo);

                $obtenerArticulo->execute();

                if($obtenerArticulo){
                    return $obtenerArticulo->fetchAll(PDO::FETCH_CLASS, "articulo")[$this->cod_articulo - 1];
                }else{
                    echo "Ocurrió un error inesperado al obtener el Articulo";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }

        public function agregarArticulo($cod_pagina) {
            try {              
                $queryInsert = "CALL agregar_articulo(:nombre, :texto, :fecha_creacion, :categoria, :Cod_Pagina)";
                $insertarArticulo = $this->db->prepare($queryInsert);

                $insertarArticulo->bindParam(":nombre", $this->nombre);
                $insertarArticulo->bindParam(":texto", $this->texto);
                $insertarArticulo->bindParam(":fecha_creacion", $this->fecha_creacion);
                $insertarArticulo->bindParam(":categoria", $this->categoria);
                $insertarArticulo->bindParam(":Cod_Pagina", $cod_pagina);

                $insertarArticulo->execute();

                $resultado = $insertarArticulo->fetch(PDO::FETCH_ASSOC);

                if($resultado){
                    header("Location:../index.php" . "?id=" . $cod_pagina . "&mensaje=" . $resultado['mensaje']);
                }else{
                    echo "Ocurrió un error inesperado al agregar el Articulo";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
            }
        }

        public function eliminarArticulo($id) {
            try {
                $queryDelete = "CALL eliminar_articulo(:cod_articulo, @p_resultado)";
                $eliminarArticulo = $this->db->prepare($queryDelete);
        
                $eliminarArticulo->bindParam(":cod_articulo", $this->cod_articulo);
        
                $eliminarArticulo->execute();
        
                $eliminarArticulo->closeCursor();
        
                $queryResultado = "SELECT @p_resultado AS resultado";
                $resultadoStmt = $this->db->query($queryResultado);
                $resultado = $resultadoStmt->fetch(PDO::FETCH_ASSOC)['resultado'];
        
                if ($resultado === 'Articulo eliminado correctamente') {
                    header("Location:../index.php" . "?id=" . $id . "&mensaje=" . $resultado);
                } else {
                    echo "Ocurrió un error inesperado al eliminar el Articulo";
                }
            } catch (Exception $ex) {
                echo "Ocurrió un error: " . $ex->getMessage();
            }
        }
        

        public function modificarArticulo($id) {
            try {
                $queryUpdate = "CALL modificar_articulo(:cod_articulo, :nombre, :texto, :fecha_creacion, :categoria)";
                $modificarArticulo = $this->db->prepare($queryUpdate);

                $modificarArticulo->bindParam(":cod_articulo", $this->cod_articulo);
                $modificarArticulo->bindParam(":nombre", $this->nombre);
                $modificarArticulo->bindParam(":texto", $this->texto);
                $modificarArticulo->bindParam(":fecha_creacion", $this->fecha_creacion);
                $modificarArticulo->bindParam(":categoria", $this->categoria);

                $modificarArticulo->execute();

                if($modificarArticulo){
                    echo "Articulo modificado correctamente";
                    header("Location:../index.php?id=" . $id);
                }else{
                    echo "Ocurrió un error inesperado al modificar el Articulo";
                }
                
            } catch (Exception $ex){
                echo "Ocurrió un error: " . $ex->getMessage();
            }
        }

        public function totalArticulos($cod_pagina) {
            try {
                $querySelect = "CALL total_articulo(:cod_pagina)";
                $stmt = $this->db->prepare($querySelect);
                $stmt->bindParam(':cod_pagina', $cod_pagina, PDO::PARAM_INT);
                $stmt->execute();
        
                $datos = $stmt->fetch(PDO::FETCH_ASSOC);
                $cantidad = $datos['total_articulos'];
        
                if ($cantidad !== false) {
                    return $cantidad;
                } else {
                    echo "Ocurrió un error inesperado al obtener el total de Articulos";
                }
                    
            } catch (Exception $ex) {
                echo "Ocurrió un error: " . $ex->getMessage();
                return null;
            }
        }
        

        public function getCodArticulo() {
            return $this->cod_articulo;
        }

        public function getNombre() {
            return $this->nombre;
        }

        public function getTexto() {
            return $this->texto;
        }

        public function getFechaCreacion() {
            return $this->fecha_creacion;
        }

        public function getCategoria() {
            return $this->categoria;
        }

        public function getCodPagina() {
            return $this->cod_pagina;
        }

        public function setCodArticulo($id) {
            $this->cod_articulo = $id;
        }

        public function setNombre($nombre) {
            $this->nombre = $nombre;
        }

        public function setTexto($texto) {
            $this->texto = $texto;
        }

        public function setFechaCreacion($fecha_creacion) {
            $this->fecha_creacion = $fecha_creacion;
        }

        public function setCategoria($categoria) {
            $this->categoria = $categoria;
        }
        public function setCodPagina($id) {
            $this->cod_pagina = $id;
        }

    }

?>