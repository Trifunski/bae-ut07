<!DOCTYPE html>
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/paginaweb.php";
?>

<body>
    <h1>Borrar Comentario: </h1>
    <br>

    <?php

        if (isset($_GET['id'])) {
            $id = $_GET['id'];
            $pagina = new PaginaWeb();
            $pagina->setCod_pagina($id);
            $pagina->eliminarPagina();
        }

    ?>

</body>

</html> 