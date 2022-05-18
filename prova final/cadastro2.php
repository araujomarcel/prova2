<?php

class BancoDados{
    private $servername = 'localhost';
    private $username = 'root';
    private $password = '';
    private $dbname = 'empresa2';
    private $conn;

    public function __construct(){
        $this->conn = mysqli_connect($this->servername, $this->username, $this->password, $this->dbname);
        if (!$this->conn) {
            die("Connection failed: " . mysqli_connect_error());
        }
    }
    
    public function __destruct(){
        mysqli_close($this->conn);
    }



    public function adicionar_produto($codigo, $descricao, $marca, $preco, $estoque){
        
            $sql = "INSERT INTO produto ( id, descricao, precodevenda, estoque, marca) ";
            $sql = $sql."VALUES (".$codigo.", '".$descricao."', ".$preco.", ".$estoque .", '".$marca."')";
           
           
           
            if (mysqli_query($this->conn, $sql)) {
                echo "Cadastro feito com sucesso";
            } else {
                echo "Error: " .$sql. "<br>" . mysqli_error($this->conn);
            }
        }
        
    



  
    

}

$codigo = $_POST['codigo'];
$descricao = $_POST['descricao'];
$marca = $_POST['marca'];
$preco = $_POST['preco'];
$estoque = $_POST['estoque'];
$DBMagico = new BancoDados;
$DBMagico->adicionar_produto($codigo, $descricao, $marca, $preco, $estoque);
?>