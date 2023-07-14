<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET');

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

        $celebrations = $this->conn->execute_query (
          "SELECT BIN_TO_UUID(c.`id`) as `celebration_id`, DATE_FORMAT(c.`date`, '%a %d') as `date`, f.`rank`, f.`title`, f.`colors`,  c.`options`, s.`title` as `season_title`, s.`colors` as `season_colors`
            FROM `Celebrations` c, `Feast` f, `Season` s
            WHERE BIN_TO_UUID(c.`feast`)=BIN_TO_UUID(f.`id`) AND BIN_TO_UUID(c.`season`)=BIN_TO_UUID(s.`id`) AND YEAR(c.`date`)=? AND MONTHNAME(c.`date`)=?
            ORDER BY `c`.`date`
            ASC",
          [ $_POST [ 'year' ], $month ]
        );

        $current_date = "";
        
        foreach ( $celebrations as $celebration ) {

          if ( $current_date == $celebration [ "date" ] ) {

            array_push ( $res [ $month ] [ array_key_last ( $res [ $month ] ) ] [ "celebration" ], array (
              "id" => $celebration [ "celebration_id" ],
              "rank" => $celebration [ "rank" ],
              "title" => $celebration [ "title" ],
              "colors" => explode ( ',', $celebration [ "colors" ] )
            ) );

          } else {
            
            $commemorations = $this->conn->execute_query (
              "SELECT BIN_TO_UUID(f.`id`) as `id`, f.`rank`, f.`title`, f.`colors`
                FROM `Commemorations` c, `Feast` f
                WHERE DATE_FORMAT(c.`date`, '%a %d')=? AND BIN_TO_UUID(c.`feast`)=BIN_TO_UUID(f.`id`) AND YEAR(c.`date`)=? AND MONTHNAME(c.`date`) = ?",
              [ $celebration [ 'date' ], $_POST [ 'year' ], $month ]
            )->fetch_all ( MYSQLI_ASSOC );

            foreach ( $commemorations as $key => $commemoration ) {
              
              $commemorations [ $key ] [ "colors" ] = explode ( ',', $commemoration [ "colors" ] );
            
            }

            array_push ( $res [ $month ], array (
              "id" => bin2hex ( openssl_random_pseudo_bytes ( 16 ) ),
              "date" => $celebration [ "date" ],
              "celebration" => array (
                array (
                  "id" => $celebration [ "celebration_id" ],
                  "rank" => $celebration [ "rank" ],
                  "title" => $celebration [ "title" ],
                  "colors" => explode ( ",", $celebration [ "colors" ] )
                )
              ),
              "commemoration" => $commemorations,
              "season" => array (
                "title" => $celebration [ "season_title" ],
                "colors" => explode ( ',', $celebration [ "season_colors" ] )
              ),
              "options" => $celebration [ "options" ]
            ) );

          }

          $current_date = $celebration [ "date" ];
        
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
        "SELECT BIN_TO_UUID(c.`id`) as `celebration_id`, DATE_FORMAT(c.`date`, '%a %d') as `date`, f.`rank`, f.`title`, f.`colors`,  c.`options`, s.`title` as `season_title`, s.`colors` as `season_colors`
          FROM `Celebrations` c, `Feast` f, `Season` s
          WHERE BIN_TO_UUID(c.`feast`)=BIN_TO_UUID(f.`id`) AND BIN_TO_UUID(c.`season`)=BIN_TO_UUID(s.`id`) AND c.`date` BETWEEN ? AND ?
          ORDER BY `c`.`date`
          ASC",
        [ $today, $next_week ]
      );

      $current_date = "";
        
      foreach ( $celebrations as $celebration ) {

        if ( $current_date == $celebration [ "date" ] ) {

          array_push ( $res [ array_key_last ( $res ) ] [ "celebration" ], array (
            "id" => $celebration [ "celebration_id" ],
            "rank" => $celebration [ "rank" ],
            "title" => $celebration [ "title" ],
            "colors" => explode ( ',', $celebration [ "colors" ] )
          ) );

        } else {

          array_push ( $res, array (
            "id" => bin2hex ( openssl_random_pseudo_bytes ( 16 ) ),
            "date" => $celebration [ "date" ],
            "celebration" => array (
              array (
                "id" => $celebration [ "celebration_id" ],
                "rank" => $celebration [ "rank" ],
                "title" => $celebration [ "title" ],
                "colors" => explode ( ",", $celebration [ "colors" ] )
              )
            )
          ) );

        }

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
      
        $propers = $this->conn->execute_query (
          "SELECT BIN_TO_UUID(p.`id`) as `id`, DATE_FORMAT(p.`date`, '%a %d') as `date`, pt.`category`, pt.`english`, pt.`latin`
          FROM `Propers` p, `ProperText` pt
          WHERE ( p.`introit`=pt.`id` OR p.`collect`=pt.`id` OR p.`epistle`=pt.`id` OR p.`gradual`=pt.`id` OR p.`gospel`=pt.`id` OR p.`offertory`=pt.`id` OR p.`secret`=pt.`id` OR p.`preface`=pt.`id` OR p.`communion`=pt.`id` OR p.`postcommunion`=pt.`id` ) AND YEAR(p.`date`)=? AND MONTHNAME(p.`date`) = ?
          ORDER BY p.`date`
          ASC",
          [ $year, $month ]
        );

        $current_date = "";
        $temp = array ( );

        foreach ( $propers as $proper ) {

          if ( $current_date != "" && $current_date != $proper [ "date" ] ) {

            array_push ( $res [ $month ], $temp );

            $temp = array ( );

          } else {
            
            $temp [ "date" ] = $proper [ "date" ];
            $temp [ "id" ] = $proper [ "id" ];
          
          }

          $temp [ $proper [ "category" ] ] = array ( 

            "english" => $proper [ "english" ],
            "latin" => $proper [ "latin" ]

          );

          $current_date = $proper [ "date" ];

        }

      }

      return $res;
    }

}

?>