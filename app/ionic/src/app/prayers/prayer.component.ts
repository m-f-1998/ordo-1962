import { Component } from "@angular/core"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalTextComponent } from "../modal-text/modal-text.component"
import { DataService } from "../data.service"

@Component ( {
  templateUrl: "./prayer.component.html",
  selector: "app-ordo-prayer",
} )
export class PrayerComponent {
  public prayers: any = { }

  public language: string = "English"
  public languages = [ "English", "Latin" ]

  public error = false
  public loading = true

  public constructor (
    private modalService: NgbModal,
    private apiRequests: DataService
  ) {
    this.apiRequests.GetPrayers ( ).then ( prayers => {
      this.prayers = prayers
      this.loading = false
      this.error = false
    } ).catch ( e => {
      console.error ( e )
      this.loading = false
      this.error = true
    } )
  }

  public UpdateLanguage ( event: Event ) {
    this.language = ( <HTMLInputElement>event.target ).value
  }

  public GetKeys ( data: any ) {
    if ( !data ) {
      return []
    }
    return Object.keys ( data )
  }

  public OpenPrayer ( title: string, body: string ) {
    const propers = this.modalService.open ( ModalTextComponent, {
      size: "lg",
      keyboard: false,
      centered: true,
    } )
    propers.componentInstance.title = title
    propers.componentInstance.body = body
  }
}
