import { Component } from "@angular/core"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import { faCheck } from "@fortawesome/free-solid-svg-icons"
import * as marked from "marked"

@Component({
  templateUrl: "./modal-propers.component.html",
  styleUrl: "./modal-propers.component.css",
})
export class ModalPropersComponent {
  public celebration: any = null
  public marked = marked.parse

  public language = "English"

  faCheck = faCheck
  celebrationTitle = ""

  constructor(public activeModal: NgbActiveModal) {}

  public UpdateCelebrations(event: Event) {
    this.celebrationTitle = (<HTMLInputElement>event.target).value
  }

  public UpdateLanguage(lan: string) {
    this.language = lan
  }

  public dismiss() {
    this.activeModal.close()
  }
}
