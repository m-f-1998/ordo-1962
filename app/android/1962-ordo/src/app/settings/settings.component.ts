import { Component } from "@angular/core"
import { LocalNotifications } from "@capacitor/local-notifications"
import { DataService } from "../data.service"
import { Toast } from "@capacitor/toast"
import { set } from "date-fns"

@Component({
  templateUrl: "./settings.component.html",
})
export class SettingsComponent {
  public ordo: any = {}

  public loading = true
  public error = false

  AngelusSix = false
  AngelusTwelve = false
  AngelusEighteen = false
  DailyFeast = false

  constructor(
    private apiRequests: DataService
  ) {
    this.apiRequests
      .GetOrdo()
      .then((ordo) => {
        this.ordo = ordo
        this.loading = false
        this.error = false
      })
      .catch((e) => {
        console.error(e)
        this.loading = false
        this.error = true
      })
    LocalNotifications.getPending().then((pending) => {
      console.log ( pending )
      for (const not of pending.notifications) {
        if (not.id == 1) {
          this.AngelusSix = true
        } else if (not.id == 2) {
          this.AngelusTwelve = true
        } else if (not.id == 3) {
          this.AngelusEighteen = true
        } else if ( not.id == 4 ) {
          this.DailyFeast = true
        }
      }
    })
  }

  getFullYear() {
    return new Date().getFullYear()
  }

  async SwitchDailyFeast ( id: number, event: Event ) {
    const checked = (<HTMLInputElement>event.target).checked
    if (!checked) {
      LocalNotifications.cancel({
        notifications: [
          {
            id: id,
          },
        ],
      })
    } else {
      LocalNotifications.checkPermissions().then(async (permissions) => {
        if (String(permissions.display) !== "granted") {
          await LocalNotifications.requestPermissions().then(async (res) => {
            if (res.display == "denied") {
              await Toast.show({
                text: "Notification Permissions are not Allowed on this Device.",
              })
            }
            console.error(res)
            return
          })
        }

        try {
          for ( const celebration of this.ordo [ this.getFullYear ( ) ] [ new Date ( ).getMonth ( ) ] [ new Date ( ).getDate ( ) - 1 ].celebrations ) {
            await LocalNotifications.schedule({
              notifications: [
                {
                  title: "Daily Feast of the Day",
                  body: celebration.title,
                  id: id,
                  sound: undefined,
                  attachments: undefined,
                  actionTypeId: "",
                  extra: null,
                  schedule: {
                    repeats: true,
                    every: "day",
                    allowWhileIdle: true,
                    at: set ( new Date ( ), { hours: 17, minutes: 13, } )
                  },
                },
              ],
            })
          }
        } catch (e) {
          console.error ( e )
        }
      } )
    }
  }

  async TurnOnNotifications(id: number, body: string, hour: number, minute: number, event: Event) {
    const checked = (<HTMLInputElement>event.target).checked
    if (!checked) {
      LocalNotifications.cancel({
        notifications: [
          {
            id: id,
          },
        ],
      })
    } else {
      LocalNotifications.checkPermissions().then(async (permissions) => {
        if (String(permissions.display) !== "granted") {
          await LocalNotifications.requestPermissions().then(async (res) => {
            if (res.display == "denied") {
              await Toast.show({
                text: "Notification Permissions are not Allowed on this Device.",
              })
            }
            console.error(res)
            return
          })
        }

        try {
          await LocalNotifications.schedule({
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
                  repeats: true,
                  every: "day",
                  allowWhileIdle: true,
                  at: set ( new Date ( ), { hours: hour, minutes: minute, } )
                },
              },
            ],
          })
        } catch (e) {
          console.error(e)
        }
      })
    }
  }
}
