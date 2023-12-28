import requests

VERSION = "v1.3"

for x in range ( 2023, 2124 ):
  print ( f'https://matthewfrankland.co.uk/ordo-1962/{VERSION}/ordo.php?update=1&year={str(x)}' )
  x = requests.get ( f'https://matthewfrankland.co.uk/ordo-1962/{VERSION}/ordo.php?update=1&year={str(x)}' )
  print ( x )