import json
from pymongo import MongoClient
import os

myclient = MongoClient ( "mongodb://localhost:27017/" )

myclient.drop_database ( "1962Ordo" )
db = myclient [ "1962Ordo" ]

Universal = db [ "Universal" ]
Prayers = db [ "Prayers" ]

count = 0

for filename in os.listdir(os.getcwd() + "/json/universal"):
	count += 1
	print ( "Years Complete:", count )
	with open(os.path.join(os.getcwd(), "json/universal/" + filename), 'r') as f: # open in readonly
		if filename.lower ( ).endswith ( ".json" ):
			file_data = json.load ( f )
			if isinstance(file_data, list):
				Universal.insert_many(file_data)
			else:
				Universal.insert_one(file_data)

Universal.create_index ( [ ( "Year", 1 ) ] )

print ( "Sorting Locale" )
Locale = db [ "Locale" ]
for filename in os.listdir(os.getcwd() + "/json/locale"):
	with open(os.path.join(os.getcwd(), "json/locale/" + filename), 'r') as f: # open in readonly
		if filename.lower ( ).endswith ( ".json" ):
			file_data = json.load ( f )
			if isinstance(file_data, list):
				Locale.insert_many(file_data)
			else:
				Locale.insert_one(file_data)

Universal.create_index ( [ ( "Country", 1 ) ] )

print ( "Sorting Prayers" )
with open(os.path.join(os.getcwd(), "json/" + "prayers.json"), 'r') as f: # open in readonly
	jsonData = json.load ( f )
	categories = [ ]
	for language in jsonData:
		for category in jsonData [ language ]:
			for prayer in jsonData [ language ] [ category ]:
				Prayers.insert_one ( {
					"language": language,
					"category": category,
					"title": prayer,
					"text": jsonData [ language ] [ category ] [ prayer ]
				} )

Universal.create_index ( [ ( "language", 1 ) ] )