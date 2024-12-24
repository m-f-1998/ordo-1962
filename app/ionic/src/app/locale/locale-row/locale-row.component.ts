import { Component, input, InputSignal } from "@angular/core"
import { ColorsService } from "src/app/colors.service"

@Component ( {
  selector: "app-locale-row",
  templateUrl: "./locale-row.component.html",
  styleUrl: "./locale-row.component.css",
} )
export class LocaleRowComponent {

  public readonly date: InputSignal<string> = input<string> ( "" )
  public readonly title: InputSignal<string> = input<string> ( "" )
  public readonly colors: InputSignal<string> = input<string> ( "" )

  public constructor (
    public colorSvc: ColorsService
  ) { }

}