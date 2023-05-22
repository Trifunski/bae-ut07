<!DOCTYPE html>
<html lang="es-ES">

    <head>
        
        <?php 
            include_once('../componentes/head.php');
            require_once('../modelo/articulo.php');
            require_once('../modelo/comentario.php');

            $id = $_GET['id'];
        ?>

        <title>Articulos</title>

    </head>
 
    <body class="bg-dark">

        <nav class="navbar bg-dark border-bottom sticky-top" data-bs-theme="dark">
            <div class="container-fluid">
                <a href="../index.php" class="navbar-brand fw-bold">WHITEWINGS</a>
                <div class="grid gap-0">
                    <a href="../vista/articulo/agregar_articulo.php?id=<?php echo $id ?>" class="text-decoration-none text-light p-2"><button class="btn btn-outline-light" type="submit">Agregar Articulo</button></a>
                </div>
            </div>
        </nav>

        <?php

            @$mensaje = $_GET['mensaje'];

            if (isset($mensaje)) {
                echo "<div class='alert alert-primary' style='position: fixed; bottom: 50px; right: 20px;'>";
                echo $mensaje;
                echo "<br>";
                echo "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>";
                echo "</div>";
            }

        ?>

        <br>

        <?php

            $articulo = new Articulo();
            $codPagina = $_GET['id'];
            $articulo->setCodPagina($codPagina);
            $listaArticulos = $articulo->listarArticulos();

            $numAleatorio = rand(1, 6);

            echo "<div class='container'>";
                echo "<div class='row'>";

                    foreach ($listaArticulos as $articulo) {
                            echo "<div class='card m-3' style='width: 18rem;'>";
                                echo "<img src='../img/imagen-" . $numAleatorio . ".jpg' style='margin-left: -12px; width: 286px; height: 300px; border-radius: 2%'>";
                                echo "<div class='card-body'>";
                                    echo "<h5 class='card-title'>" . $articulo->getNombre() . "</h5>";
                                    echo "<p class='card-text'>" . $articulo->getTexto() . "</p>";
                                    echo "<a href='../vista/articulo/editar_articulo.php?cod_articulo=" . $articulo->getCodArticulo() . "&id=$id' class='btn btn-primary m-1'><i class='bi bi-pencil-fill'></i></a>";
                                    echo "<a href='../vista/articulo/eliminar_articulo.php?cod_articulo=" . $articulo->getCodArticulo() . "&id=$id' class='btn btn-danger m-1'><i class='bi bi-trash-fill'></i></a>";
                                    echo "<a href='#' class='btn btn-success m-1' data-bs-toggle='modal' data-id='". $articulo->getCodArticulo() . "' data-bs-target='#modalComentarios'><i class='bi bi-chat'></i></a>";
                                    echo "<a href='../vista/comentario/agregar_comentario.php?id=" . $articulo->getCodArticulo() . "' class='btn btn-warning m-1'><i class='bi bi-plus-circle'></i></a>";
                                echo "</div>";
                                echo "<div class='card-footer'>";
                                    echo "<small class='text-muted'>" . $articulo->getFechaCreacion() . "</small>";
                                    echo "<small class='text-muted float-end'>" . $articulo->getCategoria() . "</small>";
                                echo "</div>";
                            echo "</div>";
                    }

                echo "</div>";

            echo "</div>";

        ?>

        <div class="modal fade" id="modalComentarios" tabindex="-1" role="dialog" aria-labelledby="modalComentariosLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalComentariosLabel">Comentarios</h5>
            </div>
            <div class="modal-body">
                <table class="table">
                <thead>
                    <tr>
                    <th scope="col">Código</th>
                    <th scope="col">Comentario</th>
                    <th scope="col">Fecha</th>
                    <th scope="col">Likes</th>
                    <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablaComentarios">
                    
                </tbody>
                </table>
            </div>
            </div>
        </div>
        </div>

        <div class="container-fluid bg-dark text-light text-center p-3 border-top" style="position: fixed; bottom: 0; width: 100%">
            <?php
                $articulo = new Articulo();
                $id = $_GET['id'];
                $totalArticulos = $articulo->totalArticulos($id);
                echo "Total de Articulos: " . $totalArticulos;
            ?>
        </div>

        <script>
            $(document).ready(function() {
                $('#modalComentarios').on('show.bs.modal', function (e) {
                    var id = $(e.relatedTarget).data('id');
                    $.ajax({
                        type : 'post',
                        url : '../componentes/tablaComentarios.php',
                        data :  {'data-id': id},
                        success : function(data){
                        console.log(id);
                        console.log(data);
                        var tabla = '';
                        
                        data.forEach(element => {
                            tabla += '<tr>';
                            tabla += '<td>' + element.codComentario + '</td>';
                            tabla += '<td>' + element.texto + '</td>';
                            tabla += '<td>' + element.fechaCreacion + '</td>';
                            tabla += '<td>' + element.likes + '</td>';

                            tabla += '<th>';
                            tabla += '<a href="../vista/comentario/editar_comentario.php?id=' + element.codComentario + '&texto=' + element.texto + '" class="btn btn-primary m-1"><i class="bi bi-pencil-fill"></i></a>';
                            tabla += '<a href="../vista/comentario/eliminar_comentario.php?id=' + element.codComentario + '" class="btn btn-danger m-1"><i class="bi bi-trash-fill"></i></a>';
                            tabla += '</th>';

                            tabla += '</tr>';
                            
                        });
                        
                        $('#tablaComentarios').html(tabla);
                        }
                    });
                });
            });
        </script>

    </body>
</html>