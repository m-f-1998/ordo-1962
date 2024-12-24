import { Component } from "@angular/core"
import { ActivatedRoute } from "@angular/router"
import { faArrowLeft, faArrowUp } from "@fortawesome/free-solid-svg-icons"
import { DataService } from "../data.service"
import { ScrollCustomEvent } from "@ionic/angular"
import { ColorsService } from "../colors.service"
import { Location } from "@angular/common"

@Component({
    templateUrl: "./locale.component.html",
    styleUrl: "./locale.component.css",
    standalone: false
})
export class LocaleComponent {
  public locale: any = {}
  public in_certain_locations: any = []

  public faArrow = faArrowUp
  public faBack = faArrowLeft
  public scrolled = false

  public error = false
  public loading = true

  public country: string | null = null

  constructor(
    private apiRequests: DataService,
    private route: ActivatedRoute,
    private _location: Location,
    public colorSvc: ColorsService
  ) {
    this.country = this.route.snapshot.paramMap.get ( "country" )
    this.getLocale ( )
  }

  private getLocale() {
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
    } ).catch ( e => {
      console.error ( e )
      this.loading = false
      this.error = true
    } )
  }

  public GoTo ( id: string ) {
    try {
      const obj = document.querySelector ( id )
      if ( obj ) {
        obj.scrollIntoView ( { behavior: 'smooth' } )
      }
    } catch ( err ) {
      console.error ( err )
    }
  }

  public GoBack ( ) {
    this._location.back ( )
  }

  public detectScroll ( e: ScrollCustomEvent ) {
    this.scrolled = e.detail.currentY > 50
  }
}
