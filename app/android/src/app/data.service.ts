import { HttpClient, HttpParams } from "@angular/common/http"
import { Injectable } from "@angular/core"
import { addWeeks, format, isBefore, isValid, parse } from "date-fns"
import { compress, decompress } from 'compress-json'
import { Preferences } from '@capacitor/preferences';

@Injectable({
  providedIn: "platform",
})
export class DataService {
  private API_VERSION: string = "1.3"

  constructor (
    private http: HttpClient
  ) { }

  public async GetOrdo(): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      const currentYear = new Date ( ).getFullYear ( )
      const ordo: any = { }
      for (let i = currentYear; i <= currentYear + 5; i++) {
        Preferences.get ( {
          key: "ordo-" + String ( i )
        } ).then ( value => {
          let expired = false
          const cacheData = value.value ? decompress ( JSON.parse ( value.value ) ) : null
          if ( cacheData && "date" in cacheData ) {
            const date = parse ( cacheData.date, "dd MMM yyyy", new Date ( ) )
            if ( !isValid ( date ) || isBefore ( date, new Date ( ) ) ) {
              expired = true
            }
          }
          if (
            cacheData
            && !( new Date().getMonth() === 1 && new Date().getDate() === 1 )
            && !expired
          ) {
            ordo [ i ] = cacheData
            if ( i == currentYear + 5 ) {
              resolve ( ordo )
            }
          } else {
            const params = new HttpParams ( ).set ( "year", String ( i ) )
            this.http.get<any> ( this.getURL ( "ordo.php" ), { params } ).subscribe ( {
              next: ( response: any ) => {
                ordo [ response.Year ] = response.Ordo
                ordo [ "date" ] = format ( addWeeks ( new Date ( ), 2 ), "dd MMM yyyy" )
                Preferences.set ( {
                  key: "ordo-" + response.Year,
                  value: JSON.stringify ( compress ( ordo [ response.Year ] ) )
                } )
              },
              complete: ( ) => {
                if ( i == currentYear + 5 ) {
                  resolve ( ordo )
                }
              },
              error: ( e ) => reject ( e ),
            } )
          }
        } ).catch ( e => reject ( e ) )
      }
    })
  }

  public async GetLocale(): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      Preferences.get ( {
        key: "locale"
      } ).then ( value => {
        let expired = false
        const cacheData = value.value ? decompress ( JSON.parse ( value.value ) ) : null
        if ( cacheData && "date" in cacheData ) {
          const date = parse ( cacheData.date, "dd MMM yyyy", new Date ( ) )
          if ( !isValid ( date ) || isBefore ( date, new Date ( ) ) ) {
            expired = true
          }
        }
        if (
          cacheData
          && !( new Date().getMonth() === 1 && new Date().getDate() === 1 )
          && !expired
        ) {
          resolve ( cacheData )
        } else {
          this.http.get<any> ( this.getURL ( "locale.php" ) ).subscribe ( {
            next: async ( response: any ) => {
              const locale = response
              locale [ "date" ] = format ( addWeeks ( new Date ( ), 2 ), "dd MMM yyyy" )
              Preferences.set ( {
                key: "locale",
                value: JSON.stringify ( compress ( locale ) )
              } )
              resolve ( response )
            },
            error: ( e ) => reject ( e ),
          })
        }
      } )
    })
  }

  public async GetPrayers(): Promise<any> {
    return new Promise<void>((resolve, reject) => {
      Preferences.get ( {
        key: "prayers"
      } ).then ( value => {
        let expired = false
        const cacheData = value.value ? decompress ( JSON.parse ( value.value ) ) : null
        if ( cacheData && "date" in cacheData ) {
          const date = parse ( cacheData.date, "dd MMM yyyy", new Date ( ) )
          if ( !isValid ( date ) || isBefore ( date, new Date ( ) ) ) {
            expired = true
          }
        }
        if (
          cacheData
          && !( new Date().getMonth() === 1 && new Date().getDate() === 1 )
          && !expired
        ) {
          resolve ( cacheData )
        } else {
          this.http.get<any> ( this.getURL ( "prayers.php" ) ).subscribe ( {
            next: async (response: any) => {
              const prayers = response
              prayers [ "date" ] = format ( addWeeks ( new Date ( ), 2 ), "dd MMM yyyy" )
              Preferences.set ( {
                key: "prayers",
                value: JSON.stringify ( compress ( prayers ) )
              } )
              resolve ( response )
            },
            error: ( e ) => reject ( e ),
          } )
        }
      } )
    })
  }

  private getURL(file: string): string {
    return `https://www.matthewfrankland.co.uk/ordo-1962/v${this.API_VERSION}/${file}`
  }
}
