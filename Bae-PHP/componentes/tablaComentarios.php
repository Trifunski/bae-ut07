<?php

    require_once '../modelo/comentario.php';

    $comentarios = new Comentario();

    $id = $_POST['data-id'];

    $listaComentarios = $comentarios->listarComentarios($id);
    $comentariosArray = array();
    if ($listaComentarios) {
        foreach ($listaComentarios as $comentario) {
        $comentarioArray = array(
            'codComentario' => $comentario->getCodComentario(),
            'texto' => $comentario->getTexto(),
            'fechaCreacion' => $comentario->getFechaCreacion(),
            'likes' => $comentario->getLikes()
        );
        array_push($comentariosArray, $comentarioArray);
        }
    }
    header('Content-Type: application/json');
    echo json_encode($comentariosArray);
?>

 