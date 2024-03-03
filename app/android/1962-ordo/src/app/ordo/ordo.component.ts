import { ChangeDetectorRef, Component, ViewChild } from "@angular/core"
import { Router } from "@angular/router"
import { faCheck } from "@fortawesome/free-solid-svg-icons"
import { ViewportScroller } from "@angular/common"
import { faArrowUp } from "@fortawesome/free-solid-svg-icons"
import { NgbModal } from "@ng-bootstrap/ng-bootstrap"
import { ModalPropersComponent } from "../modal-propers/modal-propers.component"
import { DataService } from "../data.service"
import { differenceInCalendarDays, parse } from "date-fns"
import { ScrollCustomEvent } from "@ionic/angular"
import { IonContent } from '@ionic/angular'

@Component({
  templateUrl: "./ordo.component.html",
  styleUrl: "./ordo.component.scss",
})
export class OrdoComponent {
  public ordo: any = {}

  public loading = true
  public error = false

  public year = "2024"

  public faCheck = faCheck
  public months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ]
  faArrow = faArrowUp
  public windowScrolled = false
  @ViewChild(IonContent) content!: IonContent;

  scrollToTop() {
    this.content.scrollToTop()
  }

  detectScroll ( e: ScrollCustomEvent ) {
    this.windowScrolled = e.detail.currentY > 50
    this.changeDetector.detectChanges()
  }

  constructor(
    private scroller: ViewportScroller,
    private modalService: NgbModal,
    private apiRequests: DataService,
    private changeDetector: ChangeDetectorRef,
    private router: Router,
  ) {
    const prev = this.router.getCurrentNavigation()!.previousNavigation

    this.apiRequests
      .GetOrdo()
      .then((ordo) => {
        this.ordo = ordo
        this.loading = false
        this.error = false

        if (prev == null) {
          setTimeout(() => {
            this.GoTo ( "#today" )
          }, 100)
        }
      })
      .catch((e) => {
        console.error(e)
        this.loading = false
        this.error = true
      })
  }

  public isToday(date: any): boolean {
    return differenceInCalendarDays(parse(date.combined, "dd MMM yyyy", new Date()), new Date()) === 0
  }

  public UpdateYear(year: string) {
    this.year = year
  }

  public YearRange() {
    const currentYear = new Date().getFullYear()
    const res = []
    for (let i = currentYear; i <= currentYear + 5; i++) {
      res.push(i)
    }
    return res
  }

  public GoTo(id: string) {
    const obj = document.querySelector ( id )
    try {
      if ( obj ) {
        obj.scrollIntoView({
          behavior: 'smooth',
        });
      }
      console.error ( "Today Not Found" )
    } catch (err) {
      console.error ( err )
    }
  }

  public translateColor(id: string) {
    switch (id.split(",")[0]) {
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

  public getForegroundColor(id: string) {
    switch (id.split(",")[0]) {
      case "b":
        return "white"
      case "r":
        return "white"
      default:
        return "black"
    }
  }

  public OpenPropers(celebrations: any[]) {
    const propers = this.modalService.open(ModalPropersComponent, {
      size: "lg",
      keyboard: false,
      centered: true,
      modalDialogClass: "test",
    })
    propers.componentInstance.celebrations = celebrations
    propers.componentInstance.celebrationTitle = celebrations[0].title
  }
}
