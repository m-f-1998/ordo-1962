import { Component } from '@angular/core'
import { RouterOutlet } from '@angular/router'
import { HttpClient, HttpParams } from '@angular/common/http'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faCheck } from '@fortawesome/free-solid-svg-icons';
import { ViewportScroller } from "@angular/common";

@Component({
  selector: 'ordo-component',
  standalone: true,
  imports: [
    RouterOutlet,
    FontAwesomeModule
  ],
  templateUrl: './ordo.component.html',
  styleUrl: './ordo.component.css'
})
export class OrdoComponent {
  public ordo: any [ ] = [ ]
  
  private version = "1.3"
  public year = "2024"

  public faCheck = faCheck
  public months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]

  constructor (
    private httpClient: HttpClient,
    private scroller: ViewportScroller
  ) {
    let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.version}/ordo.php`
    let params = new HttpParams ( ).set ( "year", this.year );
    
    this.httpClient.get<any> ( url, { params: params } ) .subscribe (
      {
        next: ( response: any ) => {
          console.log ( response )
          this.ordo = response.Ordo
        },
        error: this.handleUpdateError.bind ( this )
      }
    );
  }

  public UpdateYear ( year: string ) {
    let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.version}/ordo.php`
    let params = new HttpParams ( ).set ( "year", year );

    this.httpClient.get<any> ( url, { params: params } ) .subscribe (
      {
        next: ( response: any ) => {
          console.log ( response )
          this.year = year
          this.ordo = response.Ordo
        },
        error: this.handleUpdateError.bind ( this )
      }
    );
  }

  private handleUpdateError ( error: any ) {
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

}
