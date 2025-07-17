import { Router } from "express"
import { router as prayersRouter } from "./prayers.js"
import { router as localeRouter } from "./locale.js"
import { router as ordoRouter } from "./ordo.js"
import { router as votivesRouter } from "./votives.js"

export const router = Router ( )

router.use ( "/prayers", prayersRouter )
router.use ( "/locale", localeRouter )
router.use ( "/ordo", ordoRouter )
router.use ( "/votives", votivesRouter )