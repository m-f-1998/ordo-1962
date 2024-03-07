import { Component } from '@angular/core'
import { NgbModal } from '@ng-bootstrap/ng-bootstrap'
import { ModalTextComponent } from '../modal-text/modal-text.component'
import { HttpClient } from '@angular/common/http'
import { DataService } from '../data.service'
import { ModalPropersComponent } from '../modal-propers/modal-propers.component'
import { faCheck } from '@fortawesome/free-solid-svg-icons'

@Component({
  templateUrl: './info.component.html',
  styleUrl: './info.component.css'
})
export class InfoComponent {
  public details: any = { }
  public votives: any = { }
  public votives_of_piety: any = { }
  public votives_monday: any = { }
  public votives_tuesday: any = { }
  public votives_wednesday: any = { }
  public votives_thursday: any = { }
  public votives_friday: any = { }
  public votives_our_lady: any = { }
  public other_votives: any = { }
  public locale: any = { }

  public error = false
  public loading = true

  public option: string = "Information on the Ordo"
  public options = [ "Information on the Ordo", "Votive Masses" ]
  public faCheck = faCheck

  constructor (
    private modalService: NgbModal,
    private httpClient: HttpClient,
    private apiRequests: DataService
  ) {
    this.getDetails ( )
    this.getVotives ( )
    this.getLocale ( )
  }

  public UpdateOption ( event: Event ) {
    this.option = (<HTMLInputElement>event.target).value
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
        this.other_votives = data
      }
    } )
    this.httpClient.get ( "/assets/votives/votive-our-lady.json" )
    .subscribe ( {
      next: ( data: any ) => {
        this.votives_our_lady = data
      }
    } )
    this.httpClient.get ( "/assets/votives/votive-friday.json" )
    .subscribe ( {
      next: ( data: any ) => {
        this.votives_friday = data
      }
    } )
    this.httpClient.get ( "/assets/votives/votive-thursday.json" )
    .subscribe ( {
      next: ( data: any ) => {
        this.votives_thursday = data
      }
    } )
    this.httpClient.get ( "/assets/votives/votive-wednesday.json" )
    .subscribe ( {
      next: ( data: any ) => {
        this.votives_wednesday = data
      }
    } )
    this.httpClient.get ( "/assets/votives/votive-tuesday.json" )
    .subscribe ( {
      next: ( data: any ) => {
        this.votives_tuesday = data
      }
    } )
    this.httpClient.get ( "/assets/votives/votive-monday.json" )
    .subscribe ( {
      next: ( data: any ) => {
        this.votives_monday = data
      }
    } )
    this.httpClient.get ( "/assets/votives/votive-of-particular-piety.json" )
    .subscribe ( {
      next: ( data: any ) => {
        this.votives_of_piety = data
      }
    } )
  }

  public getKeys ( value: any ) {
    return Object.keys ( value )
  }

  public OpenText ( title: string, body: string ) {
    const propers = this.modalService.open ( ModalTextComponent, { size: 'lg', keyboard: false, centered: true } )
    propers.componentInstance.title = title
    propers.componentInstance.body = body
  }

  public OpenPropers ( celebrations: any[ ], title: string ) {
    const propers = this.modalService.open ( ModalPropersComponent, { size: 'lg', keyboard: false, centered: true } )
    propers.componentInstance.celebrations = celebrations
    propers.componentInstance.celebrationTitle = title
  }
}
