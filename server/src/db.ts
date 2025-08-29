import { Db, MongoClient } from "mongodb"

const user = process.env [ "MONGO_INITDB_ROOT_USERNAME" ] || "admin"
const pass = encodeURIComponent ( process.env [ "MONGO_INITDB_ROOT_PASSWORD" ] || "" )
const host = process.env [ "MONGO_INITDB_HOST" ] || "localhost"
const port = process.env [ "MONGO_INITDB_PORT" ] || "27017"

const uri = `mongodb://${user}:${pass}@${host}:${port}/?authSource=admin&retryWrites=true&w=majority`

const client = new MongoClient ( uri )

let db: Db

const connect = async ( ) => {
  if ( !db ) {
    console.time ( "MongoDB connection" )
    await client.connect ( )
    console.timeEnd ( "MongoDB connection" )
    console.time ( "MongoDB database selection" )
    db = client.db ( "ordo" )
    console.timeEnd ( "MongoDB database selection" )
    console.log ( "Connected to MongoDB" )
  }
  return db
}

export { connect }