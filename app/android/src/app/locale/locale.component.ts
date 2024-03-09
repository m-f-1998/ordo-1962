import { ChangeDetectorRef, Component } from "@angular/core"
import { ActivatedRoute } from "@angular/router"
import { faCheck } from "@fortawesome/free-solid-svg-icons"
import { faArrowUp } from "@fortawesome/free-solid-svg-icons"
import { DataService } from "../data.service"
import { ScrollCustomEvent } from "@ionic/angular"
import { ColorsService } from "../colors.service"

@Component({
  templateUrl: "./locale.component.html",
  styleUrl: "./locale.component.css",
})
export class LocaleComponent {
  public locale: any = {}
  public in_certain_locations: any = []

  public faCheck = faCheck
  public faArrow = faArrowUp
  public scrolled = false

  public error = false
  public loading = true

  private country: string | null = null

  constructor(
    private changeDetector: ChangeDetectorRef,
    private apiRequests: DataService,
    private route: ActivatedRoute,
    public colorSvc: ColorsService
  ) {
    this.country = this.route.snapshot.paramMap.get("country")
    this.getLocale()
  }

  private getLocale() {
    this.apiRequests
      .GetLocale()
      .then((locale) => {
        if (this.country) {
          this.locale = locale.feasts.locale[this.country]
          this.in_certain_locations = []
        } else {
          this.in_certain_locations = locale.in_certain_locations
          this.locale = {}
        }
        this.loading = false
        this.error = false
      })
      .catch(() => {
        this.loading = false
        this.error = true
      })
  }

  public GoTo(id: string) {
    const obj = document.querySelector ( id )
    try {
      if ( obj ) {
        obj.scrollIntoView({
          behavior: 'smooth',
        })
      }
      console.error ( id, obj  )
    } catch (err) {
      console.error ( err )
    }
  }

  public detectScroll ( e: ScrollCustomEvent ) {
    this.scrolled = e.detail.currentY > 50
    this.changeDetector.detectChanges()
  }

  public GetKeys(data: any) {
    return Object.keys(data)
  }
}
