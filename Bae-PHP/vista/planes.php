<!DOCTYPE html>
<html lang="en">
    <head>
        <?php

            include_once('../componentes/head.php');
            require_once('../modelo/planes.php');

            $id = $_GET['id'];

        ?>
        <title>Planes</title>
    </head>
    <body class="bg-dark">

        <nav class="navbar bg-dark border-bottom sticky-top" data-bs-theme="dark">
            <div class="container-fluid">
                <a href="../index.php" class="navbar-brand fw-bold">WHITEWINGS</a>
                <div class="grid gap-0">
                    <a href='../vista/planes/agregar_planes.php?id=<?php echo $id ?>' class="text-decoration-none text-light p-2"><button class="btn btn-outline-light" type="submit">Agregar Plan</button></a>
                </div>
            </div>
        </nav>

        <?php

            @$mensaje = $_GET['mensaje'];

            if (isset($mensaje)) {
                echo "<div class='alert alert-primary' style='position: fixed; bottom: 0; right: 20px;'>";
                echo $mensaje;
                echo "<br>";
                echo "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>";
                echo "</div>";
            }

            $planes = new Plan();
            $planes->setCod_Plan($id);
            $listaPlanes = $planes->listarPlanes();

            echo "<div class='container'>";
                echo "<div class='row'>";

                    foreach ($listaPlanes as $plan) {

                        echo "<div class='col-4'>";
                            echo "<div class='card mt-5'>";
                                echo "<div class='card-body'>";
                                    echo "<h5 class='card-title'>" . $plan->getNombre() . "</h5>";
                                    echo "<p class='card-text'> - Precio: $" . $plan->getPrecio() . "</p>";
                                    echo "<p class='card-text'> - Graficos: " . $plan->getNumGrafico() . "</p>";
                                    echo "<p class='card-text'> - Usuarios: " . $plan->getNumUsuario() . "</p>";
                                    echo "<p class='card-text'> - Indicadores: " . $plan->getNumIndicadores() . "</p>";
                                    echo "<a href='../vista/planes/editar_planes.php?cod_plan=" . $plan->getCod_Plan() . "&id=$id' class='btn btn-primary m-2'>Editar</a>";
                                    echo "<a href='../vista/planes/eliminar_planes.php?cod_plan=" . $plan->getCod_Plan() . "&id=$id' class='btn btn-danger'>Eliminar</a>";
                                echo "</div>";
                            echo "</div>";
                        echo "</div>";
                            
                    }

                echo "</div>";
            echo "</div>";

        ?>
    </body>
</html>