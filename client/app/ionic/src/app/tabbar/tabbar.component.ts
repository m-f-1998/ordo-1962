import { Component, input, InputSignal } from "@angular/core"
import { faCog, faHandsPraying, faCalendar, faInfoCircle } from "@fortawesome/free-solid-svg-icons"

@Component ( {
  selector: "app-ordo-tabbar",
  templateUrl: "./tabbar.component.html"
} )
export class TabBarComponent {
  public faCog = faCog
  public faCalendar = faCalendar
  public faPray = faHandsPraying
  public faInfo = faInfoCircle
  public readonly index: InputSignal<number> = input<number> ( 0 )
}
