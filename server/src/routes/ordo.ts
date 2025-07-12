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

router.get ( "/:year", async ( req, res ) => {
  const { year } = req.params
  const yearNum = Number ( year )

  if ( !year || isNaN ( yearNum ) || yearNum < 2023 || yearNum > 2123 ) {
    res.status ( 400 ).json ( { error: "Invalid year parameter." } )
    return
  }

  const db = await connect ( )

  const ordo = await db.collection ( "universal" ).findOne ( { year: year } )

  if ( !ordo ) {
    res.status ( 404 ).json ( { error: "Ordo not found." } )
    return
  }

  res.json ( ordo )
} )

