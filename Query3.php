<?php
$servername = "cssql.seattleu.edu";
$username = "ll_etarlov";
$password = "ll_etarlov";
$dbname = "ll_etarlov";
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
die("Connection failed: " . mysqli_connect_error());
}

$_Post["query"]; //is the variable that will hold the query 

//Insert Query

//Select 
//$sql = query;
//$result = mysqli_query($conn, $sql);
//if (mysqli_num_rows($result) > 0) {
$sql = "SELECT Pokemon.Pokemon_ID, Pokemon_Name, Stat_Max
From Pokemon, Stats
where Pokemon.Pokemon_ID = Stats.Pokemon_ID AND Stat_Max >
(SELECT Stat_Max
From Stats
Where Pokemon_ID = '001');";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
	echo "<table border = '1'>\n";
	// output data of each row
	while($row = mysqli_fetch_row($result)) {
		echo "<tr>\n";
		for ($i = 0; $i < mysqli_num_fields($result); $i++) {
			echo "<td>" . $row[$i] . "</td>\n";
		}
		echo "</tr>\n";
	}
	echo "</table>\n";
} else {
	echo "0 results";
	}
	mysqli_free_result($result);
	mysqli_close($conn);
	?> 	 