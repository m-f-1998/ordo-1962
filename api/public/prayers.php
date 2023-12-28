<?php

header ( "Content-Type: application/json; charset=utf-8" );

if ( $_SERVER [ "REQUEST_METHOD" ] === "GET" ) {

  require_once  __DIR__ . '/db.php';
  $db = new DB ( );
  $conn = $db->connect ( );

  $res = array ( );

  $prayers = $conn->execute_query (
    "SELECT `language`, `category`, `title`, `body` FROM `Prayers`"
  );

  foreach ( $prayers as $row ) {
    $res [ $row [ "language" ] ] [ $row [ "category" ] ] [ $row [ "title" ] ] = $row [ "body" ];
  }

  echo json_encode ( $res );

} else {

  http_response_code ( 422 );
  echo ( "Request Invalid" );

}