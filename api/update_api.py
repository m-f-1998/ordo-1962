import requests
import logging
import progressbar

progressbar.streams.wrap_stderr()
logging.basicConfig()

VERSION = "v1.2"

for x in progressbar.progressbar ( range ( 2023, 2124 ) ):
  x = requests.get ( f'https://matthewfrankland.co.uk/ordo-1962/{VERSION}/ordo.php?update=1&year={str(x)}' )
