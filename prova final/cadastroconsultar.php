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



    

    public function consultar_produto(){
        
       $query = "SELECT * from produto ";
       $result = mysql_query($query);
         while($fetch = mysql_fetch_row($result)){
            echo "<p>". $fetch[0] . " - " . $fetch[1] . " - " . "</p>";
    }
    }
}
?>