<?php
include 'database/db.php';

$json = file_get_contents('php://input');
$data = json_decode($json);

updateUserData($data);
?>