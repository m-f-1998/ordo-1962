import { Component } from "@angular/core"
import { faCog, faHandsPraying, faCalendar, faInfoCircle } from "@fortawesome/free-solid-svg-icons"

@Component({
  selector: "app-ordo-tabbar",
  templateUrl: "./tabbar.component.html",
})
export class TabBarComponent {
  faCog = faCog
  faCalendar = faCalendar
  faPray = faHandsPraying
  faInfo = faInfoCircle
}
