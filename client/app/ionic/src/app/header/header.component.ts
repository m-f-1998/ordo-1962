import { Component, input, InputSignal } from "@angular/core"

@Component ( {
  selector: "app-ordo-header",
  styleUrl: "./header.component.scss",
  templateUrl: "./header.component.html",
} )
export class HeaderComponent {
  public readonly index: InputSignal<number> = input<number> ( 0 )
}
