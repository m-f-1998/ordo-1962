import { Component } from "@angular/core"
import { SplashScreen } from "@capacitor/splash-screen"
import { Platform } from "@ionic/angular"

@Component({
  selector: "app-root",
  templateUrl: "app.component.html"
})
export class AppComponent {
  constructor (
    public platform: Platform
  ) {
    this.platform.ready().then(() => {
      setTimeout(() => {
        SplashScreen.hide()
      }, 2000)
    })
  }
}
