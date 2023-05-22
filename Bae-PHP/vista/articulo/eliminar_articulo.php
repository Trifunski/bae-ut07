<!DOCTYPE html>
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/articulo.php";
?>

<body>
    <h1>Borrar Articulo: </h1>
    <br>

    <?php

        if (isset($_GET['cod_articulo']) && !empty($_GET['cod_articulo'])) {
            $cod_articulo = $_GET['cod_articulo'];
            $id = $_GET['id'];
            $articulo = new Articulo();
            $articulo->setCodArticulo($cod_articulo);
            echo $articulo->eliminarArticulo($id);
        }

    ?>

</body>

</html> 