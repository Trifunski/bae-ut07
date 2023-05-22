<?php

require_once 'C:\xampp\htdocs\Bae-PHP\db\db.php';

class PaginaWeb {

    private $db;
    private $Cod_Pagina;
    private $Nombre;
    private $Estado;

    function __construct() {
        $bd = new bd();
        $this->db = $bd->conectarBD();
    }

    public function listarPaginas() { 
        try {
            $querySelect = "CALL listar_pagina()";
            $listarPaginas = $this->db->prepare($querySelect);

            $listarPaginas->execute(); 

            if($listarPaginas){
                return $listarPaginas->fetchAll(PDO::FETCH_CLASS, "paginaWeb");
            }else{
                echo "Ocurrió un error inesperado al listar las Paginas";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    public function obtenerPagina() {
        try {
            $querySelect = "CALL obtener_pagina(:cod_pagina)";
            $obtenerPagina = $this->db->prepare($querySelect);

            $obtenerPagina->bindParam(":cod_pagina", $this->Cod_Pagina);

            $obtenerPagina->execute();

            $resultado = $obtenerPagina->fetchAll(PDO::FETCH_CLASS, "paginaWeb")[$this->Cod_Pagina - 1];

            if ($resultado !== false) {
                return $resultado;
            } else {
                $error = $obtenerPagina->errorInfo();
                echo "Ocurrió un error inesperado al obtener la Pagina: " . $error[2];
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    public function agregarPagina() {
        try {
            $queryInsert = "CALL agregar_pagina(:nombre, :estado)";
            $agregarPagina = $this->db->prepare($queryInsert);

            $agregarPagina->bindParam(":nombre", $this->Nombre);
            $agregarPagina->bindParam(":estado", $this->Estado);

            $agregarPagina->execute();

            $respuesta = $agregarPagina->fetch(PDO::FETCH_ASSOC);

            if($respuesta){
                header("Location: ../../index.php?mensaje=" . $respuesta['mensaje']);
            }else{
                echo "Ocurrió un error inesperado al agregar la Pagina";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
            return false;
        }
    }

    public function modificarPagina() {
        try {
            $queryUpdate = "CALL modificar_pagina(:cod_pagina, :nombre, :estado)";
            $modificarPagina = $this->db->prepare($queryUpdate);

            $modificarPagina->bindParam(":cod_pagina", $this->Cod_Pagina);
            $modificarPagina->bindParam(":nombre", $this->Nombre);
            $modificarPagina->bindParam(":estado", $this->Estado);

            $modificarPagina->execute();

            if($modificarPagina){
                echo "Pagina modificada correctamente";
                header("Location: ../../index.php");
            }else{
                echo "Ocurrió un error inesperado al modificar la Pagina";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
            return false;
        }
    }

    public function eliminarPagina() {
        try {
            $queryDelete = "DELETE FROM paginaweb WHERE cod_pagina = :cod_pagina";
            $eliminarPagina = $this->db->prepare($queryDelete);

            $eliminarPagina->bindParam(":cod_pagina", $this->Cod_Pagina);

            $eliminarPagina->execute();

            if($eliminarPagina){
                echo "Pagina eliminada correctamente";
                header("Location: ../../index.php");
            }else{
                echo "Ocurrió un error inesperado al eliminar la Pagina";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
            return false;
        }
    }

    function getCod_pagina() {
        return $this->Cod_Pagina;
    }

    function getNombre() {
        return $this->Nombre;
    }

    function getEstado() {
        return $this->Estado;
    }

    function setCod_pagina($cod_pagina): void {
        $this->Cod_Pagina = $cod_pagina;
    }

    function setNombre($nombre): void {
        $this->Nombre = $nombre;
    }

    function setEstado($estado): void {
        $this->Estado = $estado;
    }
    
}