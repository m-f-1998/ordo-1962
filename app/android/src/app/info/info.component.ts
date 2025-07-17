import { ChangeDetectionStrategy, Component, inject, signal, WritableSignal } from "@angular/core"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalTextComponent } from "../modal-text/modal-text.component"
import { HttpClient } from "@angular/common/http"
import { DataService } from "../services/data.service"
import { ModalPropersComponent } from "../modal-propers/modal-propers.component"
import { IonContent, IonSelect, IonSelectOption, IonSpinner } from "@ionic/angular/standalone"
import { HeaderComponent } from "../header/header.component"
import { RouterLink } from "@angular/router"

@Component ( {
  selector: "app-info",
  imports: [
    IonContent,
    HeaderComponent,
    IonSpinner,
    IonSelect,
    IonSelectOption,
    RouterLink
  ],
  templateUrl: "./info.component.html",
  styleUrl: "./info.component.css",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class InfoComponent {
  public details: any = { }
  public votives: any = { }
  public votivesOfPiety: any = { }
  public monday: any = { }
  public tuesday: any = { }
  public wednesday: any = { }
  public thursday: any = { }
  public friday: any = { }
  public ourLady: any = { }
  public otherVotives: any = { }
  public locale: any = { }

  public language: string = "English"
  public languages = [ "English", "Latin" ]

  public error: WritableSignal<boolean> = signal ( false )
  public loading: WritableSignal<boolean> = signal ( true )

  public option: string = "Information on the Ordo"
  public options = [ "Information on the Ordo", "Votive Masses" ]

  private readonly modalService: NgbModal = inject ( NgbModal )
  private readonly httpClient: HttpClient = inject ( HttpClient )
  private readonly apiRequests: DataService = inject ( DataService )

  public constructor ( ) {
    Promise.all ( [
      this.getDetails ( ),
      this.getVotives ( ),
      this.getLocale ( )
    ] ).catch ( e => {
      this.error.set ( true )
      console.error ( "Error fetching data:", e )
    } ).finally ( ( ) => {
      this.loading.set ( false )
    } )
  }

  public UpdateLanguage ( event: Event ) {
    this.language = ( <HTMLInputElement>event.target ).value
  }

  public UpdateOption ( event: Event ) {
    this.option = ( <HTMLInputElement>event.target ).value
  }

  public getKeys ( value: any ) {
    return Object.keys ( value )
  }

  public OpenText ( title: string, body: string ) {
    const propers = this.modalService.open ( ModalTextComponent, { size: "lg", keyboard: false, centered: true } )
    propers.componentInstance.title = title
    propers.componentInstance.body = body
  }

  public OpenPropers ( celebrations: any[ ], title: string ) {
    const propers = this.modalService.open ( ModalPropersComponent, { size: "lg", keyboard: false, centered: true } )
    propers.componentInstance.celebration = celebrations.find ( x => x.title == title )
    propers.componentInstance.title = title
    propers.componentInstance.language = this.language
  }


  private async getLocale ( ) {
    this.locale = await this.apiRequests.GetLocale ( )
  }

  private getDetails ( ) {
    return new Promise<void> ( ( resolve, reject ) => {
      this.httpClient.get ( "/assets/details.json" )
        .subscribe ( {
          next: ( data: any ) => {
            this.details = data
            resolve ( )
          },
          error: ( err: any ) => {
            reject ( err )
          }
        } )
    } )
  }

  private async getVotives ( ) {
    const res = await this.apiRequests.GetVotives ( )
    res.data.forEach ( ( data: any ) => {
      switch ( data.title ) {
        case "Weekly Cycle":
          this.monday = data.masses.find ( ( x: any ) => x.day === "Monday" ).votives
          this.tuesday = data.masses.find ( ( x: any ) => x.day === "Tuesday" ).votives
          this.wednesday = data.masses.find ( ( x: any ) => x.day === "Wednesday" ).votives
          this.thursday = data.masses.find ( ( x: any ) => x.day === "Thursday" ).votives
          this.friday = data.masses.find ( ( x: any ) => x.day === "Friday" ).votives
          break
        case "Our Lady":
          this.ourLady = data.masses
          break
        case "Others":
          this.otherVotives = data.masses
          break
        case "Particular Piety":
          this.votivesOfPiety = data.masses
      }
    } )
  }

}
