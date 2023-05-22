<!DOCTYPE html>
<html lang="es-ES">
    <head>
        
        <?php 
            include_once 'componentes/head.php';
            require_once 'modelo/paginaweb.php';
        ?>

        <title>WhiteWings</title>
    </head>
    <body class="bg-dark">
        <nav class="navbar bg-dark border-bottom sticky-top" data-bs-theme="dark">
            <div class="container-fluid">
                <a href="#" class="navbar-brand fw-bold">WHITEWINGS</a>
                <div class="grid gap-0">
                    <a href="vista/paginaweb/agregar_paginaweb.php" class="text-decoration-none text-light p-2"><button class="btn btn-outline-light" type="submit">Agregar Pagina</button></a>
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

            $paginaWeb = new PaginaWeb();
            $listaPaginas = $paginaWeb->listarPaginas();

            echo "<div class='container'>";
                echo "<div class='row'>";

                    foreach ($listaPaginas as $pagina) {

                            if ($pagina->getEstado() == 1) {
                                echo "<div class='card m-3 bg-success' style='width: 18rem;'>";
                                echo "<div class='card-body'>";
                                    echo "<h5 class='card-title'>" . $pagina->getNombre() . "</h5>";
                                    echo "<a href='vista/paginaweb/editar_paginaweb.php?id=" . $pagina->getCod_pagina() . "' class='btn btn-primary m-1'><i class='bi bi-pencil-fill'></i></a>";
                                    echo "<a href='vista/paginaweb/eliminar_paginaweb.php?id=" . $pagina->getCod_pagina() . "' class='btn btn-warning m-1'><i class='bi bi-trash-fill'></i></a>";
                                    echo "<a href='vista/index.php?id=" . $pagina->getCod_pagina() . "' class='btn btn-danger m-1'><i class='bi bi-blockquote-left'></i></a>";
                                    echo "<a href='vista/planes.php?id=" . $pagina->getCod_pagina() . "' class='btn btn-danger m-1'><i class='bi bi-diagram-3'></i></a>";
                                echo "</div>";
                                echo "</div>";
                            } else {
                                echo "<div class='card m-3 bg-danger' style='width: 18rem;'>";
                                echo "<div class='card-body'>";
                                    echo "<h5 class='card-title'>" . $pagina->getNombre() . "</h5>";
                                    echo "<a href='vista/paginaweb/editar_paginaweb.php?id=" . $pagina->getCod_pagina() . "' class='btn btn-primary m-1'><i class='bi bi-pencil-fill'></i></a>";
                                    echo "<a href='vista/paginaweb/eliminar_paginaweb.php?id=" . $pagina->getCod_pagina() . "' class='btn btn-warning m-1'><i class='bi bi-trash-fill'></i></a>";
                                echo "</div>";
                                echo "</div>";
                            }

                            
                    }

                echo "</div>";
            echo "</div>";

        ?>

    </body>
</html>