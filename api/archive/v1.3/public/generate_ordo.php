<?php

require_once  __DIR__ . '/db.php';

class Ordo {

  private $db;

  function __construct ( ) {

    $this->db = new DB ( );
    $this->db->Connect ( );

  }

  function GetOrdo ( $year ) {

    $res = array (
      "Year" => $year,
      "Ordo" => array (
        [], [], [], [], [], [],
        [], [], [], [], [], []
      )
    );

    $previousDay = NULL;

    foreach ( $this->GetCelebrations ( $year ) as $celebration ) {

      $propers = $this->GetPropers ( $celebration [ "feast" ], $celebration [ "date" ] );
      $date = new DateTime ( $celebration [ "date" ] );
      $current_index = $date->format ( "n" ) - 1;

      $celebration [ "title" ] = $this->EpiphanyResumed (  $celebration [ "title" ], $date );

      if ( $previousDay != $date->format ( "D d" ) ) { // New Celebration Day

        array_push ( $res [ "Ordo" ] [ $current_index ], array (
          "date" => array (
            "weekday" => $date->format ( "D" ),
            "day" => $date->format ( "d" ),
            "month" => $date->format ( "M" ),
            "combined" => $date->format ( "d M Y" )
          ),
          "celebrations" => array ( ),
          "season" => array (
            "title" => $celebration [ "season" ],
            "colors" => $celebration [ "s_colors" ]
          ),
          "fasting" => $this->GetFastingOptions ( $celebration [ "season" ], $celebration [ "id" ], $celebration [ "title" ], $date )
        ) );

        $previousDay = $date->format ( "D d" );

      }

      array_push ( $res [ "Ordo" ] [ $current_index ] [ count ( $res [ "Ordo" ] [ $current_index ] ) - 1 ] [ "celebrations" ],
        array (
          "rank" => $celebration [ "rank" ],
          "title" => $celebration [ "title" ],
          "colors" => $celebration [ "colors" ],
          "options" => $celebration [ "options" ],
          "propers" => $this->GetProperTexts  ( $propers, $celebration [ "title" ] ),
          "commemorations" => $this->GetCommemorations ( $celebration [ "id" ] )
        )
      );

    }

    return $res;

  }

  private function GetCelebrations ( $year ) {

    return $this->db->Query (
      "SELECT c.`id`, c.`date`, c.`options`,
          s.`title` as `season`, s.`colors` as `s_colors`,
          f.`title`, f.`rank`, f.`colors`, `feast`
        FROM `Celebrations` c
          LEFT JOIN `Season` s ON s.`id` = c.`season`
          LEFT JOIN `Feast` f ON f.`id` = c.`feast`
        WHERE YEAR ( c.`date` )=:year ORDER BY c.`date`, c.`time` ASC",
      [ ":year" => $year ]
    );

  }

  private function GetPropers ( $feast, $date ) {

    $res = $this->db->Query (
      "SELECT * FROM `Propers` WHERE `feast`=:feast AND `date`=:date",
      [ ":feast" => $feast, ":date" => $date ],
      [ "id", "date", "feast" ]
    );

    if ( ! empty ( $res ) ) {

      return $res [ 0 ];

    }

    return $res;

  }

  private function EpiphanyResumed ( $title, $date ) {

    if ( in_array ( $date->format ( "M" ), array ( "Nov", "Dec" ) ) && str_contains ( $title, "Epiphany" ) ) {

      return "(Resumed) " . $title;

    }

    return $title;

  }

