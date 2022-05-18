<!DOCTYPE html>
<html lang="pt_BR">
<head>
    <meta charset="UTF-8">
    <title>Acessar</title>
    <style>
     <style type="text/css">
    /* Bloco de CSS inline */ 
        body{ 
            font: 14px sans-serif; 
            text-align: center;
            display: flex;
             
        }
        .btn-primary
        {margin-left: auto;
         margin-right: auto;
         width: 15em;
         display: flex center;
        
        }    
        .wrapper
        {
            box-shadow: 1px 1px gray, 1em 0 3em blue;
            margin-left: auto;
            margin-right: auto;
        }       
        
             

    </style>

    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Cadastro de Produto</h2>
        <p>Manutenção em Cadastro de Produtos.</p>
        <form action="cadastrodeletar.php" method="POST">
                <label>Codigo do Produto</label>
                <input type="text" name="codigo" value="" >             
                <br><br><br><br>
                <input type="submit" class="btn btn-primary" value="Deletar"> 
        </form>
    </div>    
</body>
</html>
