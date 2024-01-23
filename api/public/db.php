<?php

 class DB {

     private $conn;

     function __construct ( ) { }

     function Connect ( ) {

      require_once __DIR__ . "/../../../private/ordo-1962/db-constants.php";

      $this->conn = new mysqli ( DB_HOST, DB_USER, DB_PASSWORD, DB_NAME );

      if ( mysqli_connect_errno ( ) ) {

          exit ( "Failed To Connect To MySQL: " . mysqli_connect_error ( ) );

      }

      return $this->conn;

     }

    function Query ( $sql, $params = array ( ), $hidden = array ( ) ) {

        $res = $this->conn->execute_query ( $sql, $params )->fetch_all ( MYSQLI_ASSOC );

        foreach ( $res as $row ) {

            foreach ( $hidden as $key ) {

                unset ( $row [ $key ] );

            }

        }

        return $res;

    }

 }

?>