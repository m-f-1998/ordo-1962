import express from "express"
import type { Response } from "express"

import helmet from "helmet"
import cors from "cors"
import { randomBytes } from "crypto"

import { router as staticRouter } from "./routes/static.js"
import { router as prayersRouter } from "./routes/prayers.js"
import { router as localeRouter } from "./routes/locale.js"
import { router as ordoRouter } from "./routes/ordo.js"

import { connect } from "./db.js"

const app = express ( )

app.use ( express.json ( ) )
app.use ( express.urlencoded ( { extended: true } ) )

app.use ( express.json ( { limit: "1mb" } ) )
app.use ( express.urlencoded ( { limit: "1mb", extended: true } ) )

app.use ( cors ( {
  origin: [
    "http://localhost:3000",
    "https://ordo.matthewfrankland.co.uk"
  ],
  methods: [ "GET", "POST" ],
  allowedHeaders: [ "Content-Type", "Authorization" ],
  credentials: true
} ) )

app.use ( ( _req, res, next ) => {
  const nonce = randomBytes ( 16 ).toString ( "base64" )
  res.locals [ "cspNonce" ] = nonce
  next ( )
} )

app.use ( helmet ( {
  frameguard: {
    action: "deny"
  },
  hidePoweredBy: true,
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  },
  contentSecurityPolicy: {
    directives: {
      defaultSrc: [
        "'none'",
      ],
      scriptSrc: [
        "'self'",
        "www.googletagmanager.com"
      ],
      styleSrc: [
        "'self'",
        ( _req, res ) => `'nonce-${( res as Response ).locals[ "cspNonce" ]}'`,
      ],
      scriptSrcElem: [
        ( _req, res ) => `'nonce-${( res as Response ).locals[ "cspNonce" ]}'`,
        "'self'"
      ],
      imgSrc: [
        "'self'",
        "data:",
        "https://\*.jsdelivr.net",
      ],
      connectSrc: [
        "'self'",
        "https://\*.google-analytics.com",
        "https://\*.google.com",
      ],
      frameSrc: [
        "'self'",
        "https://www.google.com",
        "https://www.youtube-nocookie.com",
      ],
      manifestSrc: [
        "'self'"
      ],
    }
  },
  noSniff: true,
  xssFilter: true,
  ieNoOpen: true
} ) )

app.use ( "/api/prayers", prayersRouter )
app.use ( "/api/locale", localeRouter )
app.use ( "/api/ordo", ordoRouter )
app.use ( staticRouter )

await connect ( )

app.get ( "/health", ( _req, res ) => {
  res.status ( 200 ).json ( { status: "OK" } )
} )

app.listen ( 3000, ( ) => {
  console.log ( "Server running on port 3000" )
} )
