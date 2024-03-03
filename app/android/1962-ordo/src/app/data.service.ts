import { HttpClient, HttpParams } from "@angular/common/http"
import { Injectable } from "@angular/core"
import { Filesystem, Directory, Encoding } from "@capacitor/filesystem"
import { addWeeks, format, isBefore, isValid, parse } from "date-fns"

@Injectable({
  providedIn: "root",
})
export class DataService {
  private API_VERSION: string = "1.3"

  constructor(private http: HttpClient) {}

  async GetOrdo(): Promise<any> {
    return new Promise<void>((resolve, reject) => {
      this.readFile("ordo.json")
        .then((json) => {
          if (Object.keys(json).length != 7) {
            throw Error("Cache Object Not Full")
          }
          resolve(json)
        })
        .catch(() => {
          const ordo: any = {}
          const currentYear = new Date().getFullYear()
          for (let i = currentYear; i <= currentYear + 5; i++) {
            const params = new HttpParams().set("year", String(i))
            this.http.get<any>(this.getURL("ordo.php"), { params }).subscribe({
              next: (response: any) => {
                ordo[response.Year] = response.Ordo
              },
              complete: async () => {
                if (i == currentYear + 5) {
                  this.deleteFile("ordo.json").then(() => {
                    this.writeFile("ordo.json", ordo, reject).then(() => {
                      resolve(ordo)
                    })
                  })
                }
              },
              error: (e) => reject(e),
            })
          }
        })
    })
  }

  async GetLocale(): Promise<any> {
    return new Promise<void>((resolve, reject) => {
      this.readFile("locale.json")
        .then((json) => resolve(json))
        .catch(() => {
          this.http.get<any>(this.getURL("locale.php")).subscribe({
            next: async (response: any) => {
              this.deleteFile("locale.json").then(() => {
                this.writeFile("locale.json", response, reject).then(() => {
                  resolve(response)
                })
              })
              resolve(response)
            },
            error: (e) => reject(e),
          })
        })
    })
  }

  async GetPrayers(): Promise<any> {
    return new Promise<void>((resolve, reject) => {
      this.readFile("prayers.json")
        .then((json) => resolve(json))
        .catch(() => {
          this.http.get<any>(this.getURL("prayers.php")).subscribe({
            next: async (response: any) => {
              this.deleteFile("prayers.json").then(() => {
                this.writeFile("prayers.json", response, reject).then(() => {
                  resolve(response)
                })
              })
            },
            error: (e) => reject(e),
          })
        })
    })
  }

  private async readFile(file: string): Promise<any> {
    return new Promise<any>((resolve, reject) => {
      if (new Date().getMonth() === 1 && new Date().getDate() === 1) {
        reject("New Year's Day Refetch")
      }
      Filesystem.readFile({
        path: file,
        directory: Directory.Cache,
        encoding: Encoding.UTF8,
      })
        .then((res: any) => {
          try {
            const json = JSON.parse(res.data.toString())
            if ("date" in json) {
              const date = parse(json.date, "dd MMM yyyy", new Date())
              if (!isValid(date) || isBefore(date, new Date())) {
                reject("Date Invalid in Cache. Refreshing...")
              }
            }
            resolve(json)
          } catch (e) {
            reject(e)
          }
        })
        .catch((e) => reject(e))
    })
  }

  private async deleteFile(file: string) {
    try {
      await Filesystem.deleteFile({
        path: file,
        directory: Directory.Cache,
      })
    } catch (e) {
      console.error(e)
    }
  }

  private async writeFile(file: string, data: any, reject: (reason?: any) => void) {
    try {
      const json = data
      json.date = format(addWeeks(new Date(), 2), "dd MMM yyyy")
      await Filesystem.writeFile({
        path: file,
        directory: Directory.Cache,
        data: JSON.stringify(json),
        encoding: Encoding.UTF8,
      })
    } catch (e) {
      reject(e)
    }
  }

  private getURL(file: string): string {
    return `https://www.matthewfrankland.co.uk/ordo-1962/v${this.API_VERSION}/${file}`
  }
}
