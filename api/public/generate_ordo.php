<?php

  function GetOrdo ( $year ) {

    require_once  __DIR__ . '/db.php';
    $db = new DB ( );
    $conn = $db->connect ( );

    $res = array (
      "Year" => $year,
      "Ordo" => array (
        [], [], [], [], [], [],
        [], [], [], [], [], []
      )
    );

    $celebrations = $conn->execute_query (
      "SELECT c.`id`, c.`date`, c.`options`,
          s.`title` as `season`, s.`colors` as `s_colors`,
          f.`title`, f.`rank`, f.`colors`, `feast`
        FROM `Celebrations` c
          LEFT JOIN `Season` s ON s.`id` = c.`season`
          LEFT JOIN `Feast` f ON f.`id` = c.`feast`
        WHERE YEAR ( c.`date` )=? ORDER BY c.`date` ASC",
      [ $year ]
    );

    $previousDay = NULL;

    foreach ( $celebrations as $celebration ) {

      $propers = $conn->execute_query (
        "SELECT * FROM `Propers` WHERE `feast`=? AND `date`=?",
        [ $celebration [ "feast" ], $celebration [ "date" ] ]
      )->fetch_row ( );

      unset ( $propers [ "id" ], $propers [ "date" ], $propers [ "feast" ] );

      $date = new DateTime ( $celebration [ "date" ] );
      $short_month = $date->format ( "M" );
      $index = $date->format ( "n" ) - 1;
      $formatted_date = $date->format ( "D d" );

      if ( ( $short_month == "Nov" || $short_month == "Dec" ) && str_contains ( $celebration [ "title" ], "Epiphany" ) ) {
        $celebration [ "title" ] = "(Resumed) " . $celebration [ "title" ];
      }

      if ( $previousDay != $formatted_date ) {
        array_push ( $res [ "Ordo" ] [ $index ], array (
          "date" => $formatted_date,
          "month" => $short_month,
          "celebrations" => array ( ),
          "season" => array (
            "title" => $celebration [ "season" ],
            "colors" => $celebration [ "s_colors" ]
          )
        ) );
        $previousDay = $formatted_date;
      }

      array_push ( $res [ "Ordo" ] [ $index ] [ count ( $res [ "Ordo" ] [ $index ] ) - 1 ] [ "celebrations" ],
        array (
          "rank" => $celebration [ "rank" ],
          "title" => $celebration [ "title" ],
          "colors" => $celebration [ "colors" ],
          "options" => $celebration [ "options" ],
          "propers" => GetProperTexts  ( $propers, $conn ),
          "commemorations" => GetCommemorations ( $celebration [ "id" ], $conn )
        )
      );

    }

    return $res;

  }

  function GetCommemorations ( $celebration, $conn ) {

    $commemorations = $conn->execute_query (
      "SELECT f.`title`, f.`rank`, f.`colors`, `collect`, `secret`, `postcommunion`
      FROM `Commemorations` c
      LEFT JOIN `Feast` f ON f.`id`=c.`feast`
      WHERE c.`celebration`=?",
      [ $celebration ]
    );

    $res = array ( );

    foreach ( $commemorations as $commemoration ) {

      $propers = $conn->execute_query (
        "SELECT p.`category` as `title`, p.`english`, p.`latin`
        FROM `ProperText` p
        WHERE p.`id`=? OR p.`id`=? OR p.`id`=?",
        [ $commemoration [ "collect" ], $commemoration [ "secret" ], $commemoration [ "postcommunion" ] ]
      )->fetch_all ( MYSQLI_ASSOC );

      foreach ( $propers as $key => $value ) {

        $propers [ $key ] [ "title" ] = ucwords ( $value [ "title" ] );
      
      }

      array_push ( $res, array (
        "title" => $commemoration [ "title" ],
        "rank" => $commemoration [ "rank" ],
        "colors" => $commemoration [ "colors" ],
        "propers" => $propers
      ) );

    }

    return $res;

  }

  function GetProperTexts ( $propers, $conn ) {

    $res = array ( );

    if ( $propers && count ( $propers ) > 0 ) {

      foreach ( array_filter ( $propers ) as $key => $value ) {

        $proper = $conn->execute_query (
          "SELECT `category`, `english`, `latin` FROM `ProperText` WHERE `id`=?",
          [ $value ]
        )->fetch_assoc ( );

        if ( !is_null ( $proper ) ) {

          array_push ( $res, array (
            "title" => ucwords ( str_replace ( "_", " ", $proper [ "category" ] ) ),
            "english" => $proper [ "english" ],
            "latin" => $proper [ "latin" ],
          ) );
        
        }

      }

    }

    return $res;

  }
