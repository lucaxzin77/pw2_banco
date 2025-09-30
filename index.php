<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BANCO</title>
    <link rel="shortcut icon" href="./src/assets/banco.png" type="image/x-icon">
</head>

<body>

    <?php

    if (isset($_GET['cadastrar']) && $_GET['cadastrar'] == 'cliente') {
        require_once "src/pages/cliente/cadastrar.php";
    } else {
        require_once "src/pages/home.html";
    }

    ?>

</body>

</html>