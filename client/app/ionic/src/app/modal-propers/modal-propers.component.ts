import { Component } from "@angular/core"
import { Platform } from "@ionic/angular"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import * as marked from "marked"
import { Subscription } from "rxjs"

@Component ( {
  templateUrl: "./modal-propers.component.html",
  styleUrl: "./modal-propers.component.css",
  selector: "app-modal-propers",
} )
export class ModalPropersComponent {
  public celebration: any = null
  public marked = marked.parse
  public language = "English"
  public title = ""

  private backButton: Subscription

  public constructor (
    public activeModal: NgbActiveModal,
    private platform: Platform
  ) {
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
