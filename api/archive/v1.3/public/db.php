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
            $res = array ( );
            $sth = $this->conn->prepare ( $sql, [ PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY ] );
            $sth->execute ( $params );

            while( $row = $sth->fetch ( PDO::FETCH_ASSOC ) ) {

                foreach ( $hidden as $key ) {

                    unset ( $row [ $key ] );

                }

                array_push ( $res, $row );

            }

            return $res;
        } catch (\Exception $e) {

            exit ( "Error: " .  $e->getMessage() . "\n" );

        }

    }

 }

?>