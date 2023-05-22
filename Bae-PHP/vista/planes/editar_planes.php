<!DOCTYPE html>
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/planes.php";
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

            <h1 class=" text-center">Editar Pagina Web</h1>

            <?php

            if (isset($_GET['cod_plan']) && !empty($_GET['cod_plan'])) {
                $cod_plan = $_GET['cod_plan'];
                $planes = new Plan();
                $planes->setCod_Plan($cod_plan);
                $plan = $planes->obtenerPlan();            
            }

            if (
                isset($_POST['cod_plan']) &&
                isset($_POST['nombre']) &&
                isset($_POST['precio']) &&
                isset($_POST['numGrafico']) &&
                isset($_POST['numUsuario']) &&
                isset($_POST['numIndicadores'])
            ) {
                $id = $_POST['id'];
                $cod_plan = $_POST['cod_plan'];
                $nombre = $_POST['nombre'];
                $precio = $_POST['precio'];
                $numGrafico = $_POST['numGrafico'];
                $numUsuario = $_POST['numUsuario'];
                $numIndicadores = $_POST['numIndicadores'];

                $planes = new Plan();

                $planes->setCod_Plan($cod_plan);
                $planes->setNombre($nombre);
                $planes->setPrecio($precio);
                $planes->setNumGrafico($numGrafico);
                $planes->setNumUsuario($numUsuario);
                $planes->setNumIndicadores($numIndicadores);

                echo $planes->modificarPlan($id);
            }

            ?>

            <div class="container">
                <form action="editar_planes.php" method="post">

                    <div class="d-none">
                        <label>Id</label>
                        <input type="text" class="form-control" name="id" value="<?php echo $_GET['id']; ?>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Id</label>
                        <input type="text" class="form-control" name="cod_plan" value="<?php echo $plan->getCod_Plan(); ?>" readonly>
                    </div>

                    <br>
                    
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" class="form-control" name="nombre" value="<?php echo $plan->getNombre(); ?>" required>
                    </div>

                    <br>

                    <div class="form-group">
                        <label>Precio</label>
                        <input type="text" class="form-control" name="precio" value="<?php echo $plan->getPrecio(); ?>" required>
                    </div>

                    <br>

                    <div class="form-group">
                        <label>Numero de Graficos</label>
                        <input type="text" class="form-control" name="numGrafico" value="<?php echo $plan->getNumGrafico(); ?>" required>
                    </div>

                    <br>

                    <div class="form-group">
                        <label>Numero de Usuarios</label>
                        <input type="text" class="form-control" name="numUsuario" value="<?php echo $plan->getNumUsuario(); ?>" required>
                    </div>

                    <br>

                    <div class="form-group">
                        <label>Numero de Indicadores</label>
                        <input type="text" class="form-control" name="numIndicadores" value="<?php echo $plan->getNumIndicadores(); ?>" required>
                    </div>

                    <br>

                    <button type="submit" class="btn btn-primary">Editar Articulo</button>
                </form>
            </div>
            <br>
        </div>
    </div>
</body>