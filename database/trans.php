<?php

include_once 'db.php';

function transactionInsert($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spInsertTbTransaction( '"
            . $MyConnection->real_escape_string($data->name) . "', '"
            . $MyConnection->real_escape_string($data->description) . "', '"
            . $MyConnection->real_escape_string($data->amount) . "', '"
            . $MyConnection->real_escape_string($data->ttype) . "', '"
            . $MyConnection->real_escape_string($data->expenseType) . "', '"
            . $MyConnection->real_escape_string($data->profileId) . "' )";

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

function transactionUpdate($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spUpdateTbTransaction( '"
            . $MyConnection->real_escape_string($data->idBD) . "', '"
            . $MyConnection->real_escape_string($data->name) . "', '"
            . $MyConnection->real_escape_string($data->description) . "', '"
            . $MyConnection->real_escape_string($data->amount) . "', '"
            . $MyConnection->real_escape_string($data->expenseType) . "' )";

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

function transactionDelete($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spDeleteTbTransaction( '"
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

function getExpense($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetExpense( '"
            . $MyConnection->real_escape_string($data->idBD) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{'idBD'} = $row["id"];
            $obj->{'name'} = $row["name"];
            $obj->{'description'} = $row["description"];
            $obj->{'amount'} = $row["amount"];
            $obj->{'ttype'} = $row["ttype"];
            $obj->{'expenseType'} = $row["idexpensetype"];
            $obj->{'profileId'} = $row["idprofile"];
        }
        mysqli_free_result($result);

        echo json_encode($obj);

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function getIngress($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetIngress( '"
            . $MyConnection->real_escape_string($data->idBD) . "' )";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $obj = new stdClass();
        $null = null;

        while ($row = mysqli_fetch_assoc($result)) {
            $obj->{'idBD'} = $row["id"];
            $obj->{'name'} = $row["name"];
            $obj->{'description'} = $row["description"];
            $obj->{'amount'} = $row["amount"];
            $obj->{'ttype'} = $row["ttype"];
            $obj->{'expenseType'} = $null;
            $obj->{'profileId'} = $row["idprofile"];
        }
        mysqli_free_result($result);

        echo json_encode($obj);

        $MyConnection->close();
    } catch (PDOException $e) {
        echo "Error!: " . $e->getMessage();
        die();
    }
}

function getExpenses($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetExpenses(" . $MyConnection->real_escape_string($data->idBD) . ")";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $arr = [];

        while ($row = mysqli_fetch_assoc($result)) {
            array_push($arr, array(
                'idBD' => $row["id"],
                'name' => $row["name"],
                'description' => $row["description"],
                'amount' => $row["amount"],
                'ttype' => $row["ttype"],
                'expenseType' => $row["idexpensetype"],
                'profileId' => $row["idprofile"],
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

function getIngresses($data)
{
    try {
        $MyConnection = connect();

        $SQL = "CALL spGetIngresses(" . $MyConnection->real_escape_string($data->idBD) . ")";

        if (($result = $MyConnection->query($SQL)) === false) {
            printf("Invalid query: %s \n Whole query: %s \n ", $MyConnection->error, $SQL);
            exit();
        }

        $arr = [];
        $null = null;

        while ($row = mysqli_fetch_assoc($result)) {
            array_push($arr, array(
                'idBD' => $row["id"],
                'name' => $row["name"],
                'description' => $row["description"],
                'amount' => $row["amount"],
                'ttype' => $row["ttype"],
                'expenseType' => $null,
                'profileId' => $row["idprofile"],
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