import { ChangeDetectionStrategy, Component, inject, signal, WritableSignal } from "@angular/core"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalTextComponent } from "../modal-text/modal-text.component"
import { DataService } from "../services/data.service"
import { IonContent, IonSelect, IonSelectOption, IonSpinner } from "@ionic/angular/standalone"
import { HeaderComponent } from "../header/header.component"

@Component ( {
  selector: "app-ordo-prayer",
  imports: [
    IonSelectOption,
    IonSelect,
    IonSpinner,
    HeaderComponent,
    IonContent
  ],
  templateUrl: "./prayer.component.html",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class PrayerComponent {
  public prayers: any = { }

  public language: string = "English"
  public languages = [ "English", "Latin" ]

  public error: WritableSignal<boolean> = signal ( false )
  public loading: WritableSignal<boolean> = signal ( true )

  private readonly modalService: NgbModal = inject ( NgbModal )
  private readonly apiRequests: DataService = inject ( DataService )

  public constructor ( ) {
    this.apiRequests.GetPrayers ( ).then ( prayers => {
      this.prayers = prayers
      this.loading.set ( false )
      this.error.set ( false )
    } ).catch ( e => {
      console.error ( e )
      this.loading.set ( false )
      this.error.set ( true )
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
