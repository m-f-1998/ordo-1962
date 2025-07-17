import { HttpClient, HttpParams } from "@angular/common/http"
import { inject, Injectable } from "@angular/core"
import { addWeeks, format, isBefore, isValid, parse } from "date-fns"
import { compress, decompress } from "compress-json"
import { Preferences } from "@capacitor/preferences"
import { Filesystem, Directory, Encoding } from "@capacitor/filesystem"

@Injectable ( {
  providedIn: "root",
} )
export class DataService {
  private APIVERSION: string = "1.3"

  private readonly http: HttpClient = inject ( HttpClient )

  public async GetOrdo ( ): Promise<any> {
    const currentYear = new Date ( ).getFullYear ( )
    const ordo: any = { }
    for ( let i = currentYear; i <= currentYear + 5; i++ ) {
      try {
        const contents = await Filesystem.readFile ( {
          path: `ordo-${i}.json`,
          directory: Directory.Data,
        } )
        const value = JSON.parse ( contents.data as string )
        if ( !this.checkExpired ( value ) && !( new Date ( ).getMonth ( ) === 1 && new Date ( ).getDate ( ) === 1 ) ) {
          ordo [ String ( i ) ] = value.Ordo
        } else {
          throw new Error ( `Ordo for year ${i} is expired or not available` )
        }
      } catch {
        const response = await this.httpRequest ( `ordo/${String ( i )}` )
        ordo [ response.Year ] = response.Ordo
        await Filesystem.writeFile ( {
          path: `ordo-${response.Year}.json`,
          data: JSON.stringify ( response ),
          directory: Directory.Data,
          encoding: Encoding.UTF8,
        } )
        console.log ( `Saved ordo for year ${response.Year} to filesystem` )
      }
      if ( i == currentYear + 5 ) return ordo
    }
  }

  public async GetLocale ( ): Promise<any> {
    const value = await Preferences.get ( {
      key: "locale"
    } )
    if (
      !this.checkExpired ( value.value )
      && !( new Date ( ).getMonth ( ) === 1 && new Date ( ).getDate ( ) === 1 )
    ) {
      console.log ( "Using cached locale data" )
      return decompress ( JSON.parse ( ( value.value as string ) ) )
    }
    console.log ( "Fetching new locale data" )
    const response = await this.httpRequest ( "locale" )
    await Preferences.set ( {
      key: "locale",
      value: JSON.stringify ( compress ( response ) )
    } )
    return response
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
        this.httpRequest ( "prayers" ).then ( response => {
          Preferences.set ( {
            key: "prayers",
            value: JSON.stringify ( compress ( response ) )
          } )
          resolve ( response )
        } ).catch ( e => reject ( e ) )
      } )
    } )
  }

  public async GetVotives ( ): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      Preferences.get ( {
        key: "votives"
      } ).then ( value => {
        if (
          !this.checkExpired ( value.value )
          && !( new Date ( ).getMonth ( ) === 1 && new Date ( ).getDate ( ) === 1 )
        ) {
          resolve ( decompress ( JSON.parse ( ( value.value as string ) ) ) )
          return
        }
        this.httpRequest ( "votives" ).then ( response => {
          Preferences.set ( {
            key: "votives",
            value: JSON.stringify ( compress ( response ) )
          } )
          resolve ( response )
        } ).catch ( e => reject ( e ) )
      } )
    } )
  }

  private httpRequest ( page: string, params: HttpParams = new HttpParams ( ) ) {
    return new Promise<any> ( ( resolve, reject ) => {
      this.http.get<any> ( this.getURL ( page ), { params } ).subscribe ( {
        next: response => {
          if ( Array.isArray ( response ) ) {
            resolve ( {
              data: response,
              date: format ( addWeeks ( new Date ( ), 2 ), "dd MMM yyyy" )
            } )
          } else {
            response.date = format ( addWeeks ( new Date ( ), 2 ), "dd MMM yyyy" )
          }
          resolve ( response )
        },
        error: e => reject ( e )
      } )
    } )
  }

  private checkExpired ( data: string | null ) {
    let cache: any = null
    if ( data ) {
      try {
        cache = decompress ( JSON.parse ( data ) )
      } catch {
        try {
          cache = JSON.parse ( data )
        } catch {
          cache = data
        }
      }
    }
    if ( cache?.date ) {
      const date = parse ( cache.date, "dd MMM yyyy", new Date ( ) )
      return !isValid ( date ) || isBefore ( date, new Date ( ) )
    }
    return true
  }

  private getURL ( path: string ): string {
    return `https://ordo.matthewfrankland.co.uk/api/v${this.APIVERSION}/${path}`
  }
}
