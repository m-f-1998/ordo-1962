import { Component } from "@angular/core"
import { Platform } from "@ionic/angular"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import * as marked from "marked"
import { Subscription } from "rxjs"

@Component ( {
  templateUrl: "./modal-text.component.html",
  styleUrl: "./modal-text.component.css",
  selector: "app-modal-text",
} )
export class ModalTextComponent {
  public title = ""
  public body = ""
  public marked = marked.parse

  private backButton: Subscription

  public constructor (
    public activeModal: NgbActiveModal,
    private platform: Platform
  ) {
    this.backButton = this.platform.backButton.subscribe ( ( ) => {
      this.dismiss ( )
    } )
  }

  public dismiss () {
    this.activeModal.close ()
    this.backButton.unsubscribe ( )
  }
}
