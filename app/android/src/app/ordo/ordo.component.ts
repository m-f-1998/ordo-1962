import { Component } from "@angular/core"
import { Router } from "@angular/router"
import { faArrowUp } from "@fortawesome/free-solid-svg-icons"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalPropersComponent } from "../modal-propers/modal-propers.component"
import { DataService } from "../data.service"
import { format, isToday, parse } from "date-fns"
import { Platform, ScrollCustomEvent } from "@ionic/angular"
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

  constructor (
    private modalService: NgbModal,
    private apiRequests: DataService,
    private router: Router,
    public colorSvc: ColorsService,
    public platform: Platform,
  ) {
    this.apiRequests.GetOrdo ( ).then ( ordo => {
      this.ordo = ordo

      if ( !( this.router.getCurrentNavigation()?.previousNavigation ) ) {
        this.loading = false
        this.error = false
      }
    } ).catch ( e => {
      console.error ( e )
      this.loading = false
      this.error = true
    } )
  }

  public detectScroll ( e: ScrollCustomEvent ) {
    this.scrolled = e.detail.currentY > 50
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
      console.log ( obj )
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

  public trackByMonth(index: number, month: any): any {
    return month[0].date.month;
  }

  public trackByDay(index: number, day: any): any {
    return day.date;
  }

  public trackByCeleb(index: number, celeb: any): any {
    return celeb.title;
  }

  public trackByCommem(index: number, commem: any): any {
    return commem.title;
  }
}