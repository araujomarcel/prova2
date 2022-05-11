<?php

class BancoDados{
    private $servername = '127.0.0.1';
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



    public function adicionar_produto($codigo, $descricao, $marca, $preco, $estoque, $marca){
        
            $sql = "INSERT INTO produto ( `id`, `descricao`, `precovenda`, `estoque`, `marca`) ";
            $sql = $sql."VALUES ('".$codigo."', '".$descricao."', ".$preco.", '".$estoque ."', '".$marca."')";
           
           
           
            if (mysqli_query($this->conn, $sql)) {
                echo "Cadastro feito com sucesso";
            } else {
                echo "Error: " . $sql . "<br>" . mysqli_error($conn);
            }
        }
        
    

    public function consultar_produto($codigo){
        
        $query = sprintf("SELECT codigo, descricao, marca, precoatual, estoque FROM produto where $codigo");
        $dados = mysql_query($query, $con) or die(mysql_error());
    }

    public function atualizar_produto($codigo, $descricao, $marca, $preco, $estoque, $marca){
        mysqli_query("UPDATE pessoas SET idade = '36' WHERE nome = 'Pedro'");
        mysqli_close($con);


    }
       


}









$codigo = $_POST['codigo'];
echo"111111111111111"
$descricao = $_POST['descricao'];
$marca = $_POST['marca'];
$preco = $_POST['preco'];
$estoque = $_POST['estoque'];
print_r ($_POST);
die();
$DBMagico = new BancoDados;
$DBMagico->adicionar_cliente($codigo, $descricao, $marca, $preco, $estoque);

?>