import { ChangeDetectionStrategy, Component, inject } from "@angular/core"
import { SplashScreen } from "@capacitor/splash-screen"
import { Platform } from "@ionic/angular"
import { IonApp, IonRouterOutlet } from "@ionic/angular/standalone"

@Component ( {
  selector: "app-root",
  imports: [
    IonRouterOutlet,
    IonApp
  ],
  templateUrl: "./app.component.html",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class AppComponent {
  private readonly platform: Platform = inject ( Platform )

  public constructor ( ) {
    this.platform.ready ( ).then ( ( ) => {
      // Hide the splash (you should do this on app launch)
      SplashScreen.hide ( )
    } )
  }
}
