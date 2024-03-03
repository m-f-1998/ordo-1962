import { Component } from "@angular/core"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"

@Component({
  templateUrl: "./modal-text.component.html",
  styleUrl: "./modal-text.component.css",
})
export class ModalTextComponent {
  title = ""
  body = ""

  constructor(public activeModal: NgbActiveModal) {}

  public dismiss() {
    this.activeModal.close()
  }
}
