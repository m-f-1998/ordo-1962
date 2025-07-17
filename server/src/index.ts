import express from "express"
import type { Response } from "express"

import helmet from "helmet"
import cors from "cors"
import { randomBytes } from "crypto"

import { router as staticRouter } from "./routes/static.js"
import { router as v1_3Router } from "./v1_3/router.js"

import { connect } from "./db.js"

const app = express ( )

app.use ( express.json ( ) )
app.use ( express.urlencoded ( { extended: true } ) )

app.use ( express.json ( { limit: "1mb" } ) )
app.use ( express.urlencoded ( { limit: "1mb", extended: true } ) )

app.use ( cors ( {
  origin: [
    "http://localhost:4200",
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
        "https://fonts.googleapis.com",
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

app.use ( "/api/v1.3", v1_3Router )
app.use ( staticRouter )

await connect ( )

app.get ( "/health", ( _req, res ) => {
  res.status ( 200 ).json ( { status: "OK" } )
} )

app.listen ( 3000, ( ) => {
  console.log ( "Server running on port 3000" )
} )
