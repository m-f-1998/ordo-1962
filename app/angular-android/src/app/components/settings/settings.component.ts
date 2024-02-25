import { Component } from '@angular/core'
import { RouterOutlet } from '@angular/router'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome'
import { HttpClientModule } from "@angular/common/http"
import { LocalNotifications } from '@capacitor/local-notifications'
import { FormsModule } from '@angular/forms'
import { Calendar } from "@awesome-cordova-plugins/calendar/ngx"
import { DataService } from '../../data.service'
import moment from "moment"
import { Toast } from '@capacitor/toast';

@Component({
  selector: 'settings-component',
  standalone: true,
  imports: [
    RouterOutlet,
    FontAwesomeModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [
    Calendar
  ],
  templateUrl: './settings.component.html'
})
export class SettingsComponent {

  public ordo: any = { }

  public loading = true
  public error = false

  AngelusSix = false
  AngelusTwelve = false
  AngelusEighteen = false

  constructor (
    private calendar: Calendar,
    private apiRequests: DataService
  ) {
    this.apiRequests.GetOrdo ( ).then ( ordo => {
      this.ordo = ordo
      this.loading = false
      this.error = false
    } ).catch ( e => {
      console.error ( e )
      this.loading = false
      this.error = true
    } )
    LocalNotifications.getPending ( ).then ( pending => {
      for ( let not of pending.notifications ) {
        if ( not.id == 0 ) {
          this.AngelusSix = true
        } else if ( not.id == 1 ) {
          this.AngelusTwelve = true
        } else if ( not.id == 2 ) {
          this.AngelusEighteen = true
        }
      }
    } )
  }

  private async getCalendarID ( ): Promise<number> {
    return new Promise<number> ( ( resolve, reject ) => {
      this.calendar.listCalendars ( ).then ( async calendars => {
        for ( let calendar of calendars ) {
          await this.calendar.deleteCalendar ( calendar.id )
          if ( calendar.isPrimary ) {
            resolve ( calendar.id )
            return
          }
        }
        resolve ( -1 )
      } ).catch ( async ( e: any ) => {
        reject ( e )
      } )
    } )
  }

  private async handleGoogleCalError ( e: string ) {
    console.error ( e )
    await Toast.show ( {
      text: "Calendar Could Not Be Created"
    } )
  }

  private async calMissing ( ) {
    let events = await this.calendar.listEventsInRange ( moment ( ).startOf ( "month" ).toDate ( ), moment().endOf ( "month" ).toDate ( ) )

    let index = 0

    for ( let event of events ) {
      let matched = false
      for ( let celebration of this.ordo [ this.getFullYear ( ) ] [ new Date ( ).getMonth ( ) ] [ index ] [ "celebrations" ] ) {
        if ( event.title == celebration.title ) {
          matched = true
          break
        }
      }
      if ( !matched ) {
        return false
      }
      index += 1
    }

    return true
  }

  async createGoogleCal ( ) {
    if ( Object.keys ( this.ordo ).length > 0 ) {
      let readwrite = await this.calendar.hasReadWritePermission ( )
      if ( !readwrite ) {
        await this.calendar.requestReadWritePermission ( )
      }
      if ( await this.calMissing ( ) ) {
        this.getCalendarID ( ).then ( async id => {
          for ( let month of this.ordo [ this.getFullYear ( ) ] ) {
            for ( let day of month ) {
              for ( let celebration of day [ "celebrations" ] ) {
                await this.calendar.createEventWithOptions ( celebration.title, undefined, celebration.commemorations.map ( ( e: any ) => {
                  return "Commemoration Today: " + e.title
                } ).join ( "\n" ), moment ( day.date.combined, "DD MMM YYYY" ).toDate ( ), moment ( day.date.combined, "DD MMM YYYY" ).add(1, "day").toDate ( ), {
                  "calendarId": id
                }  )
              }
            }
          }
          await Toast.show ( {
            text: "Calendar Created"
          } )
        } ).catch ( ( e: any ) => {
          this.handleGoogleCalError ( e )
        } )
      } else {
        await Toast.show ( {
          text: "Calendar Appears To Exist"
        } )
      }
    } else {
      this.handleGoogleCalError ( "No Ordo Available" )
    }
  }

  getFullYear ( ) {
    return new Date().getFullYear()
  }

  TurnOnNotifications ( id: number, body: string, hour: number, minute: number, event: Event ) {
    let checked = ( <HTMLInputElement> event.target ).checked
    if ( !checked ) {
      LocalNotifications.cancel ( {
        "notifications": [
          {
            "id": id
          }
        ]
      } )
    } else {
      LocalNotifications.checkPermissions ( ).then ( async permissions => {
        if ( String ( permissions.display ) !== "granted" ) {
          console.error ( "Local Permissions Error" )
          console.error ( permissions.display )
          await LocalNotifications.requestPermissions ( )
        }

        LocalNotifications.schedule ( {
          notifications: [
            {
              id,
              title: "Oremus",
              body,
              schedule: {
                repeats: true,
                every: "day",
                on: {
                  hour,
                  minute
                },
                allowWhileIdle: true
            }
            }
          ]
        } )
      } )
    }
  }
}
