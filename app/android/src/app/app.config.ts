import { provideRouter, RouteReuseStrategy } from "@angular/router"
import { provideIonicAngular, IonicRouteStrategy } from "@ionic/angular/standalone"
import { provideHttpClient, withFetch } from "@angular/common/http"
import { ApplicationConfig, provideZonelessChangeDetection } from "@angular/core"
import { routes } from "./app.routes"

export const appConfig: ApplicationConfig = {
  providers: [
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    provideIonicAngular ( ),
    provideHttpClient (
      withFetch ( )
    ),
    provideRouter ( routes ),
    provideZonelessChangeDetection ( )
  ]
}
