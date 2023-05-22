<!DOCTYPE html>
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/planes.php";
    $plan = new Plan();
?>

<body class="bg-dark text-light">

    <nav class="navbar bg-dark border-bottom sticky-top" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold">WHITEWINGS</a>
            <a href="../planes.php?id=<?php echo $_GET["id"] ?>" class="text-decoration-none text-light"><button class="btn btn-outline-light" type="submit">Volver al inicio</button></a>
        </div>
    </nav>

    <div class="container-fluid position-absolute mt-5">
        <div class="jumbotron">

            <h1 class=" text-center">Crear Pagina Web</h1>

            <?php

            $id = $_GET['id'];

            if (
                isset($_POST['id']) &&
                isset($_POST['nombre']) &&
                isset($_POST['precio']) &&
                isset($_POST['numGrafico']) &&
                isset($_POST['numUsuario']) &&
                isset($_POST['numIndicadores'])

            ) {
                $id = $_POST['id'];
                $nombre = $_POST['nombre'];
                $precio = $_POST['precio'];
                $numGrafico = $_POST['numGrafico'];
                $numUsuario = $_POST['numUsuario'];
                $numIndicadores = $_POST['numIndicadores'];

                
                $plan->setCod_Plan($id);
                $plan->setNombre($nombre);
                $plan->setPrecio($precio);
                $plan->setNumGrafico($numGrafico);
                $plan->setNumUsuario($numUsuario);
                $plan->setNumIndicadores($numIndicadores);
                $plan->agregarPlan($id);
            }

            ?>

            <div class="container">
                <form action="agregar_planes.php" method="post">

                    <div>
                        <label>Id</label>
                        <input type="text" class="form-control" name="id" value="<?php echo $_GET['id']; ?>" readonly>
                    </div>

                    <br>
                    
                    <div>
                        <label>Nombre</label>
                        <input type="text" class="form-control" name="nombre" required>
                    </div>

                    <br>

                    <div>
                        <label>Precio</label>
                        <input type="text" class="form-control" name="precio" required>
                    </div>

                    <br>

                    <div>
                        <label>Numero de Graficos</label>
                        <input type="text" class="form-control" name="numGrafico" required>
                    </div>

                    <br>

                    <div>
                        <label>Numero de Usuarios</label>
                        <input type="text" class="form-control" name="numUsuario" required>
                    </div>

                    <br>

                    <div>
                        <label>Numero de Indicadores</label>
                        <input type="text" class="form-control" name="numIndicadores" required>
                    </div>

                    <br>

                    <button type="submit" class="btn btn-primary">Crear Articulo</button>
                </form>
            </div>
            <br>
        </div>
    </div>
</body>