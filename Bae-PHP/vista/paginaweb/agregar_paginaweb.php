<!DOCTYPE html>
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/paginaweb.php";
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

            <h1 class=" text-center">Crear Pagina Web</h1>

            <?php

            if (
                isset($_POST['nombre']) &&
                isset($_POST['categoria'])
            ) {
                $nombre = $_POST['nombre'];
                $categoria = $_POST['categoria'];

                $pagina = new PaginaWeb();
                $pagina->setNombre($nombre);
                $pagina->setEstado($categoria);
                $pagina->agregarPagina();
            }

            ?>

            <div class="container">
                <form action="agregar_paginaweb.php" method="post">
                    
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" class="form-control" name="nombre" required>
                    </div>

                    <br>

                    <div class="form-group">
                        <label>Estado</label>
                        <select class="custom-select rounded" name="categoria" required>
                            <option>Elegir Estado...</option>
                            <option value="1">Activo</option>
                            <option value="0">Inactivo</option>
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
