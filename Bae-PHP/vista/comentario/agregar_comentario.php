<!DOCTYPE html> 
<html>

<?php
    include "../../componentes/head.php";
    require "../../modelo/comentario.php";
?>

<body class="bg-dark text-light">

    <nav class="navbar bg-dark border-bottom sticky-top" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold">WHITEWINGS</a>
            <a href="../index.php" class="text-decoration-none text-light"><button class="btn btn-outline-light" type="submit">Volver al inicio</button></a>
        </div>
    </nav>

    <div class="container-fluid position-absolute mt-5">
        <div class="jumbotron">

            <h1 class=" text-center">Crear Comentario</h1>

            <?php

            if (
                isset($_POST['texto']) &&
                isset($_POST['id'])

            ) {
                $texto = $_POST['texto'];
                $id = $_POST['id'];

                $comentario = new Comentario();
                $comentario->setCodArticulo($id);
                $comentario->setTexto($texto);
                $comentario->setFechaCreacion(date("Y-m-d"));
                $comentario->agregarComentario();
            }

            ?>

            <div class="container">
                
            <form action="agregar_comentario.php" method="post">

                    <div class="form-group">
                        <label>Articulo</label>
                        <input type="text" class="form-control" name="id" value="<?php echo $_GET['id']; ?>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Texto</label>
                        <input type="text" class="form-control" name="texto" required>
                    </div>

                    <br>

                    <button type="submit" class="btn btn-primary">Crear Comentario</button>
                </form>

            <div>

            <br>
        </div>
    </div>
</body>
