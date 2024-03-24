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

  public async GetOrdo ( ): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      const currentYear = new Date ( ).getFullYear ( )
      const ordo: any = { }
      for ( let i = currentYear; i <= currentYear + 5; i++ ) {
        Preferences.get ( {
          key: `ordo-${String ( i )}`
        } ).then ( async value => {
          try {
            if (
              !this.checkExpired ( value.value )
              && !( new Date ( ).getMonth ( ) === 1 && new Date ( ).getDate ( ) === 1 )
            ) {
              ordo [ String ( i ) ] = decompress ( JSON.parse ( ( value.value as string ) ) ).Ordo
            } else {
              const response = await this.httpRequest ( "ordo.php", new HttpParams ( ).set ( "year", String ( i ) ) )
              ordo [ response.Year ] = response.Ordo
              Preferences.set ( {
                key: `ordo-${response.Year}`,
                value: JSON.stringify ( compress ( response ) )
              } )
            }
            if ( i == currentYear + 5 ) resolve ( ordo )
          } catch ( e ) {
            reject ( e )
          }
        } ).catch ( e => reject ( e ) )
      }
    })
  }

  public async GetLocale ( ): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      Preferences.get ( {
        key: "locale"
      } ).then ( value => {
        if (
          !this.checkExpired ( value.value )
          && !( new Date ( ).getMonth ( ) === 1 && new Date ( ).getDate ( ) === 1 )
        ) {
          resolve ( decompress ( JSON.parse ( ( value.value as string ) ) ) )
          return
        }
        this.httpRequest ( "locale.php" ).then ( response => {
          Preferences.set ( {
            key: "locale",
            value: JSON.stringify ( compress ( response ) )
          } )
          resolve ( response )
        } ).catch ( e => reject ( e ) )
      } )
    })
  }

  public async GetPrayers ( ): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      Preferences.get ( {
        key: "prayers"
      } ).then ( value => {
        if (
          !this.checkExpired ( value.value )
          && !( new Date ( ).getMonth ( ) === 1 && new Date ( ).getDate ( ) === 1 )
        ) {
          resolve ( decompress ( JSON.parse ( ( value.value as string ) ) ) )
          return
        }
        this.httpRequest ( "prayers.php" ).then ( response => {
          Preferences.set ( {
            key: "prayers",
            value: JSON.stringify ( compress ( response ) )
          } )
          resolve ( response )
        } ).catch ( e => reject ( e ) )
      } )
    })
  }

  private httpRequest ( page: string, params: HttpParams = new HttpParams ( ) ) {
    return new Promise<any> ( ( resolve, reject ) => {
      this.http.get<any> ( this.getURL ( page ), { params } ).subscribe ( {
        next: async ( response ) => {
          response.date = format ( addWeeks ( new Date ( ), 2 ), "dd MMM yyyy" )
          resolve ( response )
        },
        error: ( e ) => reject ( e )
      } )
    } )
  }

  private checkExpired ( data: string | null ) {
    const cache = data ? decompress ( JSON.parse ( data ) ) : null
    if ( cache && "date" in cache ) {
      const date = parse ( cache.date, "dd MMM yyyy", new Date ( ) )
      return !isValid ( date ) || isBefore ( date, new Date ( ) )
    }
    return true
  }

  private getURL ( file: string ): string {
    return `https://www.matthewfrankland.co.uk/ordo-1962/v${this.API_VERSION}/${file}`
  }
}
