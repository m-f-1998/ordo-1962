import { Component } from '@angular/core'
import { RouterOutlet } from '@angular/router'
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome'
import { HttpClientModule } from "@angular/common/http"
import { LocalNotifications } from '@capacitor/local-notifications'
import { FormsModule } from '@angular/forms'

@Component({
  selector: 'settings-component',
  standalone: true,
  imports: [
    RouterOutlet,
    FontAwesomeModule,
    HttpClientModule,
    FormsModule
  ],
  templateUrl: './settings.component.html'
})
export class SettingsComponent {

  AngelusSix = false
  AngelusTwelve = false
  AngelusEighteen = false
new: any

  constructor ( ) {
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

  // createGoogleCal ( ) {

  // }

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
