<!DOCTYPE html>
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/articulo.php";
?>

<body class="bg-dark text-light">

    <nav class="navbar bg-dark border-bottom sticky-top" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold">WHITEWINGS</a>
            <a href="../index.php?id=<?php echo $_GET['id'] ?>" class="text-decoration-none text-light"><button class="btn btn-outline-light" type="submit">Volver al inicio</button></a>
        </div>
    </nav>

    <div class="container-fluid position-absolute mt-5">
        <div class="jumbotron">

            <h1 class=" text-center">Editar Articulo</h1>

            <?php

                if (isset($_GET['cod_articulo']) && !empty($_GET['cod_articulo'])) {
                    $cod_articulo = $_GET['cod_articulo'];
                    $articulos = new Articulo();
                    $articulos->setCodArticulo($cod_articulo);
                    $articulo = $articulos->obtenerArticulo();            
                }

                if (
                    isset($_POST['id']) &&
                    isset($_POST['cod_articulo']) &&
                    isset($_POST['nombre']) &&
                    isset($_POST['texto']) && 
                    isset($_POST['categoria'])

                ) {
                    $id = $_POST['id'];
                    $cod_articulo = $_POST['cod_articulo'];
                    $nombre = $_POST['nombre'];
                    $texto = $_POST['texto'];
                    $categoria = $_POST['categoria'];

                    $articulos = new Articulo();

                    $articulos->setCodArticulo($cod_articulo);
                    $articulos->setNombre($nombre);
                    $articulos->setTexto($texto);
                    $articulos->setFechaCreacion(date("Y-m-d"));
                    $articulos->setCategoria($categoria);
                    
                    echo $articulos->modificarArticulo($id);
                }

            ?>
            <div class="container">
                <form action="editar_articulo.php" method="post">

                    <div class="d-none">
                        <label>Id</label>
                        <input type="text" class="form-control" name="id" value="<?php echo $_GET["id"]; ?>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Id</label>
                        <input type="text" class="form-control" name="cod_articulo" value="<?php echo $articulo->getCodArticulo(); ?>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" class="form-control" name="nombre" value="<?php echo $articulo->getNombre(); ?>" required>
                    </div>

                    <div class="form-group">
                        <label>Texto</label>
                        <input type="text" class="form-control" name="texto" value="<?php echo $articulo->getTexto(); ?>" required>
                    </div>

                    <br>

                    <?php
                    $categorias = array("Forex", "Criptomonedas", "Acciones", "Futuros", "Bonos");

                    echo "<div class='form-group'>";
                    echo "<label>Categorias</label>";
                    echo "<select class='custom-select' name='categoria' required>";

                    foreach ($categorias as $categoria) {
                        if ($categoria == $articulo->getCategoria()) {
                            echo "<option value='$categoria' selected>$categoria</option>";
                        } else {
                            echo "<option value='$categoria'>$categoria</option>";
                        }
                    }

                    echo "</select>";
                    echo "</div>";
                ?>

                    <br>

                    <button type="submit" class="btn btn-primary">Editar Articulo</button>
                </form>
            </div>
            <br>
        </div>
    </div>
</body>