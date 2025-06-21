<?php
	
	$host = 'localhost';
	$user = 'root';
	$password = '';
	$db = 'lomasmarketdb';

	$conection = mysqli_connect($host, $user, $password, $db);

	if (!$conection) {
		die("Error de conexión: " . mysqli_connect_error());
	}
	mysqli_set_charset($conection, "utf8");

?>