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
  try {
    const db = await connect ( )
    const prayers = await db.collection ( "prayers" ).find ( ).toArray ( )
    const result: Record<string, Record<string, Record<string, string>>> = { }

    prayers.forEach ( prayer => {
      if ( !result [ prayer [ "language" ] ] ) {
        result [ prayer [ "language" ] ] = { }
      }
      if ( !result [ prayer [ "language" ] ] [ prayer [ "category" ] ] ) {
        result [ prayer [ "language" ] ] [ prayer [ "category" ] ] = { }
      }
      result [ prayer [ "language" ] ] [ prayer [ "category" ] ] [ prayer [ "title" ] ] = prayer [ "body" ]
    } )

    res.json ( result )
  } catch ( error ) {
    console.error ( "Error fetching prayers:", error )
    res.status ( 500 ).json ( { error: "Internal Server Error" } )
  }
} )