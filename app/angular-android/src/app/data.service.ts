import { HttpClient, HttpParams } from "@angular/common/http"
import { Injectable } from "@angular/core"
import { Filesystem, Directory, Encoding } from "@capacitor/filesystem"
import moment from "moment"

@Injectable ( {
  providedIn: "root"
} )
export class DataService {
  private API_VERSION: string = "1.3"

  constructor (
    private http: HttpClient
  ) { }

  async GetOrdo ( ): Promise<any> {
    return new Promise<void> ( async ( resolve, reject ) => {
      this.readFile ( "ordo.json" ).then ( json => {
        resolve ( json )
      } ).catch ( e => {
        console.error ( e )

        const ordo: any = { }
        const currentYear = ( new Date ( ) ).getFullYear ( )
        for ( let i = currentYear; i <= currentYear + 5; i++ ) {
          const params = new HttpParams ( ).set ( "year", String ( i ) )
          this.http.get <any> ( this.getURL ( "ordo.php" ), { params } ).subscribe (
            {
              next: ( response: any ) => {
                ordo [ response.Year ] = response.Ordo
              },
              complete: async ( ) => {
                if ( i == currentYear + 5 ) {
                  await this.deleteFile ( "ordo.json", reject )
                  await this.writeFile ( "ordo.json", ordo, reject )
                  resolve ( ordo )
                }
              },
              error: ( e ) => reject ( e )
            }
          )
        }
      } )
    } )
  }

  async GetLocale ( ): Promise<any> {
    return new Promise<void> ( async ( resolve, reject ) => {
      this.readFile ( "locale.json" ).then ( json => {
        resolve ( json )
      } ).catch ( e => {
        console.log ( e )
        this.http.get <any> ( this.getURL ( "locale.php" ) ).subscribe (
          {
            next: async ( response: any ) => {
              await this.deleteFile ( "locale.json", reject )
              await this.writeFile ( "locale.json", response, reject )
              resolve ( response )
            },
            error: ( e ) => reject ( e )
          }
        )
      } )
    } )
  }

  async GetPrayers ( ): Promise<any> {
    console.log ( "Promise")
    return new Promise<void> ( async ( resolve, reject ) => {
      console.log ( "Read" )
      this.readFile ( "prayers.json" ).then ( json => {
        console.log ( "Try File")
        resolve ( json )
      } ).catch ( e => {
        console.log ( "HTTP Request" )
        console.log ( e )
        this.http.get <any> ( this.getURL ( "prayers.php" ) ).subscribe (
          {
            next: async ( response: any ) => {
              console.log ( "1" )
              await this.deleteFile ( "prayers.json", reject )
              console.log ( "1" )
              await this.writeFile ( "prayers.json", response, reject )
              console.log ( "1" )
              resolve ( response )
            },
            error: ( e ) => reject ( e )
          }
        )
      } )
    } )
  }

  private async readFile ( file: string ): Promise<any> {
    return new Promise<any> ( ( resolve, reject ) => {
      Filesystem.readFile ( {
        path: file,
        directory: Directory.Documents,
        encoding: Encoding.UTF8
      } ).then ( ( res: any ) => {
        try {
          const json = JSON.parse ( res.data.toString ( ) )
          if ( !("date" in json) || !moment ( json.date ).isValid ( ) || moment ( json.date ).isBefore ( ) ) {
            reject ( "Date Invalid in Cache. Refreshing..." )
          }
          resolve ( json )
        } catch ( e ) {
          reject ( )
        }
      } ).catch ( e => {
        reject ( e )
      } )
    } )
  }

  private async deleteFile ( file: string, reject: (reason?: any) => void ) {
    try {
      await Filesystem.deleteFile ( {
        path: file,
        directory: Directory.Documents
      } )
    } catch ( e ) {
      reject ( e )
    }
  }

  private async writeFile ( file: string, data: any, reject: (reason?: any) => void ) {
    try {
      const json = data
      json.date = moment ( ).add ( 2, "weeks" ).format ( )
      await Filesystem.writeFile ( {
        path: file,
        directory: Directory.Documents,
        data: JSON.stringify ( json ),
        encoding: Encoding.UTF8
      } )
    } catch ( e ) {
      reject ( e )
    }
  }

  private getURL ( file: string ): string {
    return `https://www.matthewfrankland.co.uk/ordo-1962/v${this.API_VERSION}/${file}`
  }

}