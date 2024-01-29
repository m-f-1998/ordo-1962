//
//  Propers.ts
//  ordo-62
//
//  Created by Matthew Frankland on 29/01/2024.
//

class PropersData {
  private title?: string
  public english: string
  public latin: string
  private prayers: { [ id: string ] : string }

  constructor ( json: string ) {
    let obj = JSON.parse ( json )
    this.english = obj.english
    this.latin = obj.latin
    this.prayers = { "English": obj.english, "Latin": obj.latin }
    if ( obj.title ) {
      this.title = obj.title
    }
  }

  public GetTitle ( ): string | undefined {
    return this.title
  }

  public GetPrayer ( lang: string ): string {
    if ( lang in this.prayers ) {
      return this.prayers [ lang ]
    }
    return ""
  }

}