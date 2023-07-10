<?php

  header ( 'Content-Type: application/json; charset=utf-8' );

  require __DIR__.'/vendor/autoload.php';

  use Kreait\Firebase\Factory;

  if ( isset ( $_POST [ 'user_id' ] ) && isset ( $_POST [ 'year' ] ) && isset ( $_POST [ 'timezone' ] ) ) {

    if ( filter_input ( INPUT_POST, "year", FILTER_VALIDATE_INT ) == false ) {

      http_response_code ( 422 );
      echo 'Unprocessable Year';

    } else {

      if ( ctype_alnum ( $_POST [ 'user_id' ] ) && $_POST [ 'user_id' ] !== "" ) {

        $factory = ( new Factory )->withServiceAccount ( dirname ( __DIR__ ) . '/../private/ordo-1962/ordo-1962-firebase-adminsdk-fy1k4-2db9663aea.json' );
        $auth = $factory->createAuth ( );

        try {

          $user = $auth->getUser ( $_POST [ 'user_id' ] );

          $path = dirname ( __DIR__ ) . '/../private/ordo-1962/ordo/' . $_POST [ 'year' ] . '.json';

          if ( file_exists ( $path ) && filesize ( $path ) > 0 ) {
            
            echo file_get_contents ( $path );
          
          } else {
            
            http_response_code ( 400 );
            echo 'API Corrupted';
          
          }

        } catch ( \Kreait\Firebase\Exception\Auth\UserNotFound $e ) {

          http_response_code ( 401 );
          echo 'Authorization Failed';

        } catch ( \Kreait\Firebase\Exception\AuthException $e ) {

          http_response_code ( 400 );
          echo 'Unkown Error Occured';
        
        }

      } else {

        http_response_code ( 422 );
        echo 'Unprocessable User ID';

      }
    
    }
  
  } else if ( isset ( $_POST [ 'timezone' ] ) ) {

    $path = dirname ( __DIR__ ) . '/../private/ordo-1962/ordo/' . date ( 'Y' ) . '.json';

    if ( file_exists ( $path ) && filesize ( $path ) > 0 && timezone_name_from_abbr ( $_POST [ 'timezone' ] ) ) {

      $file = file_get_contents ( $path );
      $json = json_decode ( $file, true );

      $res = array ( );
      date_default_timezone_set ( timezone_name_from_abbr ( $_POST [ 'timezone' ] ) );
      $month = date ( 'F' );
      $next_month = date ( 'F', strtotime ( 'first day of +1 month' ) );
      $to_test = array_merge ( $json [ $month ], $json [ $next_month ] );
      
      for ( $i = 0; $i < count ( $to_test ); ++$i ) {

        if ( count ( $res ) > 0 || ( count ( $res ) == 0 && $to_test [ $i ] [ 'date' ] == date ( 'D d' ) ) ) {

          array_push ( $res, $to_test [ $i ] );

          if ( count ( $res ) == 7 ) {

            echo json_encode ( $res );
            return;

          }

        }

      }
      
    } else {

      http_response_code ( 400 );
      echo 'Data Missing';

    }

  } else {

    http_response_code ( 400 );
    echo 'Missing Parameters';

  }

?>
