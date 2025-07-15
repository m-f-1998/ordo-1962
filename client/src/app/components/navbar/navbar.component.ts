import { CommonModule } from "@angular/common"
import { ChangeDetectionStrategy, Component, inject } from "@angular/core"
import { IconService } from "@app/services/icons.service"
import { FaIconComponent } from "@fortawesome/angular-fontawesome"
import { NgbTooltipModule } from "@ng-bootstrap/ng-bootstrap"

@Component ( {
  selector: "app-navbar",
  imports: [
    FaIconComponent,
    NgbTooltipModule,
    CommonModule
  ],
  templateUrl: "./navbar.component.html",
  styleUrl: "./navbar.component.scss",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class NavbarComponent {
  public readonly iconSvc: IconService = inject ( IconService )
}
