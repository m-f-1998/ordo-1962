import { enableProdMode } from "@angular/core"
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic"

import { AppModule } from "./app/app.module"
import { environment } from "./environments/environment"

if ( environment.production ) {
  enableProdMode ()
}

platformBrowserDynamic ()
  .bootstrapModule ( AppModule )
  .catch ( ( err ) => console.log ( err ) )

window.matchMedia ( "(prefers-color-scheme: dark)" ).addEventListener ( "change", ( event ) => {
  const color = event.matches ? "dark" : "light"
  document.getElementsByTagName ( "html" )[0].setAttribute ( "data-bs-theme", color )
} )

if ( window.matchMedia && window.matchMedia ( "(prefers-color-scheme: dark)" ).matches ) {
  document.getElementsByTagName ( "html" )[0].setAttribute ( "data-bs-theme", "dark" )
} else {
  document.getElementsByTagName ( "html" )[0].setAttribute ( "data-bs-theme", "light" )
}