  private function GetCommemorations ( $celebration ) {

    $commemorations = $this->db->Query (
      "SELECT f.`title`, f.`rank`, f.`colors`, `collect`, `secret`, `postcommunion`
      FROM `Commemorations` c
        LEFT JOIN `Feast` f ON f.`id`=c.`feast`
      WHERE c.`celebration`=:celebration",
      [ ":celebration" => $celebration ]
    );

    $res = array ( );

    foreach ( $commemorations as $commemoration ) {

      $propers = $this->db->Query (
        "SELECT p.`category` as `title`, p.`english`, p.`latin`
        FROM `ProperText` p
        WHERE p.id IN (:collect, :secr, :postcommunion) ORDER BY
        CASE p.category
          WHEN 'collect' THEN 1
          WHEN 'secret' THEN 2
          WHEN 'postcommunion' THEN 3
          ELSE 4
        END;",
        [ ":collect" => $commemoration [ "collect" ],
          ":secr" => $commemoration [ "secret" ],
          ":postcommunion" => $commemoration [ "postcommunion" ]
        ]
      );

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

  private function GetProperTexts ( $propers, $title ) {

    $res = array ( );
    $unique_propers = array ( );

    if ( $title == "Good Friday" ) {

      return json_decode ( file_get_contents ( "./unique_propers/good_friday.json" ) );

    } else if ( $title == "Paschal Vigil" ) {

      return json_decode ( file_get_contents ( "./unique_propers/paschal_vigil.json" ) );

    } else if ( $title == "Mass of the Lord's Supper" ) {

      $unique_propers = json_decode ( file_get_contents ( "./unique_propers/mass_of_the_lords_supper.json" ), true );

    } else if ( $title == "Purification of the Blessed Virgin Mary" ) {

      $unique_propers = json_decode ( file_get_contents ( "./unique_propers/candlemas.json" ), true );

    } else if ( $title == "The Mass of the Chrism" ) {

      $unique_propers = json_decode ( file_get_contents ( "./unique_propers/chrism_mass.json" ), true );

    }

    if ( $propers && count ( $propers ) > 0 ) {

      foreach ( array_filter ( $propers ) as $key => $value ) {

        $proper = $this->db->Query (
          "SELECT `category`, `english`, `latin` FROM `ProperText` WHERE `id`=:id",
          [ ":id" => $value ]
        );

        if ( ! empty ( $proper ) ) {

          array_push ( $res, array (
            "title" => ucwords ( str_replace ( "_", " ", $proper [ 0 ] [ "category" ] ) ),
            "english" => $proper [ 0 ] [ "english" ],
            "latin" => $proper [ 0 ] [ "latin" ],
          ) );

        }

      }

      foreach ( $unique_propers as $proper ) {

        array_splice ( $res, $proper [ "index" ], 0, array ( array (
          "title" => $proper [ "title" ],
          "english" => $proper [ "english" ],
          "latin" => $proper [ "latin" ],
        ) ) );

      }

    }

    return $res;

  }

  private function IsEmberDay ( $id, $title ) {

    if ( str_contains ( $title, "Ember " ) ) {

      return true;

    }

    foreach ( $this->db->Query (
      "SELECT f.`title` FROM `Commemorations` LEFT JOIN `Feast` f ON f.`id`=`feast` WHERE `celebration`=:id", [ ":id" => $id ]
    ) as $row ) {

      if ( str_contains ( $row [ "title" ], "Ember " ) ) {

        return true;

      }

    }

    return false;

  }

  private function GetFastingOptions ( $season, $id, $title, $date ) {

    $res = array ( );

    $ember = $this->IsEmberDay ( $id, $title );
    $is_sunday = $date->format ( "w" ) == 0;
    $is_friday = $date->format ( "w" ) == 5;
    $is_vigil_immac_conc = $date->format ( "d M" ) == "07 Dec";
    $is_vigil_pentecost = $title == "Vigil of Pentecost" && !$is_sunday;

    if ( $ember || $is_vigil_pentecost || ( in_array ( $season, array ( "Lent", "Passiontide" ) ) && !$is_sunday ) ) {

      array_push ( $res, "Fast Day" );

    }

    if ( ( !$is_friday && $ember ) || $is_vigil_pentecost  ) {

      array_push ( $res, "Partial Abstinence" );

    }

    if ( $is_friday || $is_vigil_immac_conc || $title == "Ash Wednesday" || ( $title == "Vigil of Christmas" && !$is_sunday ) ) {

      array_push ( $res, "Complete Abstinence" );

    }

    return $res;
 
  }

}
