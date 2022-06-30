<?php
header('Access-Control-Allow-Origin: *');
$servername = "localhost";
$username = "root"; // sesuaikan dengan username db masing-masing
$password = ""; // sesuaikan dengan password db masing-masing
$dbname   = "flutter";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
 
// Check connection
if ($conn->connect_error) {
 die("Connection failed: " . $conn->connect_error);
}
    $sql = "SELECT * FROM zodiac";
    $db_data = array();
 
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $conn->close();
?>
