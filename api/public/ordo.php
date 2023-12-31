<?php

header ( "Content-Type: application/json; charset=utf-8" );

if ( $_SERVER [ "REQUEST_METHOD" ] === "GET" && isset ( $_GET [ "year" ] ) ) {

  $year = intval ( $_GET [ "year" ] );

  if ( $year ) {
    
    $update = false;
    
    if ( isset ( $_GET [ "update" ] ) ) {

      $isset = intval ( $_GET [ "update" ] );
      
      if ( $isset == 1 ) {

        $update = true;

      }

    }

    $cache = "cache" . DIRECTORY_SEPARATOR . md5 ( "ordo-" . strval ( $year ) ) . ".json";

    if ( !$update && file_exists ( $cache ) ) {

      $data = file_get_contents ( $cache );
      echo ( $data );

    } else {

      require_once  __DIR__ . '/generate_ordo.php';

      $json = json_encode ( GetOrdo ( $year ), JSON_PRETTY_PRINT );
      echo ( $json );

      file_put_contents ( $cache, $json );

    }
  
  } else {
      
    http_response_code ( 422 );
    echo ( "Unprocessable Year" );
  
  }

} else {

  http_response_code ( 422 );
  echo ( "Request Invalid" );

}
