import { ChangeDetectionStrategy, Component, inject, input, InputSignal } from "@angular/core"
import { ColorsService } from "../../services/colors.service"

@Component ( {
  selector: "app-locale-row",
  templateUrl: "./locale-row.component.html",
  styleUrl: "./locale-row.component.css",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class LocaleRowComponent {
  public readonly date: InputSignal<string> = input<string> ( "" )
  public readonly title: InputSignal<string> = input<string> ( "" )
  public readonly colors: InputSignal<string> = input<string> ( "" )

  public readonly colorSvc: ColorsService = inject ( ColorsService )
}