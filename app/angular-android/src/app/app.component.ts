import { Component } from '@angular/core'
import { RouterOutlet } from '@angular/router'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome'
import { HttpClientModule } from "@angular/common/http"
import { DataService } from './data.service' // Our Storage service which we have created
import { StatusBar, Style } from '@capacitor/status-bar'
import { TabBarComponent } from './components/tabbar/tabbar.component';

const setStatusBarStyleDark = async () => {
  await StatusBar.setBackgroundColor ( { color: "#000000" } )
  await StatusBar.setStyle ( { style: Style.Dark } )
}
setStatusBarStyleDark ( )

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    FontAwesomeModule,
    TabBarComponent,
    HttpClientModule
  ],
  providers: [
    DataService
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = "angular-android"
  theme = "light"

  constructor ( ) {
    if ( window.matchMedia && window.matchMedia ( "(prefers-color-scheme: dark)" ).matches ) {
      this.theme = "dark"
    } else {
      this.theme = "light"
    }
  }
}
