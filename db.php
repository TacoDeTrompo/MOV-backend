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

        $SQL = "CALL spInsertTbAdvice( '"
                .$MyConnection->real_escape_string($data->title)
                ."', '"
                .$MyConnection->real_escape_string($data->content)
                ."', '"
                .$MyConnection->real_escape_string($data->encodedImage)
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

function getAdvices(){
    try{
        $MyConnection = connect();

        $SQL = "CALL spGetAllAdvices()";

        if ( ($result = $MyConnection->query($SQL))===false )
        {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $arr = [];

        while ($row = mysqli_fetch_assoc($result)) {
            array_push($arr, array('id' => $row["id"], 'title' => $row["title"], 'content' => $row["description"], 'encodedImage' => $row["encodedImage"]));
        }
        mysqli_free_result($result);
        
        
        echo json_encode($arr);
        
        $MyConnection->close();
    }
    catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}