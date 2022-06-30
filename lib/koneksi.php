<?php 
header('Access-Control-Allow-Origin',"*");
headers('Access-Control-Allow-Methods: POST, GET, OPTIONS');
$servername = "localhost";
$username = "root"; // sesuaikan dengan username db masing-masing
$password = ""; // sesuaikan dengan password db masing-masing
$dbname   = "flutter";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname,3306);
 
// Check connection
if ($conn->connect_error) {
 die("Connection failed: " . $conn->connect_error);
}?>