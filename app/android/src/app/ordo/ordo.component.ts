import { ChangeDetectorRef, Component } from "@angular/core"
import { Router } from "@angular/router"
import { faArrowUp } from "@fortawesome/free-solid-svg-icons"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalPropersComponent } from "../modal-propers/modal-propers.component"
import { DataService } from "../data.service"
import { format, isToday, parse } from "date-fns"
import { ScrollCustomEvent } from "@ionic/angular"
import { ColorsService } from "../colors.service"

@Component({
  templateUrl: "./ordo.component.html",
  styleUrl: "./ordo.component.scss",
})
export class OrdoComponent {
  public ordo: any = {}

  public year = "2024"
  public language = "English"
  public languages = ["English", "Latin"]

  public months = Array.from ( { length: 12 }, ( _, i ) => format ( new Date ( ).setMonth ( i ), "LLLL" ) )

  public faArrow = faArrowUp

  public loading = true
  public error = false
  public scrolled = false

  constructor(
    private modalService: NgbModal,
    private apiRequests: DataService,
    private changeDetector: ChangeDetectorRef,
    private router: Router,
    public colorSvc: ColorsService
  ) {
    this.apiRequests.GetOrdo ( ).then ( ordo => {
      this.ordo = ordo
      this.loading = false
      this.error = false

      if ( !( this.router.getCurrentNavigation()?.previousNavigation ) ) {
        setTimeout ( ( ) => this.GoTo ( "#today" ), 100 )
      }
    } ).catch ( e => {
      console.error ( e )
      this.loading = false
      this.error = true
    } )
  }

  public detectScroll ( e: ScrollCustomEvent ) {
    this.scrolled = e.detail.currentY > 50
    this.changeDetector.detectChanges ( )
  }

  public IsCurrentYear ( ): boolean {
    return this.year == String ( new Date ( ).getFullYear ( ) )
  }

  public IsToday ( date: any ): boolean {
    return isToday ( parse ( date.combined, "dd MMM yyyy", new Date ( ) ) )
  }

  public UpdateYear ( event: Event ) {
    this.year = ( <HTMLInputElement> event.target ).value
  }

  public UpdateLanguage ( event: Event ) {
    this.language = ( <HTMLInputElement> event.target ).value
  }

  public YearRange() {
    return Array.from ( { length: 6 }, ( _, i ) => new Date ( ).getFullYear ( ) + i )
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

  public OpenPropers(celebration: any) {
    const propers = this.modalService.open ( ModalPropersComponent, {
      size: "lg",
      keyboard: false,
      centered: true,
    } )
    propers.componentInstance.celebration = celebration
    propers.componentInstance.title = celebration.title
    propers.componentInstance.language = this.language
  }
}
