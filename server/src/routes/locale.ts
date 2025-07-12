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
      if ( row [ "country" ] === "In Certain Locations" ) {
        result [ "in_certain_locations" ].push ( {
          date: row [ "date" ],
          title: row [ "title" ],
          colors: row [ "colors" ]
        } )
      } else {
        if ( !result [ "feasts" ].countries.includes ( row [ "country" ] ) ) {
          result [ "feasts" ].countries.push ( row [ "country" ] )
        }
        if ( !result [ "feasts" ].locale [ row [ "country" ] ] ) {
          result [ "feasts" ].locale [ row [ "country" ] ] = { dioceses: [], locale: {} }
        }
        if ( !result [ "feasts" ].locale [ row [ "country" ] ].dioceses.includes ( row [ "locale" ] ) ) {
          result [ "feasts" ].locale [ row [ "country" ] ].dioceses.push ( row [ "locale" ] )
          result [ "feasts" ].locale [ row [ "country" ] ].locale [ row [ "locale" ] ] = []
        }
        result [ "feasts" ].locale [ row [ "country" ] ].locale [ row [ "locale" ] ].push ( {
          date: row [ "date" ],
          title: row [ "title" ],
          colors: row [ "colors" ]
        } )
      }
    } )
    res.json ( result )
  } catch ( error ) {
    console.error ( "Error fetching locale data:", error )
    res.status ( 500 ).json ( { error: "Internal Server Error" } )
  }
} )