<?php

 class DB {

    private $conn;

    function __construct ( ) { }

    function Connect ( ) {

        require_once __DIR__ . "/../../../ordo-db-config.php";

        try {

            $this->conn = new PDO ( "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8", DB_USER, DB_PASSWORD );

            return $this->conn;

        } catch ( \Exception $e ) {

            exit ( "Error: " .  $e->getMessage() . "\n" );

        }

    }

    public function Query ( string $sql, array $params = [ ], array $hidden = [ ] ): array {

        try {

            $sth = $this->conn->prepare ( $sql, [ PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY ] );
            $sth->execute ( $params );

            $results = $sth->fetchAll ( PDO::FETCH_ASSOC );

            if ( !empty ( $hidden ) ) {

                $results = array_map (
                    fn ( $row ) => array_diff_key ( $row, array_flip ( $hidden ) ),
                    $results
                );

            }

            return $results;

        } catch ( \Exception $e ) {

            throw new \RuntimeException ( "Query failed: " . $e->getMessage ( ) );

        }

    }

 }

?>