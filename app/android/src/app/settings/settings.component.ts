import { Component } from "@angular/core"
import { LocalNotifications, PendingLocalNotificationSchema } from "@capacitor/local-notifications"
import { Toast } from "@capacitor/toast"

@Component({
  templateUrl: "./settings.component.html",
})
export class SettingsComponent {
  public ordo: any = { }
  public active_notifications: number [ ] = [ ]
  public loading = false
  public error = false

  constructor ( ) {
    LocalNotifications.getPending ( ).then ( pending => {
      this.active_notifications = pending.notifications.map ( ( notification: PendingLocalNotificationSchema ) => { return notification.id } )
    } )
  }

  async TurnOnNotifications ( id: number, body: string, hour: number, minute: number, event: Event ) {
    if ( !( <HTMLInputElement>event.target ).checked ) {
      LocalNotifications.cancel ( { notifications: [
        {
          id: id,
        }
      ] } )
    } else {
      LocalNotifications.checkPermissions ( ).then ( async permissions => {
        if ( permissions.display !== "granted" ) {
          await LocalNotifications.requestPermissions ( ).then ( async res => {
            if ( res.display == "denied" ) {
              await Toast.show ( {
                text: "Notification Permissions are not Allowed on this Device.",
              } )
              this.active_notifications = this.active_notifications.filter ( item => item !== id )
              return
            }
          })
        }
        this.active_notifications.push ( id )
        try {
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
      } )
    }
  }
}
