//
//  DisplayInfo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 29/12/2023.
//


import SwiftUI

struct InfoView: View {
    @EnvironmentObject var activeData: ActiveData
    
    var body: some View {
        NavigationStack {
            List {
                Section ( header: Text ( "User Information" ) ) {
                    ForEach ( calendar_details.sorted ( by: < ), id: \.key ) { key, value in
                        NavigationLink {
                            DisplayText ( text: value ).navigationTitle ( key )
                        } label: {
                            Text ( key )
                        }
                    }
                }
                Section ( "Additional Mass Propers" ) {
                    NavigationLink {
                        AdditionalMassPropers ( )
                    } label: {
                        Text ( "Votive Masses" )
                    }
                }
                Section ( header: Text ( "Local Feast Days" ), footer: Text ( "Additional Country/Diocesean Feasts Can Be Added Upon Request." ) ) {
                    NavigationLink {
                        List {
                            ForEach ( self.activeData.locale!.certain_locations, id: \.self ) { locale in
                                LocalFeast ( data: locale )
                            }
                        }
                    } label: {
                        Text ( "In Certain Locations" )
                    }
                    ForEach ( Array ( self.activeData.GetCountries ( ) ), id: \.self ) { country in
                        CountryFeastDates ( country: country )
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode ( .inline )
    }
}
