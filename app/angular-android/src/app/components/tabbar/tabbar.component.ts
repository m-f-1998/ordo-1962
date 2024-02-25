import { Component } from '@angular/core'
import { RouterModule } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faCog, faHandsPraying, faCalendar, faInfoCircle } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'ordo-tabbar',
  standalone: true,
  imports: [
    RouterModule,
    FontAwesomeModule
  ],
  templateUrl: './tabbar.component.html'
})
export class TabBarComponent {
  title = 'angular-android'
  faCog = faCog
  faCalendar = faCalendar
  faPray = faHandsPraying
  faInfo = faInfoCircle
}
