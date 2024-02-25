import { Component } from '@angular/core'
import { NgbModal } from '@ng-bootstrap/ng-bootstrap'
import { ModalTextComponent } from '../modal-text/modal-text.component'
import { HttpClient } from '@angular/common/http'
import { DataService } from '../../data.service'
import { ModalPropersComponent } from '../modal-propers/modal-propers.component'
import { Preferences } from '@capacitor/preferences'
import { faCheck } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome'
import { RouterModule } from '@angular/router'

@Component({
  standalone: true,
  imports: [
    FontAwesomeModule,
    RouterModule
  ],
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

  public language: string = "English"
  public languages = [ "English", "Latin" ]

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

  public UpdateLanguage ( id: string ) {
    this.language = id
    Preferences.set ( {
      key: "language",
      value: this.language
    } )
  }

  public UpdateOption ( id: string ) {
    this.option = id
  }

  private getLocale ( ) {
    this.apiRequests.GetLocale ( ).then ( locale => {
      this.locale = locale
      this.loading = false
      this.error = false
    } ).catch ( ( e: any) => {
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
    let propers = this.modalService.open ( ModalTextComponent, { size: 'lg', keyboard: false, centered: true } )
    propers.componentInstance.title = title
    propers.componentInstance.body = body.trimStart ( )
  }

  public OpenPropers ( celebrations: any[ ] ) {
    let propers = this.modalService.open ( ModalPropersComponent, { size: 'lg', keyboard: false, centered: true } )
    propers.componentInstance.celebrations = celebrations
    propers.componentInstance.celebrationTitle = celebrations [ 0 ].title
    propers.componentInstance.language = this.language
  }
}
