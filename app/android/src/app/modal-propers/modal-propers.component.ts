import { ChangeDetectionStrategy, Component, inject } from "@angular/core"
import { Platform } from "@ionic/angular"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import * as marked from "marked"
import { Subscription } from "rxjs"

@Component ( {
  selector: "app-modal-propers",
  templateUrl: "./modal-propers.component.html",
  styleUrl: "./modal-propers.component.css",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class ModalPropersComponent {
  public celebration: any = null
  public marked = marked.parse
  public language = "English"
  public title = ""

  public readonly activeModal: NgbActiveModal = inject ( NgbActiveModal )
  private readonly platform: Platform = inject ( Platform )

  private backButton: Subscription

  public constructor ( ) {
    this.backButton = this.platform.backButton.subscribe ( ( ) => {
      this.dismiss ( )
    } )
  }

  public UpdateCelebrations ( event: Event ) {
    this.title = ( <HTMLInputElement>event.target ).value
  }

  public UpdateLanguage ( lan: string ) {
    this.language = lan
  }

  public dismiss () {
    this.activeModal.close ( )
    this.backButton.unsubscribe ( )
  }
}
