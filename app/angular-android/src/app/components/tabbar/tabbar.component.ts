import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faCog, faHandsPraying, faCalendar } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'ordo-tabbar',
  standalone: true,
  imports: [
    RouterOutlet,
    FontAwesomeModule
  ],
  templateUrl: './tabbar.component.html'
})
export class TabBarComponent {
  title = 'angular-android';
  faCog = faCog;
  faCalendar = faCalendar;
  faPray = faHandsPraying;
  
  public navigate ( route: string ) {
    
  }
}
