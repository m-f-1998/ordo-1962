import { ChangeDetectionStrategy, Component } from "@angular/core"
import { LocalNotifications, PendingLocalNotificationSchema } from "@capacitor/local-notifications"
import { Toast } from "@capacitor/toast"
import { IonButton, IonCard, IonContent, IonFooter, IonItem, IonList, IonTitle, IonToggle } from "@ionic/angular/standalone"
import { HeaderComponent } from "../header/header.component"

@Component ( {
  selector: "app-ordo-settings",
  imports: [
    IonButton,
    IonCard,
    IonFooter,
    IonToggle,
    IonItem,
    IonList,
    IonTitle,
    IonContent,
    HeaderComponent
  ],
  templateUrl: "./settings.component.html",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class SettingsComponent {
  public disabled = false
  public activeNotifications: number [ ] = [ ]

  public constructor ( ) {
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

  public async TurnOnNotifications ( id: number, body: string, hour: number, minute: number, event: Event ) {
    if ( !( <HTMLInputElement>event.target ).checked ) {
      LocalNotifications.cancel ( { notifications: [
        {
          id: id,
        }
      ] } )
      this.activeNotifications = this.activeNotifications.filter ( item => item !== id )
    } else {
      try {
        this.activeNotifications.push ( id )
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

  private checkPendingNotifications ( ) {
    LocalNotifications.getPending ( ).then ( pending => {
      this.activeNotifications = pending.notifications.map ( ( notification: PendingLocalNotificationSchema ) => { return notification.id } )
    } )
  }
}
