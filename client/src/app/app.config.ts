import { ApplicationConfig, CSP_NONCE, provideBrowserGlobalErrorListeners, provideZonelessChangeDetection } from "@angular/core"
import { routes } from "./app.routes"
import { provideRouter } from "@angular/router"

const nonce = document.querySelector ( 'meta[name="csp-nonce"]' )?.getAttribute ( "content" )

const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners ( ),
    provideRouter ( routes ),
    provideZonelessChangeDetection ( )
  ]
}

if ( nonce ) {
  appConfig.providers.push ( {
    provide: CSP_NONCE,
    useValue: nonce
  } )
}

export { appConfig }