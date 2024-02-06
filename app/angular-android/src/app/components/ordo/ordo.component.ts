import { Component, HostListener } from '@angular/core'
import { RouterOutlet } from '@angular/router'
import { HttpClient, HttpParams } from '@angular/common/http'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faCheck } from '@fortawesome/free-solid-svg-icons';
import { ViewportScroller, CommonModule } from "@angular/common";
import { faArrowUp } from '@fortawesome/free-solid-svg-icons';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ModalPropersComponent } from '../modal-propers/modal-propers.component';

@Component({
  selector: 'ordo-component',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    FontAwesomeModule
  ],
  templateUrl: './ordo.component.html',
  styleUrl: './ordo.component.css'
})
export class OrdoComponent {
  public ordo: any [ ] = [ ]

  public language = "English"
  public languages = [ "English", "Latin" ]
  
  private version = "1.3"
  public year = "2024"

  public error = false
  public loading = true
  public last_err = ""

  public faCheck = faCheck
  public months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]
  faArrow = faArrowUp
  windowScrolled: boolean = false;

  @HostListener("window:scroll", [])
  onWindowScroll() {
    if ( window.scrollY || document.documentElement.scrollTop || document.body.scrollTop > 100 ) {
      this.windowScrolled = true;
    } else if ( this.windowScrolled && window.scrollY || document.documentElement.scrollTop || document.body.scrollTop < 10 ) {
      this.windowScrolled = false;
    }
  }
  scrollToTop() {
    window.scroll({ 
      top: 0, 
      left: 0, 
      behavior: 'smooth' 
    });
  }

  constructor (
    private httpClient: HttpClient,
    private scroller: ViewportScroller,
    private modalService: NgbModal
  ) {
    let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.version}/ordo.php`
    let params = new HttpParams ( ).set ( "year", this.year )
    
    this.httpClient.get<any> ( url, { params: params } ).subscribe (
      {
        next: ( response: any ) => {
          console.log ( response )
          this.loading = false
          this.ordo = response.Ordo
        },
        error: this.handleUpdateError.bind ( this )
      }
    )
  }

  public UpdateYear ( year: string ) {
    this.ordo = [ ]
    this.loading = true
    let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.version}/ordo.php`
    let params = new HttpParams ( ).set ( "year", year );

    this.httpClient.get<any> ( url, { params: params } ).subscribe (
      {
        next: ( response: any ) => {
          this.loading = false
          this.year = year
          this.ordo = response.Ordo
        },
        error: this.handleUpdateError.bind ( this )
      }
    );
  }

  private handleUpdateError ( error: any ) {
    this.last_err = error
    this.error = true
    this.loading = false
    console.error ( error )
  }

  public YearRange ( ) {
    var currentYear = new Date ( ).getFullYear ( )
    var res = [ ]
    for ( var i=currentYear; i<currentYear + 5; i++ ) {
      res.push ( i )
    }
    return res
  }

  public GoTo ( id: string ) {
    this.scroller.scrollToAnchor ( id );
  }

  public translateColor ( id: string ) {
    switch ( id.split(",")[0] ) {
      case "y":
        return "gold"
      case "b":
        return "black"
      case "w":
        return "white"
      case "r":
        return "red"
      case "o":
        return "orange"
      case "g":
        return "lime"
      case "v":
        return "violet"
      case "p":
        return "pink"
      default:
        return "white"
    }
  }

  public getForegroundColor ( id: string ) {
    switch ( id.split(",")[0] ) {
      case "b":
        return "white"
      case "r":
        return "white"
      default:
        return "black"
    }
  }

  public UpdateLanguage ( id: string ) {
    this.language = id
  }

  public OpenPropers ( celebrations: any[] ) {
    let propers = this.modalService.open ( ModalPropersComponent, { size: 'lg', keyboard: false, centered: true } );
    propers.componentInstance.celebrations = celebrations
    propers.componentInstance.celebrationTitle = celebrations [ 0 ].title
    propers.componentInstance.language = this.language
  }

}
