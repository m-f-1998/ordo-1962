import { Component } from "@angular/core"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalTextComponent } from "../modal-text/modal-text.component"
import { HttpClient } from "@angular/common/http"
import { DataService } from "../data.service"
import { ModalPropersComponent } from "../modal-propers/modal-propers.component"

@Component ( {
  templateUrl: "./info.component.html",
  styleUrl: "./info.component.css",
  selector: "app-info",
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

  public error = false
  public loading = true

  public option: string = "Information on the Ordo"
  public options = [ "Information on the Ordo", "Votive Masses" ]

  public constructor (
    private modalService: NgbModal,
    private httpClient: HttpClient,
    private apiRequests: DataService
  ) {
    this.getDetails ( )
    this.getVotives ( )
    this.getLocale ( )
  }

  public UpdateLanguage ( event: Event ) {
    this.language = ( <HTMLInputElement>event.target ).value
  }

  public UpdateOption ( event: Event ) {
    this.option = ( <HTMLInputElement>event.target ).value
  }

  private getLocale ( ) {
    this.apiRequests.GetLocale ( ).then ( locale => {
      this.locale = locale
      this.loading = false
      this.error = false
    } ).catch ( ( ) => {
      this.loading = false
      this.error = true
    } )
  }

  private getDetails ( ) {
    this.httpClient.get ( "/assets/details.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.details = data
        }
      } )
  }

  private getVotives ( ) {
    this.httpClient.get ( "/assets/votives/other-votive-masses.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.otherVotives = data
        }
      } )
    this.httpClient.get ( "/assets/votives/votive-our-lady.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.ourLady = data
        }
      } )
    this.httpClient.get ( "/assets/votives/votive-friday.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.friday = data
        }
      } )
    this.httpClient.get ( "/assets/votives/votive-thursday.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.thursday = data
        }
      } )
    this.httpClient.get ( "/assets/votives/votive-wednesday.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.wednesday = data
        }
      } )
    this.httpClient.get ( "/assets/votives/votive-tuesday.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.tuesday = data
        }
      } )
    this.httpClient.get ( "/assets/votives/votive-monday.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.monday = data
        }
      } )
    this.httpClient.get ( "/assets/votives/votive-of-particular-piety.json" )
      .subscribe ( {
        next: ( data: any ) => {
          this.votivesOfPiety = data
        }
      } )
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
}
