<?php

 class DB {

    private $conn;

    function __construct ( ) { }

    function Connect ( ) {

        require_once __DIR__ . "/../../../ordo-db-config.php";

        try {

            $this->conn = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8", DB_USER, DB_PASSWORD);

            return $this->conn;

        } catch (\Exception $e) {

            exit ( "Error: " .  $e->getMessage() . "\n" );

        }

    }

    function Query ( $sql, $params = array ( ), $hidden = array ( ) ) {

        try {
            $res = $this->conn->query ( $sql, $params )->fetch_all ( MYSQLI_ASSOC );

            foreach ( $res as $row ) {

                foreach ( $hidden as $key ) {

                    unset ( $row [ $key ] );

                }

            }

            return $res;
        } catch (\Exception $e) {

            exit ( "Error: " .  $e->getMessage() . "\n" );

        }

    }

 }

?>