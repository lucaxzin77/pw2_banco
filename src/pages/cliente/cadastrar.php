<?php

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Cliente</title>
    <link rel="stylesheet" href="src/css/cliente.css">
</head>

<body>
    <h1>Cadastrar Cliente</h1>
    <div>
        <form method="post" >
            <label for="nome">Nome</label>
            <input type="text" id="nome" name="nome" required>
    
            <label for="senha">Senha</label>
            <input type="password" id="senha" name="senha" required>
    
            <label for="telefone">Telefone</label>
            <input type="tel" id="telefone" name="telefone" required>
    
            <label for="endereco">Endereço</label>
            <input type="text" id="endereco" name="endereco" required>
    
            <button type="submit">Cadastrar</button>
    
        </form>
    </div>
</body>

</html>