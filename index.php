<?php

$user = "Jeffsmov";
$password = "adminadmin";
$database = "MOVdb";
$parameter1 = '1';
$parameter2 = '2';

try {
    $MyConnection = new mysqli ("localhost", $user, $password, $database);

    mysqli_query($MyConnection ,"SET @p0='".$parameter1."'");
    mysqli_query($MyConnection ,"SET @p1='".$parameter2."'");
    mysqli_multi_query ($MyConnection, "CALL spTest (@p0,@p1)") OR DIE (mysqli_error($MyConnection));

    while (mysqli_more_results($MyConnection)) {
       if ($result = mysqli_store_result($MyConnection)) {
            while ($row = mysqli_fetch_assoc($result)) {
                echo "content = ".$row["content"]."<br />";
            }
            //json_encode($result);
            //TODO: json encode lmao xDDD
            mysqli_free_result($result);
       }
       mysqli_next_result($MyConnection);
    }


} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}