import { Component } from '@angular/core'
import { RouterOutlet } from '@angular/router'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome'
import { HttpClientModule } from "@angular/common/http"

@Component({
  selector: 'settings-component',
  standalone: true,
  imports: [
    RouterOutlet,
    FontAwesomeModule,
    HttpClientModule
  ],
  templateUrl: './settings.component.html',
  // styleUrl: './settings.component.css'
})
export class SettingsComponent {

}
