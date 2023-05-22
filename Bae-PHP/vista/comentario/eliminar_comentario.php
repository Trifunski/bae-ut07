<!DOCTYPE html> 
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/comentario.php";
?>

<body>
    <h1>Borrar Comentario: </h1>
    <br>

    <?php

        if (isset($_GET['id'])) {
            $id = $_GET['id'];
            $comentario = new Comentario();
            $comentario->setCodComentario($id);
            $comentario->eliminarComentario();
        }

    ?>

</body>

</html> 