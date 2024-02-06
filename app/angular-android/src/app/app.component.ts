import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { TabBarComponent } from './components/tabbar/tabbar.component';
import { OrdoComponent } from './components/ordo/ordo.component';
import { HttpClientModule } from "@angular/common/http";
import {StoreService} from './storage.service'; // Our Storage service which we have created

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
    StoreService
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'angular-android';
}
