<!DOCTYPE html> 
<html>

<?php
    include_once("../../componentes/head.php");
    require_once("../../modelo/comentario.php");
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
                isset($_POST['id']) &&
                isset($_POST['texto'])
            ) {
                $id = $_POST['id'];
                $texto = $_POST['texto'];

                $comentario = new Comentario();

                $comentario->setCodComentario($id);
                $comentario->setTexto($texto);

                echo $comentario->editarComentario();
            }

            ?>

            <div class="container">
                
                <form action="editar_comentario.php" method="post"> 

                    <div class="form-group">
                        <label>Articulo</label>
                        <input type="text" class="form-control" name="id" value="<?php echo $_GET['id']; ?>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Texto</label>
                        <input type="text" class="form-control" name="texto" value="<?php echo $_GET['texto']; ?>" required>
                    </div>

                    <br>

                    <button type="submit" class="btn btn-primary">Editar Comentario</button>

                </form>

            <div>

            <br>
        </div>
    </div>
</body>
