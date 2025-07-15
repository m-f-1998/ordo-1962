import { ChangeDetectionStrategy, Component, inject, input, InputSignal } from "@angular/core"
import { Router } from "@angular/router"
import { FaIconComponent } from "@fortawesome/angular-fontawesome"
import { faCog, faHandsPraying, faCalendar, faInfoCircle } from "@fortawesome/free-solid-svg-icons"

@Component ( {
  selector: "app-ordo-tabbar",
  imports: [
    FaIconComponent
  ],
  templateUrl: "./tabbar.component.html",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class TabBarComponent {
  public faCog = faCog
  public faCalendar = faCalendar
  public faPray = faHandsPraying
  public faInfo = faInfoCircle
  public readonly index: InputSignal<number> = input<number> ( 0 )

  private readonly router: Router = inject ( Router )

  public goTo ( page: string ) {
    this.router.navigate ( [ page ] )
  }
}
