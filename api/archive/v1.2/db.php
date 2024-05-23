<?php

 class DB {

    private $conn;

    function __construct ( ) { }

    function connect ( ) {

        require_once __DIR__ . "/../../../private/ordo-1962/db-constants.php";

        $this->conn = new mysqli ( DB_HOST, DB_USER, DB_PASSWORD, DB_NAME );

        if ( mysqli_connect_errno ( ) ) {

            exit ( "Failed To Connect To MySQL: " . mysqli_connect_error ( ) );

        }

        // Change character set to utf8
        $this->conn->set_charset ( "utf8" );

        return $this->conn;

    }

 }

?>