<?php

  header ( 'Content-Type: application/json; charset=utf-8' );

  require_once  __DIR__ . '/db/functions.php';

  $operations = new Functions ( );

  echo json_encode ( $operations->GetPrayers ( ) );

?>
