import { Component } from "@angular/core"
import { SplashScreen } from "@capacitor/splash-screen"
import { Platform } from "@ionic/angular"

@Component({
  selector: "app-root",
  templateUrl: "app.component.html"
})
export class AppComponent {
  constructor (
    private platform: Platform
  ) {
    this.platform.ready ( ).then ( ( ) => {
      // Hide the splash (you should do this on app launch)
      SplashScreen.hide ( )
    } )
  }
}
