<?php

  header ( 'Content-Type: application/json; charset=utf-8' );

  require __DIR__.'/vendor/autoload.php';

  use Kreait\Firebase\Factory;

  if ( isset ( $_POST [ 'user_id' ] ) && isset ( $_POST [ 'lang' ] ) ) {

    if ( ctype_alnum ( $_POST [ 'user_id' ] ) && $_POST [ 'user_id' ] !== "" && $_POST [ 'lang' ] !== "" ) {

      $factory = ( new Factory )->withServiceAccount ( dirname ( __DIR__ ) . '/../private/ordo-1962/ordo-1962-firebase-adminsdk-fy1k4-2db9663aea.json' );
      $auth = $factory->createAuth ( );

      try {

        $user = $auth->getUser ( $_POST [ 'user_id' ] );

        $path = dirname ( __DIR__ ) . '/../private/ordo-1962/prayers/' . $_POST[ 'lang' ] . '.json';

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
  
  } else {

    http_response_code ( 400 );
    echo 'Missing Parameters';

  }

?>
