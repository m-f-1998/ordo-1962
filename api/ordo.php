<?php

require_once __DIR__ . "/vendor/autoload.php";

use MongoDB\Client;
use MongoDB\Driver\ServerApi;

header ( "Content-Type: application/json; charset=utf-8" );

if ( $_SERVER [ "REQUEST_METHOD" ] === "GET" ) {

  if ( isset ( $_GET [ "year" ] ) ) {

    $uri = "mongodb://localhost:27017";
    $apiVersion = new ServerApi ( ServerApi::V1 );
    $client = new MongoDB\Client ( $uri, [], [ "serverApi" => $apiVersion ] );

    try {

      $db = $client->selectDatabase ( "1962Ordo" );

      $year = $_GET [ "year" ];
      $country = $_GET [ "country" ] ?? null;
      $diocese = $_GET [ "diocese" ] ?? "All Dioceses";

      $universalData = $db->Universal->aggregate ( [
        [ '$match' => [ "Year" => $year ] ],
        [ '$project' => [ "_id" => 0 ] ]
      ] )->toArray ( );

      if ( empty ( $universalData ) ) {

        http_response_code ( 404 );
        echo "No data found for the specified year.";
        exit;

      }

      $res = $universalData [ 0 ];

      if ( $country ) {

        $localeCursor = $db->Locale->find (
          [ "country" => $country ],
          [ "projection" => [ "_id" => 0, "country" => 0 ] ]
        );

        foreach ( $localeCursor as $locale ) {

          foreach ( $locale as $month => $days ) {

            foreach ( $days as $day => $celebrations ) {

              $toBeAdded = array_filter ( iterator_to_array ( $celebrations ), function ( $celebration ) use ( $diocese ) {
                return $celebration [ "diocese" ] === $diocese || $celebration [ "diocese" ] === "All Dioceses";
              } );

              if ( !isset ( $res [ $month ] [ $day ] [ "celebrations" ] ) ) {
                $res [ $month ] [ $day ] [ "celebrations" ] = [];
              }

              $res [ $month ] [ $day ] [ "celebrations" ] = array_merge (
                iterator_to_array ( $res [ $month ] [ $day ] [ "celebrations" ] ),
                $toBeAdded
              );

            }

          }

        }

      }

      echo ( json_encode ( $res, JSON_PRETTY_PRINT ) );

    } catch ( Exception $e ) {

      http_response_code ( 500 );
      echo ( $e->getMessage ( ) );

    }

  } else {

      http_response_code ( 422 );
      echo ( "No Year Provided" );

  }

} else {

  http_response_code ( 422 );
  echo ( "Request Method Invalid" );

}
