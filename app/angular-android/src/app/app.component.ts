import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { TabBarComponent } from './components/tabbar/tabbar.component';
import { OrdoComponent } from './components/ordo/ordo.component';
import { HttpClientModule } from "@angular/common/http";
import { DataService } from './data.service'; // Our Storage service which we have created
import { StatusBar, Style } from '@capacitor/status-bar';

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
    OrdoComponent,
    HttpClientModule
  ],
  providers: [
    DataService
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'angular-android'

  constructor ( ) { }
}
