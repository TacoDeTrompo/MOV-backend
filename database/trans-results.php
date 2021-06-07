<?php

include_once 'db.php';

function getAllExpenses($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetAllExpenses( '"
            . $MyConnection->real_escape_string($data->idBD) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();
        $null = null;

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{'amount'} = $row["amount"];
        }
        mysqli_free_result($result);

        echo json_encode($obj);

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function getAllIngress($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetAllIngress( '"
            . $MyConnection->real_escape_string($data->idBD) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();
        $null = null;

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{'amount'} = $row["amount"];
        }
        mysqli_free_result($result);

        echo json_encode($obj);

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function getProfileTotal($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetProfileTotal( '"
            . $MyConnection->real_escape_string($data->idBD) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();
        $null = null;

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{'amount'} = $row["total"];
        }
        mysqli_free_result($result);

        echo json_encode($obj);

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}