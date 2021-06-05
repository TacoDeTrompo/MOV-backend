<?php

include_once 'db.php';

function profileInsert($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spInsertTbProfile( '"
            . $MyConnection->real_escape_string($data->profileName) . "', '"
            . $MyConnection->real_escape_string($data->description) . "', '"
            . $MyConnection->real_escape_string($data->dayRange) . "', '"
            . $MyConnection->real_escape_string($data->color) . "', '"
            . $MyConnection->real_escape_string($data->userId) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function updateProfile($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spUpdateTbProfile( '"
            . $MyConnection->real_escape_string($data->idBD) . "', '"
            . $MyConnection->real_escape_string($data->userId) . "', '"
            . $MyConnection->real_escape_string($data->profileName) . "', '"
            . $MyConnection->real_escape_string($data->description) . "', '"
            . $MyConnection->real_escape_string($data->dayRange) . "', '"
            . $MyConnection->real_escape_string($data->color) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function getProfiles($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetProfiles(" . $MyConnection->real_escape_string($data->cloudId) . ")";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $arr = [];

        while ($row = mysqli_fetch_assoc($result)) {
            array_push($arr, array(
                'idBD' => $row["id"],
                'profileName' => $row["name"],
                'description' => $row["description"],
                'dayRange' => $row["dayrange"],
                'startDate' => $row["startday"],
                'color' => $row["color"],
                'userId' => $row["iduserdata"],
            ));
        }
        mysqli_free_result($result);


        echo json_encode($arr);

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function getProfile($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetProfile( '"
            . $MyConnection->real_escape_string($data->idBD) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{'idBD'} = $row["id"];
            $obj->{'profileName'} = $row["name"];
            $obj->{'description'} = $row["description"];
            $obj->{'dayRange'} = $row["dayrange"];
            $obj->{'startDate'} = $row["startday"];
            $obj->{'color'} = $row["color"];
            $obj->{'userId'} = $row["iduserdata"];
        }
        mysqli_free_result($result);

        echo json_encode($obj);

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function deleteProfile($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spDeleteTbProfile( '"
            . $MyConnection->real_escape_string($data->idBD) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}
