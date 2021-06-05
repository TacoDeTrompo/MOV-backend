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

function login($data){
    try{
        $MyConnection = connect();

        $SQL = "CALL spLogin( '"
                .$MyConnection->real_escape_string($data->email)."', '"
                .$MyConnection->real_escape_string($data->password)."' )";

        if ( ($result = $MyConnection->query($SQL))===false )
        {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{"token"} = $row["token"];
            $obj->{"firstName"} = $row["firstname"];
            $obj->{"lastName"} = $row["lastname"];
            $obj->{"username"} = $row["username"];
            $obj->{"email"} = $row["email"];
            $obj->{"encodedImage"} = $row["encodedImage"];
            $obj->{"cloudId"} = $row["id"];
        }
        mysqli_free_result($result);
        
        echo json_encode($obj);
        
        $MyConnection->close();
    }
    catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function signup($data){
    try{
        $MyConnection = connect();

        $SQL = "CALL spSignup( '"
                .$MyConnection->real_escape_string($data->firstName)."', '"
                .$MyConnection->real_escape_string($data->lastName)."', '"
                .$MyConnection->real_escape_string($data->username)."', '"
                .$MyConnection->real_escape_string($data->token)."', '"
                .$MyConnection->real_escape_string($data->email)."', '"
                .$MyConnection->real_escape_string($data->encodedImage)."' )";

        if ( ($result = $MyConnection->query($SQL))===false )
        {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{"token"} = $row["token"];
            $obj->{"firstName"} = $row["firstname"];
            $obj->{"lastName"} = $row["lastname"];
            $obj->{"username"} = $row["username"];
            $obj->{"email"} = $row["email"];
            $obj->{"encodedImage"} = $row["encodedImage"];
            $obj->{"cloudId"} = $row["id"];
        }
        mysqli_free_result($result);
        
        echo json_encode($obj);
        
        $MyConnection->close();
    }
    catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function updateUserData($data){
    try{
        $MyConnection = connect();

        $SQL = "CALL spUpdateTbUserdata( '"
                .$MyConnection->real_escape_string($data->cloudId)."', '"
                .$MyConnection->real_escape_string($data->token)."', '"
                .$MyConnection->real_escape_string($data->firstName)."', '"
                .$MyConnection->real_escape_string($data->lastName)."', '"
                .$MyConnection->real_escape_string($data->username)."', '"
                .$MyConnection->real_escape_string($data->email)."', '"
                .$MyConnection->real_escape_string($data->encodedImage)."' )";

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

function updatePassword($data){
    try{
        $MyConnection = connect();

        $SQL = "CALL spUpdatePassword( '"
                .$MyConnection->real_escape_string($data->userId)."', '"
                .$MyConnection->real_escape_string($data->token)."', '"
                .$MyConnection->real_escape_string($data->newPassword)."' )";

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