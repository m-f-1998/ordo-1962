import { ChangeDetectionStrategy, Component, inject } from "@angular/core"
import { RouterOutlet } from "@angular/router"
import { FaConfig } from "@fortawesome/angular-fontawesome"

@Component ( {
  selector: "app-root",
  imports: [
    RouterOutlet
  ],
  templateUrl: "./app.component.html",
  styleUrl: "./app.component.scss",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class AppComponent {
  private readonly faConfig = inject ( FaConfig )

  public constructor ( ) {
    this.faConfig.autoAddCss = false
  }
}
