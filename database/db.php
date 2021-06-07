<?php

function connect(){
    $user = "Jeffsmov";
    $password = "adminadmin";
    $database = "MOVdb";
    return new mysqli ("localhost", $user, $password, $database);
}

include_once 'advice.php';
include_once 'userdata.php';
include_once 'profile.php';
include_once 'trans.php';
include_once 'trans-results.php';