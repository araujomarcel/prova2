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
   
    public function produto_deletar($codigo){
        
    $sql = "DELETE FROM produto WHERE id=".$codigo;
      if($this->conn->query($sql) === TRUE){
          echo "Delete executado com sucesso";
      }

}
}

$codigo = $_POST['codigo'];
$DBMagico = new BancoDados;
$DBMagico->produto_deletar($codigo);

?>