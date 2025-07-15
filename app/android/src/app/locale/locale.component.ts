import { ChangeDetectionStrategy, Component, inject } from "@angular/core"
import { ActivatedRoute } from "@angular/router"
import { faArrowLeft, faArrowUp } from "@fortawesome/free-solid-svg-icons"
import { DataService } from "../services/data.service"
import { ScrollCustomEvent } from "@ionic/angular"
import { ColorsService } from "../services/colors.service"
import { Location } from "@angular/common"
import { FaIconComponent } from "@fortawesome/angular-fontawesome"
import { IonButton, IonContent, IonSpinner } from "@ionic/angular/standalone"
import { LocaleRowComponent } from "./locale-row/locale-row.component"
import { HeaderComponent } from "../header/header.component"

@Component ( {
  selector: "app-locale",
  imports: [
    FaIconComponent,
    IonButton,
    LocaleRowComponent,
    IonSpinner,
    HeaderComponent,
    IonContent
  ],
  templateUrl: "./locale.component.html",
  styleUrl: "./locale.component.css",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class LocaleComponent {
  public locale: any = {}
  public inCertainLocations: any = []

  public faArrow = faArrowUp
  public faBack = faArrowLeft
  public scrolled = false

  public error = false
  public loading = true

  public country: string | null = null

  public readonly colorSvc: ColorsService = inject ( ColorsService )
  private readonly apiRequests: DataService = inject ( DataService )
  private readonly route: ActivatedRoute = inject ( ActivatedRoute )
  private readonly location: Location = inject ( Location )

  public constructor ( ) {
    this.country = this.route.snapshot.paramMap.get ( "country" )
    this.getLocale ( )
  }

  public GoTo ( id: string ) {
    try {
      const obj = document.querySelector ( id )
      if ( obj ) {
        obj.scrollIntoView ( { behavior: "smooth" } )
      }
    } catch ( err ) {
      console.error ( err )
    }
  }

  public GoBack ( ) {
    this.location.back ( )
  }

  public detectScroll ( e: ScrollCustomEvent ) {
    this.scrolled = e.detail.currentY > 50
  }

  private getLocale ( ) {
    this.apiRequests.GetLocale ( ).then ( locale => {
      if ( this.country ) {
        this.locale = locale.feasts.locale [ this.country ]
        this.inCertainLocations = [ ]
      } else {
        this.inCertainLocations = locale.in_certain_locations
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
}
