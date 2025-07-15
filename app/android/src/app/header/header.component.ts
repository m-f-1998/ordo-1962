import { ChangeDetectionStrategy, Component, input, InputSignal } from "@angular/core"
import { TabBarComponent } from "../tabbar/tabbar.component"

@Component ( {
  selector: "app-ordo-header",
  imports: [
    TabBarComponent
  ],
  templateUrl: "./header.component.html",
  styleUrl: "./header.component.scss",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class HeaderComponent {
  public readonly index: InputSignal<number> = input<number> ( 0 )
}
