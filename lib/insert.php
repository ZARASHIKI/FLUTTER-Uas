<?php 
header('Access-Control-Allow-Origin',"*");
require ("koneksi.php");
    $id =$_POST['id'];
    $name = $_POST['name'];
    $date = $_POST['date'];
    $desc = $_POST['description'];
    $conn->query("INSERT INTO zodiac VALUE ('".$name."')");
 ?>