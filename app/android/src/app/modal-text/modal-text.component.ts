import { Component } from "@angular/core"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import * as marked from "marked"

@Component({
  templateUrl: "./modal-text.component.html",
  styleUrl: "./modal-text.component.css",
})
export class ModalTextComponent {
  public title = ""
  public body = ""
  public marked = marked.parse

  constructor(public activeModal: NgbActiveModal) {}

  public dismiss() {
    this.activeModal.close()
  }
}
