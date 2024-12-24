import { Component, Input } from "@angular/core"
import { ColorsService } from "src/app/colors.service"

@Component({
    selector: "app-locale-row",
    templateUrl: "./locale-row.component.html",
    styleUrl: "./locale-row.component.css",
    standalone: false
})
export class LocaleRowComponent {

  @Input() public date: string = ""
  @Input() public title: string = ""
  @Input() public colors: string = ""

  constructor (
    public colorSvc: ColorsService
  ) { }

}