import express, { Router, Request } from "express"
import type { Response } from "express"
import { join, resolve } from "path"
import { existsSync } from "fs"
import { readFile } from "fs/promises"
import { rateLimit } from "express-rate-limit"
import { config } from "dotenv"

const envPath = resolve ( process.cwd ( ), ".env" )
config ( { path: envPath, quiet: true } )

export const router = Router ( )

router.use ( rateLimit ( {
  windowMs: 60 * 1000, // 1 minute
  max: 500, // limit each IP to 500 requests per windowMs
  standardHeaders: true, // Return rate limit info in the `RateLimit-*` headers
  legacyHeaders: false, // Disable the `X-RateLimit-*` headers
  message: {
    status: 429,
    error: "Too many requests, please try again later.",
    description: "You have exceeded the maximum number of requests allowed. Please wait a minute before trying again."
  }
} ) )

router.use ( express.static ( join ( process.cwd ( ), "../client" ), {
  maxAge: "1d",
  etag: true,
  index: false,
} ) )

router.get ( "*get", async ( _req: Request, res: Response ) => {
  const indexPath = join ( process.cwd ( ), "../client/index.html" )
  if ( existsSync ( indexPath ) ) {
    let html = await readFile ( indexPath, "utf8" )
    const nonce = res.locals [ "cspNonce" ]
    const metaTag = `<meta name="csp-nonce" content="${nonce}">`
    html = html.replace ( "</head>", `<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" nonce="${nonce}"></head>` )
    html = html.replace ( "</head>", `${metaTag}</head>` )
    res.send ( html )
  } else {
    res.status ( 404 ).send ( "Index file not found." )
  }
} )