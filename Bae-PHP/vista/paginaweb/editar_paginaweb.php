<!DOCTYPE html>
<html>

<?php
    include_once("../../componentes/head.php");
    require_once("../../modelo/paginaweb.php");
?>

<body class="bg-dark text-light">

    <nav class="navbar bg-dark border-bottom sticky-top" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold">WHITEWINGS</a>
            <a href="../../index.php" class="text-decoration-none text-light"><button class="btn btn-outline-light" type="submit">Volver al inicio</button></a>
        </div>
    </nav>

    <div class="container-fluid position-absolute mt-5">
        <div class="jumbotron">

            <h1 class=" text-center">Editar Pagina Web</h1>

            <?php

            if (isset($_GET['id']) && !empty($_GET['id'])) {
                $id = $_GET['id'];
                $paginas = new PaginaWeb();
                $paginas->setCod_pagina($id);
                $pagina = $paginas->obtenerPagina();            
            }

            if (
                isset($_POST['id']) &&
                isset($_POST['nombre']) &&
                isset($_POST['estado'])
            ) {
                $id = $_POST['id'];
                $nombre = $_POST['nombre'];
                $estado = $_POST['estado'];

                $pagina = new PaginaWeb();

                $pagina->setCod_pagina($id);
                $pagina->setNombre($nombre);
                $pagina->setEstado($estado);

                echo $pagina->modificarPagina();
            }

            ?>

            <div class="container">
                <form action="editar_paginaweb.php" method="post">


                    <div class="form-group">
                        <label>Id</label>
                        <input type="text" class="form-control" name="id" value="<?php echo $pagina->getCod_pagina() ?>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" class="form-control" name="nombre" value="<?php echo $pagina->getNombre() ?>" required>
                    </div>

                    <br>

                    <?php

                        $estados = array("1", "0");

                        echo "<div class='form-group'>";
                        echo "<label>Estado</label>";
                        echo "<select class='custom-select' name='estado' required>";

                        foreach ($estados as $estado) {
                            if ($estado == $pagina->getEstado()) {

                                if ($estado == 1) {
                                    $estado1 = "Activo";
                                } else {
                                    $estado1 = "Inactivo";
                                }

                                echo "<option value='$estado' selected>$estado1</option>";
                            } else {

                                if ($estado == 1) {
                                    $estado1 = "Activo";
                                } else {
                                    $estado1 = "Inactivo";
                                }

                                echo "<option value='$estado'>$estado1</option>";
                            }
                        }

                        echo "</select>";
                        echo "</div>";

                    ?>

                    <br>

                    <button type="submit" class="btn btn-primary">Crear Articulo</button>
                </form>
            </div>
            <br>
        </div>
    </div>
</body>
