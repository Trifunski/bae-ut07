<!DOCTYPE html>
<html>

<?php
    include_once("../../componentes/head.php");
    require_once("../../modelo/articulo.php");
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

            <h1 class=" text-center">Agregar Articulo</h1>

            <?php

            if (
                isset($_POST['codpagina']) &&
                isset($_POST['nombre']) &&
                isset($_POST['texto']) &&
                isset($_POST['categoria'])
            ) {
                $cod_pagina = $_POST['codpagina'];
                $nombre = $_POST['nombre'];
                $texto = $_POST['texto'];
                $categoria = $_POST['categoria'];

                $articulo = new Articulo();
                $articulo->setNombre($nombre);
                $articulo->setTexto($texto);
                $articulo->setFechaCreacion(date("Y-m-d"));
                $articulo->setCategoria($categoria);
                $articulo->agregarArticulo($cod_pagina);
            }

            ?>
            <div class="container">
                <form action="agregar_articulo.php" method="post">

                    <div class="d-none">
                        <label>Codigo Pagina</label>
                        <input type="text" class="form-control" name="codpagina" value="<?php echo $_GET['id'] ?>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" class="form-control" name="nombre" required>
                    </div>

                    <div class="form-group">
                        <label>Texto</label>
                        <input type="text" class="form-control" name="texto" required>
                    </div>

                    <br>

                    <div class="form-group">
                        <label>Categoria</label>
                        <select class="custom-select rounded" name="categoria" required>
                            <option>Elegir Categoria...</option>
                            <option value="Forex">Forex</option>
                            <option value="Criptomonedas">Criptomonedas</option>
                            <option value="Acciones">Acciones</option>
                            <option value="Futuros">Futuros</option>
                            <option value="Bonos">Bonos</option>
                        </select>
                    </div>

                    <br>

                    <button type="submit" class="btn btn-primary">Crear Articulo</button>
                </form>
            </div>
            <br>
        </div>
    </div>
</body>
