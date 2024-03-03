import { Component } from "@angular/core"
import { NgbActiveModal } from "@ng-bootstrap/ng-bootstrap"
import { faCheck } from "@fortawesome/free-solid-svg-icons"
import * as marked from "marked"

@Component({
  templateUrl: "./modal-propers.component.html",
  styleUrl: "./modal-propers.component.css",
})
export class ModalPropersComponent {
  public celebrations: any[] = []
  public marked = marked.parse

  public language = "English"
  public languages = ["English", "Latin"]

  faCheck = faCheck

  celebrationTitle = ""

  constructor(public activeModal: NgbActiveModal) {}

  public UpdateCelebrations(title: string) {
    this.celebrationTitle = title
  }

  public UpdateLanguage(lan: string) {
    this.language = lan
  }

  public dismiss() {
    this.activeModal.close()
  }
}
