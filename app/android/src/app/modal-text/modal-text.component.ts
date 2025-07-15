import { ChangeDetectionStrategy, Component, inject } from "@angular/core"
import { Platform } from "@ionic/angular"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import * as marked from "marked"
import { Subscription } from "rxjs"

@Component ( {
  selector: "app-modal-text",
  templateUrl: "./modal-text.component.html",
  styleUrl: "./modal-text.component.css",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class ModalTextComponent {
  public title = ""
  public body = ""
  public marked = marked.parse

  public readonly activeModal: NgbActiveModal = inject ( NgbActiveModal )
  private readonly platform: Platform = inject ( Platform )

  private backButton: Subscription

  public constructor ( ) {
    this.backButton = this.platform.backButton.subscribe ( ( ) => {
      this.dismiss ( )
    } )
  }

  public dismiss () {
    this.activeModal.close ()
    this.backButton.unsubscribe ( )
  }
}
