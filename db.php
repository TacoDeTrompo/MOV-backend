<?php

function connect(){
    $user = "Jeffsmov";
    $password = "adminadmin";
    $database = "MOVdb";
    return new mysqli ("localhost", $user, $password, $database);
}

function insertAdvices($data){
    try{
        $MyConnection = connect();

        echo $MyConnection->connect_error;

        $SQL = "CALL spInsertTbAdvice( '"
                .$MyConnection->real_escape_string($data->title)
                ."', '"
                .$MyConnection->real_escape_string($data->description)
                ."', '"
                .$MyConnection->real_escape_string($data->picture)
                ."' )";

        if ( ($result = $MyConnection->query($SQL))===false )
        {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }
        
        $MyConnection->close();
    }
    catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}