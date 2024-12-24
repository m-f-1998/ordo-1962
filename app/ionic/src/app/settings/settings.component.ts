import { Component } from "@angular/core"
import { LocalNotifications, PendingLocalNotificationSchema } from "@capacitor/local-notifications"
import { Toast } from "@capacitor/toast"

@Component({
    templateUrl: "./settings.component.html",
    standalone: false
})
export class SettingsComponent {
  public disabled = false
  public active_notifications: number [ ] = [ ]

  constructor ( ) {
    LocalNotifications.checkPermissions ( ).then ( permissions => {
      if ( permissions.display !== "granted" ) {
        LocalNotifications.requestPermissions ( ).then ( requestPermissions => {
          if ( requestPermissions.display == "denied" ) {
            Toast.show ( {
              text: "Notification can be enabled in your Phone's Settings.",
            } )
            this.disabled = true
          } else { this.checkPendingNotifications ( ) }
        } ).catch ( e => { console.error ( e ) } )
      } else { this.checkPendingNotifications ( ) }
    } ).catch ( e => { console.error ( e ) } )
  }

  private checkPendingNotifications ( ) {
    LocalNotifications.getPending ( ).then ( pending => {
      this.active_notifications = pending.notifications.map ( ( notification: PendingLocalNotificationSchema ) => { return notification.id } )
    } )
  }

  public async TurnOnNotifications ( id: number, body: string, hour: number, minute: number, event: Event ) {
    if ( !( <HTMLInputElement>event.target ).checked ) {
      LocalNotifications.cancel ( { notifications: [
        {
          id: id,
        }
      ] } )
      this.active_notifications = this.active_notifications.filter ( item => item !== id )
    } else {
      try {
        this.active_notifications.push ( id )
        await LocalNotifications.schedule ( {
          notifications: [
            {
              title: "Oremus",
              body: body,
              id: id,
              sound: undefined,
              attachments: undefined,
              actionTypeId: "",
              extra: null,
              schedule: {
                on: {
                  hour: hour,
                  minute: minute
                },
                repeats: true,
                allowWhileIdle: true,
              },
            },
          ],
        } )
      } catch ( e ) {
        console.error ( e )
      }
    }
  }
}
