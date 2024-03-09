import { Component } from "@angular/core"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import * as marked from "marked"

@Component({
  templateUrl: "./modal-propers.component.html",
  styleUrl: "./modal-propers.component.css",
})
export class ModalPropersComponent {
  public celebration: any = null
  public marked = marked.parse

  public language = "English"

  public title = ""

  constructor(public activeModal: NgbActiveModal) { }

  public UpdateCelebrations(event: Event) {
    this.title = (<HTMLInputElement>event.target).value
  }

  public UpdateLanguage(lan: string) {
    this.language = lan
  }

  public dismiss() {
    this.activeModal.close()
  }
}
