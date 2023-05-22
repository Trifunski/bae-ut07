<!DOCTYPE html>
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/planes.php";
?>

<body>
    <h1>Borrar Plan: </h1>
    <br>

    <?php

        if (isset($_GET['cod_plan'])) {
            $cod_plan = $_GET['cod_plan'];
            $id = $_GET['id'];
            $plan = new Plan();
            $plan->setCod_plan($cod_plan);
            $plan->eliminarPlan($id);
        }

    ?>

</body>

</html> 