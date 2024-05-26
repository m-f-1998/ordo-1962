<?php

header ( "Content-Type: application/json; charset=utf-8" );
header ( "Access-Control-Allow-Origin: http://localhost" );

if ( $_SERVER [ "REQUEST_METHOD" ] === "GET" ) {

  require_once  __DIR__ . '/db.php';
  $db = new DB ( );
  $conn = $db->connect ( );

  $res = array (
    "in_certain_locations" => array ( ),
    "feasts" => array (
      "countries" => array ( ),
      "locale" => array ( )
    )
  );

  $celebrations = $conn->query (
    "SELECT `date`, `title`, `colors`, `country`, `locale` FROM `CelebrationsLocale`"
  );

  foreach ( $celebrations as $row ) {

    if ( $row [ "country" ] == "In Certain Locations" ) {

      array_push ( $res [ "in_certain_locations" ], array (
        "date" => $row [ "date" ],
        "title" => $row [ "title" ],
        "colors" => $row [ "colors" ]
      ) );

    } else {

      if ( !in_array ( $row [ "country"], $res [ "feasts" ] [ "countries" ] ) ) {

        array_push ( $res [ "feasts" ] [ "countries" ], $row [ "country" ] );

      }

      if ( !isset ( $res [ "feasts" ] [ "locale" ] [ $row [ "country" ] ] ) ) {

        $res [ "feasts" ] [ "locale" ] [ $row [ "country" ] ] = array (
          "dioceses" => array ( ),
          "locale" => array ( )
        );

      }

      if ( !in_array ( $row [ "locale" ], $res [ "feasts" ] [ "locale" ] [ $row [ "country" ] ] [ "dioceses" ] ) ) {

        $res [ "feasts" ] [ "locale" ] [ $row [ "country" ] ] [ "locale" ] [ $row [ "locale" ] ] = array ( );
        array_push ( $res [ "feasts" ] [ "locale" ] [ $row [ "country" ] ] [ "dioceses" ], $row [ "locale" ] );
      
      }

      array_push ( $res [ "feasts" ] [ "locale" ] [ $row [ "country" ] ] [ "locale" ] [ $row [ "locale" ] ], array (
        "date" => $row [ "date" ],
        "title" => $row [ "title" ],
        "colors" => $row [ "colors" ]
      ) );

    }
  
  }

  echo json_encode ( $res );

} else {

  http_response_code ( 422 );
  echo ( "Request Invalid" );

}