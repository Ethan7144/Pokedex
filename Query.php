<?php
$servername = “cssql.seattleu.edu";
$username = "ll_etarlov";
$password = "ll_etarlov";
// Create connection
$conn = mysqli_connect($servername, $username, $password);
// Check connection
if (!$conn) {
die("Connection failed: " . mysqli_connect_error());
}

$_Post["query"];
$sql = "";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
// output data of each row
while($row = mysqli_fetch_assoc($result)) {
echo "PokemonID: " . $row["Pokemon_ID"]. " | Pokemon Name: " . $row["Pokemon_Name"]. " | Pokemon Nature: " . 
$row["Pokemon_Nature"] . " | Type_ID: " . $row["TYPE_ID"] . "<br>";
}
} else {
echo "0 results";
}


// Free result set

mysqli_free_result($result);
mysqli_close($conn);
?> 