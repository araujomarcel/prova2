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

    public function produto_atualizar($codigo,$descricao){
        $sql = "UPDATE produto SET descricao=''.$descricao WHERE id=".$codigo;       
}
}
$codigo = $_POST['codigo'];
$descricao = $_POST['descricao'];
$DBMagico = new BancoDados;
$DBMagico->produto_atualizar($codigo,$descricao);
?>