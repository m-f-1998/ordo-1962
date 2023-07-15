<?php

class Functions {

    private $conn;

    function __construct () {

      require_once  __DIR__ . '/db.php';
      
      $db = new DB ();
      $this->conn = $db->connect ();

    }

  /**
   *
   * Get Ordo Dates For A Given Year
   *
   */
    public function GetOrdoYear ( $year ) {
      
      $res = array (
        'January' => [], 'February' => [], 'March' => [], 'April' => [],
        'May' => [], 'June' => [], 'July' => [], 'August' => [],
        'September' => [], 'October' => [], 'November' => [], 'December' => []
      );

      foreach ( $res as $month => $value ) {

        $days = $this->conn->execute_query (
          "SELECT c.`date`, DATE_FORMAT(c.`date`, '%a %d') as `formatted_date`, c.`options`, s.`title` as `season_title`, s.`colors` as `season_colors`
            FROM `Celebrations` c
            JOIN `Season` s ON c.`season`=s.`id`
            WHERE YEAR(c.`date`)=? AND MONTHNAME(c.`date`)=?
            ORDER BY `c`.`date`
            ASC",
          [ $_POST [ 'year' ], $month ]
        );
        
        foreach ( $days as $day ) {

          array_push ( $res [ $month ], array (
            "id" => bin2hex ( openssl_random_pseudo_bytes ( 16 ) ),
            "date" => $day [ "formatted_date" ],
            "celebration" => $this->conn->execute_query (
                "SELECT BIN_TO_UUID(c.`id`) as `id`, f.`rank`, f.`title`, f.`colors`
                  FROM `Celebrations` c
                  JOIN `Feast` f ON c.`feast`=f.`id`
                  WHERE c.`date`=?",
                [ $day [ 'date' ] ]
              )->fetch_all ( MYSQLI_ASSOC ),
            "commemoration" => $this->conn->execute_query (
                "SELECT BIN_TO_UUID(f.`id`) as `id`, f.`rank`, f.`title`, f.`colors`
                  FROM `Commemorations` c
                  JOIN `Feast` f ON c.`feast`=f.`id`
                  WHERE c.`date`=?",
                [ $day [ 'date' ] ]
              )->fetch_all ( MYSQLI_ASSOC ),
            "season" => array (
              "title" => $day [ "season_title" ],
              "colors" => $day [ "season_colors" ]
            ),
            "options" => $day [ "options" ]
          ) );
        
        }

      }

      return $res;
    
    }

  /**
   *
   * Get Next 7 Liturgical Days
   *
   */
    public function GetOrdoWeek ( $timestamp ) {

      $res = array ( );
      
      date_default_timezone_set ( $_POST [ 'timezone' ] );
      
      $today = date ( 'Y-m-d' );
      $next_week = date ( 'Y-m-d', strtotime ( '+1 week' ) );

      $celebrations = $this->conn->execute_query (
        "SELECT BIN_TO_UUID(c.`id`) as `id`, DATE_FORMAT(c.`date`, '%a %d') as `date`, f.`rank`, f.`title`, f.`colors`
          FROM `Celebrations` c, `Feast` f
          WHERE c.`feast`=f.`id` AND c.`date` BETWEEN ? AND ?
          ORDER BY `c`.`date`
          ASC",
        [ $today, $next_week ]
      );
        
      foreach ( $celebrations as $celebration ) {

        array_push ( $res, array (
          "id" => bin2hex ( openssl_random_pseudo_bytes ( 16 ) ),
          "date" => $celebration [ "date" ],
          "celebration" => array (
            array (
              "id" => $celebration [ "id" ],
              "rank" => $celebration [ "rank" ],
              "title" => $celebration [ "title" ],
              "colors" => $celebration [ "colors" ]
            )
          )
        ) );

      }

      return $res;

    }

  /**
   *
   * Get Prayers Catalogue In HTML Encoded Format
   *
   */
    public function GetPrayers ( $language ) {

      $res = array ( );
      
      $prayers = $this->conn->execute_query (
        "SELECT `category`, `title`, `body` FROM `Prayers` WHERE `language`=?",
        [ $language ]
      );
        
      foreach ( $prayers as $prayer ) {

        if ( !array_key_exists ( $prayer [ "category" ], $res ) ) {

          $res [ $prayer [ "category" ] ] = array ( );

        }

        $res [ $prayer [ "category" ] ] [ $prayer [ "title" ] ] = $prayer [ "body" ];

      }

      return $res;

    }

  /**
   *
   * Get The Propers For The Holy Masses In A Given Year
   *
   */
    public function GetPropers ( $year ) {

      $res = array (
        'January' => [], 'February' => [], 'March' => [], 'April' => [],
        'May' => [], 'June' => [], 'July' => [], 'August' => [],
        'September' => [], 'October' => [], 'November' => [], 'December' => []
      );

      foreach ( $res as $month => $value ) {

        $introit = $this->GetProperText ( "introit", $year, $month );
        $collect = $this->GetProperText ( "collect", $year, $month, TRUE );
        $epistle = $this->GetProperText ( "epistle", $year, $month, TRUE );
        $gradual = $this->GetProperText ( "gradual", $year, $month, TRUE );
        $gospel = $this->GetProperText ( "gospel", $year, $month, TRUE );
        $offertory = $this->GetProperText ( "offertory", $year, $month, TRUE );
        $secret = $this->GetProperText ( "secret", $year, $month, TRUE );
        $preface = $this->GetProperText ( "preface", $year, $month, TRUE );
        $communion = $this->GetProperText ( "communion", $year, $month, TRUE );
        $postcommunion = $this->GetProperText ( "postcommunion", $year, $month, TRUE );

        for ( $index = 0; $index < count ( $introit ); $index++ ) {

          array_push ( $res [ $month ], array (
            "id" => $introit [ $index ] [ "id" ],
            "date" => $introit [ $index ] [ "date" ],
            "introit" => array (
              "english" => $introit [ $index ] [ "english" ],
              "latin" => $introit [ $index ] [ "latin" ]
            ),
            "collect" => $collect [ $index ],
            "epistle" => $epistle [ $index ],
            "gradual" => $gradual [ $index ],
            "gospel" => $gospel [ $index ],
            "offertory" => $offertory [ $index ],
            "secret" => $secret [ $index ],
            "preface" => $preface [ $index ],
            "communion" => $communion [ $index ],
            "postcommunion" => $postcommunion [ $index ]
          ) );

        }

      }

      return $res;
    
    }

    private function GetProperText ( $category, $year, $month, $include_id = FALSE ) {

      $optional_fields = $include_id ? "" : "BIN_TO_UUID(p.`id`) as `id`, DATE_FORMAT(p.`date`, '%a %d') as `date`, ";
      $query = "SELECT " . $optional_fields . "pt.`english`, pt.`latin`
        FROM `ProperText` pt
        JOIN `Propers` p ON p.`" . $category . "`=pt.`id`
        WHERE YEAR(p.`date`)=? AND MONTHNAME(p.`date`) = ?
        ORDER BY p.`date`
        ASC";
      
      return $this->conn->execute_query ( $query, [ $year, $month ] )->fetch_all ( MYSQLI_ASSOC );

    }

}

?>