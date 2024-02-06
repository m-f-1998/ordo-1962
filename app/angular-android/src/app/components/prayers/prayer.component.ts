import { Component } from '@angular/core'
import { RouterOutlet } from '@angular/router'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome'
import { HttpClient } from "@angular/common/http"
import { faCheck } from '@fortawesome/free-solid-svg-icons';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ModalTextComponent } from '../modal-text/modal-text.component';

@Component({
  selector: 'prayers-component',
  standalone: true,
  imports: [
    RouterOutlet,
    FontAwesomeModule
  ],
  templateUrl: './prayer.component.html',
  // styleUrl: './prayer.component.css'
})
export class PrayerComponent {
  public prayers: any = { }
  private version = "1.3"

  public language: string = "English"
  public languages = [ "English", "Latin" ]
  public faCheck = faCheck

  public error = false
  public loading = true
  public last_err = ""

  constructor (
    private httpClient: HttpClient,
    private modalService: NgbModal
  ) {
    let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.version}/prayers.php`
    
    this.httpClient.get<any> ( url ).subscribe (
      {
        next: ( response: any ) => {
          console.log ( response )
          this.loading = false
          this.prayers = response
        },
        error: this.handleUpdateError.bind ( this )
      }
    )
  }

  private handleUpdateError ( error: any ) {
    console.error ( error )
  }

  public UpdateLanguage ( id: string ) {
    this.language = id
  }

  public GetKeys ( data: any ) {
    if ( !data ) {
      return [ ]
    }
    return Object.keys ( data )
  }

  public OpenPrayer ( title: string, body: string ) {
    let propers = this.modalService.open ( ModalTextComponent, { size: 'lg', keyboard: false, centered: true } );
    propers.componentInstance.title = title
    propers.componentInstance.body = body
  }

}
