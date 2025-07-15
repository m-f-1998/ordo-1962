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
    const localeData = await db.collection ( "locale" ).find ( ).toArray ( )
    const result: Record<string, any> = { in_certain_locations: [ ], feasts: { countries: [ ], locale: { } } }
    localeData.forEach ( row => {
      if ( row [ "location" ] === "In Certain Locations" ) {
        result [ "in_certain_locations" ] = row [ "locale" ] || [ ]
      } else {
        const country = row [ "location" ]
        result [ "feasts" ].countries.push ( country )
        result [ "feasts" ].locale [ country ] = row [ "locale" ]
      }
    } )
    res.json ( result )
  } catch ( error ) {
    console.error ( "Error fetching locale data:", error )
    res.status ( 500 ).json ( { error: "Internal Server Error" } )
  }
} )