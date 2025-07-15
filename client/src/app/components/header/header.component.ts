import { ChangeDetectionStrategy, Component } from "@angular/core"

@Component ( {
  selector: "app-header",
  imports: [],
  templateUrl: "./header.component.html",
  styleUrl: "./header.component.scss",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class HeaderComponent {

  public scrollto ( id: string ) {
    const element = document.getElementById ( id )
    if ( element ) {
      element.scrollIntoView ( { behavior: "smooth" } )
      if ( document.getElementsByClassName ( "navbar-toggler" ).length > 0 ) {
        if ( !document.getElementsByClassName ( "navbar-toggler" ) [ 0 ].classList.contains ( "collapsed" ) ) {
          ( document.getElementsByClassName ( "navbar-toggler" ) [ 0 ] as HTMLButtonElement ).click ( )
        }
      }
    }
  }

}
