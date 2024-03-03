import { Component } from "@angular/core"
import { faCheck } from "@fortawesome/free-solid-svg-icons"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalTextComponent } from "../modal-text/modal-text.component"
import { DataService } from "../data.service"

@Component({
  templateUrl: "./prayer.component.html",
})
export class PrayerComponent {
  public prayers: any = {}

  public language: string = "English"
  public languages = ["English", "Latin"]
  public faCheck = faCheck

  public error = false
  public loading = true

  constructor(private modalService: NgbModal, private apiRequests: DataService) {
    this.apiRequests
      .GetPrayers()
      .then((prayers) => {
        this.prayers = prayers
        this.loading = false
        this.error = false
      })
      .catch((e) => {
        console.error(e)
        this.loading = false
        this.error = true
      })
  }

  public UpdateLanguage(id: string) {
    this.language = id
  }

  public GetKeys(data: any) {
    if (!data) {
      return []
    }
    return Object.keys(data)
  }

  public OpenPrayer(title: string, body: string) {
    const propers = this.modalService.open(ModalTextComponent, {
      size: "lg",
      keyboard: false,
      centered: true,
    })
    propers.componentInstance.title = title
    propers.componentInstance.body = body
  }
}
