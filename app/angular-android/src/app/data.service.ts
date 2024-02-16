import { HttpClient, HttpParams } from "@angular/common/http"
import { Injectable } from "@angular/core"
import { CapacitorSQLite, JsonSQLite } from "@capacitor-community/sqlite"
import { BehaviorSubject } from "rxjs"
import { Preferences } from '@capacitor/preferences'

const DB_SETUP_KEY = "OrdoCacheSetup"
const DB_NAME_KEY = '1962LiturgicalOrdo';

const DB_TABLE_ORDO = "1962-Ordo"
const DB_TABLE_LOCALE = "1962-Locale"
const DB_TABLE_PRAYERS = "1962-Prayers"

@Injectable ( {
  providedIn: "root"
} )
export class DataService {
  dbReady: BehaviorSubject<boolean> = new BehaviorSubject ( false )  
  error: boolean = false
  loading: boolean = false
  ordo: any [ ] = [ ]
  locale: any = { }
  prayers: any [ ] = [ ]

  private VERSION: string = "1.3"

  constructor (
    private http: HttpClient
  ) { }

  async init ( ): Promise<void> {
    try {
      const sqlite = CapacitorSQLite as any
      await sqlite.requestPermissions ( )
      this.setupDatabase ( )
    } catch ( e ) {
      console.error ( e )
      console.error ( "Could Not Connect To Cache DB" )
    }
  }
  
  private async setupDatabase ( ) {
    const dbSetupDone = await Preferences.get ( { key: DB_SETUP_KEY } )

    if ( !dbSetupDone.value ) {
      // ! DB Not Setup
      CapacitorSQLite.Database
      // CapacitorSQLite.exportToJson ( )
      // ! Make API Requests (No DB Found)
      console.error ( "No Db Found" )
    } else {
      this.dbName = ( await Preferences.get ( { key: DB_NAME_KEY } ) ).value
      await CapacitorSQLite.open ( { database: this.dbName });

      CapacitorSQLite.exportToJson ( { database: DB_TABLE_ORDO, jsonexportmode: "partial", readonly: true } ).then ( ( data ) => {
        console.log ( data )
      } )
      this.dbReady.next ( true )
    }
  }

  private async getOrdo ( year: string ): Promise<void> {
    return new Promise<void> ( ( resolve, reject ) => {
      this.ordo = [ ]

      let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.VERSION}/ordo.php`
      let params = new HttpParams ( ).set ( "year", year )

      let currentYear = ( new Date ( ) ).getFullYear ( )
      for ( let i = currentYear; i <= currentYear + 5; i += 1 ) {
        this.http.get <any> ( url, { params: params } ).subscribe (
          {
            next: ( response: any ) => {
              this.ordo [ response.Year ] = response.Ordo
              if ( i == currentYear + 5 ) {
                CapacitorSQLite.deleteDatabase ( { database: DB_TABLE_ORDO } )
                CapacitorSQLite.importFromJson ( { jsonstring: JSON.stringify ( this.ordo ) } )
              }
              this.loading = false
              resolve ( )
            },
            error: ( ) => {
              this.handleUpdateError.bind ( this )
              reject ( )
            }
          }
        )
      }
    } )
  }

  private async getLocale ( ): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.VERSION}/locale.php`

      this.http.get <any> ( url ).subscribe (
        {
          next: ( response: any ) => {
            this.locale = response
            CapacitorSQLite.deleteDatabase ( { database: DB_TABLE_LOCALE } )
            CapacitorSQLite.importFromJson ( { jsonstring: JSON.stringify ( this.locale ) } )
            this.loading = false
            resolve ( )
          },
          error: ( ) => {
            this.handleUpdateError.bind ( this )
            reject ( )
          }
        }
      )
    } )
  }

  private async getPrayers ( ): Promise<any> {
    return new Promise<void> ( ( resolve, reject ) => {
      this.prayers = [ ]

      let url = `https://www.matthewfrankland.co.uk/ordo-1962/v${this.VERSION}/prayers.php`

      this.http.get <any> ( url ).subscribe (
        {
          next: ( response: any ) => {
            CapacitorSQLite.deleteDatabase ( { database: DB_TABLE_LOCALE } )
            CapacitorSQLite.importFromJson ( { jsonstring: JSON.stringify ( this.locale ) } )
            this.prayers = response
            this.loading = false
            resolve ( )
          },
          error: ( ) => {
            this.handleUpdateError.bind ( this )
            reject ( )
          }
        }
      )
    } )
  }

  private updateCache ( json: string ) {
    CapacitorSQLite.deleteDatabase ( )
    CapacitorSQLite.importFromJson ( { jsonstring: json } )

  }

  private handleUpdateError ( error: any ) {
    this.error = true
    this.loading = false
    console.error ( error )
  }

}