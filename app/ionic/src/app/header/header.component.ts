import { Component, Input } from "@angular/core"

@Component({
  selector: "app-ordo-header",
  styleUrl: "./header.component.scss",
  templateUrl: "./header.component.html",
})
export class HeaderComponent {
  @Input() index: number = 0
}
