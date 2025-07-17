import { Router } from "express"
import { rateLimit } from "express-rate-limit"
import { connect } from "../db.js"

export const router = Router ( )

router.use ( rateLimit ( {
  windowMs: 60 * 1000, // 1 minute
  max: 100, // Limit each IP to 100 requests per windowMs
  standardHeaders: true, // Return rate limit info in the RateLimit-* headers
  legacyHeaders: false, // Disable the X-RateLimit-* headers
  message: {
    status: 429,
    error: "Too many requests, please try again later."
  }
} ) )

router.get ( "/", async ( _req, res ) => {
  const db = await connect ( )

  const votives = await db.collection ( "votives" ).find (
    { },
    { projection: { _id: 0 } }
  ).toArray ( )

  if ( !votives.length ) {
    res.status ( 404 ).json ( { error: "Votives not found." } )
    return
  }

  res.json ( votives )
} )

