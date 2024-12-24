<?php

header ( "Content-Type: application/json; charset=utf-8" );
header ( "Access-Control-Allow-Origin: http://localhost" );

if ( $_SERVER [ "REQUEST_METHOD" ] === "GET" && isset ( $_GET [ "year" ] ) ) {

  $year = intval ( $_GET [ "year" ] );

  if ( $year ) {

    require_once  __DIR__ . '/generate_ordo.php';
    $ordo = new Ordo ( );
    echo ( json_encode ( $ordo->GetOrdo ( $year ), JSON_PRETTY_PRINT ) );

  } else {

    http_response_code ( 422 );
    echo ( "Unprocessable Year" );

  }

} else {

  http_response_code ( 422 );
  echo ( "Request Invalid" );

}
