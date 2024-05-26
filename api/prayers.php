<?php

require_once __DIR__ . "/vendor/autoload.php";

use MongoDB\Client;
use MongoDB\Driver\ServerApi;

header ( "Content-Type: application/json; charset=utf-8" );

if ( $_SERVER [ "REQUEST_METHOD" ] === "GET" ) {

  $language = null;

  if ( isset ( $_GET [ "language" ] ) ) {

    $language = $_GET [ "language" ] ?? null;

  }

  $uri = "mongodb://localhost:27017";
  $apiVersion = new ServerApi ( ServerApi::V1 );
  $client = new MongoDB\Client ( $uri, [], [ "serverApi" => $apiVersion ] );

  try {

    $db = $client->selectDatabase ( "1962Ordo" );

    $query = [];
    if ( $language !== null ) {
      $query = [ "language" => $language ];
    }

    $prayersCursor = $db->Prayers->find (
      $query,
      [ "projection" => [ "_id" => 0 ] ]
    )->toArray ( );

    echo json_encode ( iterator_to_array ( $prayersCursor ), JSON_PRETTY_PRINT );

  } catch ( Exception $e ) {

    http_response_code ( 500 );
    echo ( $e->getMessage ( ) );

  }

} else {

  http_response_code ( 422 );
  echo ( "Request Method Invalid" );

}