<?php

require_once 'C:\xampp\htdocs\Bae-PHP\db\db.php';

class Plan {

    private $db;
    private $Cod_Plan;
    private $Nombre;
    private $Precio;
    private $NumGrafico;
    private $NumUsuario;
    private $NumIndicadores; 
    private $TiempoActivo;


    function __construct() {
        $bd = new bd();
        $this->db = $bd->conectarBD();
    }

    public function listarPlanes() {
        try {
            $querySelect = "CALL listar_plan(:Cod_Plan)";
            $listarPlanes = $this->db->prepare($querySelect);

            $listarPlanes->bindParam(":Cod_Plan", $this->Cod_Plan);

            $listarPlanes->execute();

            if($listarPlanes){
                return $listarPlanes->fetchAll(PDO::FETCH_CLASS, "plan");
            }else{
                echo "Ocurrió un error inesperado al listar los Planes";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    public function obtenerPlan() {
        try {
            $querySelect = "SELECT * FROM planes WHERE Cod_Plan = :Cod_Plan";
            $obtenerPlan = $this->db->prepare($querySelect);

            $obtenerPlan->bindParam(":Cod_Plan", $this->Cod_Plan);

            $obtenerPlan->execute();

            if($obtenerPlan){
                return $obtenerPlan->fetchAll(PDO::FETCH_CLASS, "plan")[0];
            }else{
                echo "Ocurrió un error inesperado al obtener el Plan";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
            return null;
        }
    }

    public function agregarPlan($codpagina) {
        try {
            $queryInsert = "CALL agregar_plan(:Nombre, :Precio, :NumGrafico, :NumUsuario, :NumIndicadores, :Cod_Pagina)";
            $agregarPlan = $this->db->prepare($queryInsert);

            echo $codpagina;

            $agregarPlan->bindParam(":Nombre", $this->Nombre);
            $agregarPlan->bindParam(":Precio", $this->Precio);
            $agregarPlan->bindParam(":NumGrafico", $this->NumGrafico);
            $agregarPlan->bindParam(":NumUsuario", $this->NumUsuario);
            $agregarPlan->bindParam(":NumIndicadores", $this->NumIndicadores);
            $agregarPlan->bindParam(":Cod_Pagina", $codpagina);

            $agregarPlan->execute();

            $resultado = $agregarPlan->fetch(PDO::FETCH_ASSOC);

            if($resultado){
                echo "Plan agregado correctamente";
                header("Location: ../../vista/planes.php?id=" . $codpagina);
            }else{
                echo "Ocurrió un error inesperado al agregar el Plan";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
        }
    }

    public function modificarPlan($id) {
        try {
            $queryUpdate = "CALL modificar_plan(:CodPlan, :Nombre, :Precio, :NumGrafico, :NumUsuario, :NumIndicadores)";
            $modificarPlan = $this->db->prepare($queryUpdate);

            $modificarPlan->bindParam(":CodPlan", $this->Cod_Plan);
            $modificarPlan->bindParam(":Nombre", $this->Nombre);
            $modificarPlan->bindParam(":Precio", $this->Precio);
            $modificarPlan->bindParam(":NumGrafico", $this->NumGrafico);
            $modificarPlan->bindParam(":NumUsuario", $this->NumUsuario);
            $modificarPlan->bindParam(":NumIndicadores", $this->NumIndicadores);

            $modificarPlan->execute();

            if($modificarPlan){
                echo "Plan modificado correctamente";
                header("Location: ../../vista/planes.php?id=" . $id);
            }else{
                echo "Ocurrió un error inesperado al modificar el Plan";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
        }
    }

    public function eliminarPlan($id) {
        try {
            $queryDelete = "CALL eliminar_plan(:Cod_Plan)";
            $eliminarPlan = $this->db->prepare($queryDelete);

            $eliminarPlan->bindParam(":Cod_Plan", $this->Cod_Plan);

            $eliminarPlan->execute();

            if($eliminarPlan){
                echo "Plan eliminado correctamente";
                header("Location: ../../vista/planes.php?id=" . $id);
            }else{
                echo "Ocurrió un error inesperado al eliminar el Plan";
            }
            
        } catch (Exception $ex){
            echo "Ocurrió un error: " . $ex->getMessage();
        }
    }

    function getCod_Plan() {
        return $this->Cod_Plan;
    }

    function getNombre() {
        return $this->Nombre;
    }

    function getPrecio() {
        return $this->Precio;
    }

    function getNumGrafico() {
        return $this->NumGrafico;
    }

    function getNumUsuario() {
        return $this->NumUsuario;
    }

    function getNumIndicadores() {
        return $this->NumIndicadores;
    }

    function getTiempoActivo() {
        return $this->TiempoActivo;
    }

    function setCod_Plan($Cod_Plan) {
        $this->Cod_Plan = $Cod_Plan;
    }

    function setNombre($Nombre) {
        $this->Nombre = $Nombre;
    }

    function setPrecio($Precio) {
        $this->Precio = $Precio;
    }

    function setNumGrafico($NumGrafico) {
        $this->NumGrafico = $NumGrafico;
    }

    function setNumUsuario($NumUsuario) {
        $this->NumUsuario = $NumUsuario;
    }

    function setNumIndicadores($NumIndicadores) {
        $this->NumIndicadores = $NumIndicadores;
    }

    function setTiempoActivo($TiempoActivo) {
        $this->TiempoActivo = $TiempoActivo;
    }
    
}