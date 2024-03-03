import { ChangeDetectorRef, Component, HostListener } from '@angular/core'
import { ActivatedRoute, RouterModule } from '@angular/router'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome'
import { faCheck } from '@fortawesome/free-solid-svg-icons'
import { faArrowUp } from '@fortawesome/free-solid-svg-icons'
import { DataService } from '../../data.service'

@Component({
  selector: 'app-locale-component',
  standalone: true,
  imports: [
    RouterModule,
    FontAwesomeModule
  ],
  templateUrl: './locale.component.html',
  styleUrl: './locale.component.css'
})
export class LocaleComponent {
  public locale: any = { }
  public in_certain_locations: any = [ ]

  public faCheck = faCheck
  faArrow = faArrowUp
  public windowScrolled = false

  public error = false
  public loading = true

  private country: string | null = null

  @HostListener("window:scroll", ['$event'])
  onWindowScroll ( ) {
    this.windowScrolled = window.scrollY > 50
    this.changeDetector.detectChanges ( )
  }
  scrollToTop() {
    window.scroll({
      top: 0,
      left: 0,
      behavior: 'smooth'
    });
  }

  constructor (
    private changeDetector: ChangeDetectorRef,
    private apiRequests: DataService,
    private route: ActivatedRoute
  ) {
    this.country = this.route.snapshot.paramMap.get ( 'country' )
    this.getLocale ( )
  }

  private getLocale ( ) {
    this.apiRequests.GetLocale ( ).then ( locale => {
      if ( this.country ) {
        this.locale = locale.feasts.locale [ this.country ]
        this.in_certain_locations = [ ]
      } else {
        this.in_certain_locations = locale.in_certain_locations
        this.locale = { }
      }
      this.loading = false
      this.error = false
    } ).catch ( ( ) => {
      this.loading = false
      this.error = true
    } )
  }

  public GetKeys ( data: any ) {
    return Object.keys ( data )
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
