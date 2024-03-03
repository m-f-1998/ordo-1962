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
  selector: 'app-settings-component',
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
      for ( const not of pending.notifications ) {
        if ( not.id == 111 ) {
          this.AngelusSix = true
        } else if ( not.id == 222 ) {
          this.AngelusTwelve = true
        } else if ( not.id == 333 ) {
          this.AngelusEighteen = true
        }
      }
    } )
  }

  private async getCalendarID ( ): Promise<number> {
    return new Promise<number> ( ( resolve, reject ) => {
      this.calendar.listCalendars ( ).then ( async calendars => {
        for ( const calendar of calendars ) {
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
    const events = await this.calendar.listEventsInRange ( moment ( ).startOf ( "month" ).toDate ( ), moment().endOf ( "month" ).toDate ( ) )

    let index = 0

    for ( const event of events ) {
      let matched = false
      for ( const celebration of this.ordo [ this.getFullYear ( ) ] [ new Date ( ).getMonth ( ) ] [ index ] [ "celebrations" ] ) {
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
      const readwrite = await this.calendar.hasReadWritePermission ( )
      if ( !readwrite ) {
        await this.calendar.requestReadWritePermission ( )
      }
      if ( await this.calMissing ( ) ) {
        this.getCalendarID ( ).then ( async id => {
          for ( const month of this.ordo [ this.getFullYear ( ) ] ) {
            for ( const day of month ) {
              for ( const celebration of day [ "celebrations" ] ) {
                await this.calendar.createEventWithOptions ( celebration.title, undefined, celebration.commemorations.map ( ( e: any ) => {
                  return "Commemoration Today: " + e.title
                } ).join ( "\n" ), moment ( day.date.combined, "dd MMM YYYY" ).toDate ( ), moment ( day.date.combined, "dd MMM YYYY" ).add(1, "day").toDate ( ), {
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

  async TurnOnNotifications ( id: number, body: string, hour: number, minute: number, event: Event ) {
    await LocalNotifications.createChannel ( {
      id: '1',
      name: 'channel_name',
      description: 'channel_description',
      importance : 5,
      visibility: 1,
      vibration: true,
      // sound: 'sound_name.wav'
    } )
    const checked = ( <HTMLInputElement> event.target ).checked
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
          await LocalNotifications.requestPermissions ( ).then ( async res => {
            if ( res.display == "denied" ) {
              await Toast.show ( {
                text: "Notification Permissions are not Allowed on this Device."
              } )
            }
            console.error ( res )
          } )
        }

        try {
          await LocalNotifications.schedule ( {
            notifications: [
              {
                id: 444,
                title: "Test",
                body: "Test",
                channelId: "1",
                schedule: {
                  at: new Date()
                }
              }
            ]
          } )
          await LocalNotifications.schedule ( {
            notifications: [
              {
                id,
                title: "Oremus",
                channelId: "1",
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
        } catch ( e ) {
          console.error ( e )
        }
      } )
    }
  }
}
