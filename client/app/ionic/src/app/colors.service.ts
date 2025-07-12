import { Injectable } from "@angular/core"

@Injectable ( {
  providedIn: "root",
} )
export class ColorsService {

  public constructor ( ) { }

  public getBackgroundColor ( id: string ) {
    switch ( id.split ( "," ) [ 0 ] ) {
      case "y":
        return "gold"
      case "b":
        return "black"
      case "w":
        return "white"
      case "r":
        return "red"
      case "o":
        return "orange"
      case "g":
        return "lime"
      case "v":
        return "violet"
      case "p":
        return "pink"
      default:
        return "white"
    }
  }

  public getForegroundColor ( id: string ) {
    switch ( id.split ( "," ) [ 0 ] ) {
      case "b":
        return "white"
      case "r":
        return "white"
      default:
        return "black"
    }
  }

}