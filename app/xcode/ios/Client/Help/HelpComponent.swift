//
//  DisplayInfo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 29/12/2023.
//


import SwiftUI

struct HelpComponent: View {
    var body: some View {
        NavigationStack {
            List {
                Section ( header: Text ( "Notes on the Calendar" ) ) {
                    ForEach ( calendar_info.sorted ( by: > ), id: \.key ) { key, value in
                        NavigationLink ( destination:
                            DisplayText ( text: value ).navigationTitle ( key )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section ( header: Text ( "Votive Masses of Particular Piety" ) ) {
                    ForEach ( votive_piety.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_piety [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section ( header: Text ( "The Missale Romanum's Recommended Votive Mass per Day" ), footer: Text ( "Monday ") ) {
                    ForEach ( votive_monday.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                                            DisplayPropers ( celebrations: [ votive_monday [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section ( footer: Text ( "Tuesday" ) ) {
                    ForEach ( votive_tuesday.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_tuesday [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section ( footer: Text ( "Wednesday" ) ) {
                    ForEach ( votive_wednesday.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_wednesday [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section ( footer: Text ( "Thursday" ) ) {
                    ForEach ( votive_thursday.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_thursday [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section ( footer: Text ( "Friday" ) ) {
                    ForEach ( votive_friday.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_friday [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section {
                    ForEach ( votive_our_lady.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_our_lady [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
                Section ( header: Text ( "Other Votive Masses (Not Exhaustive)" ) ) {
                    ForEach ( votive_propers.keys, id: \.self ) { key in
                        NavigationLink ( destination:
                            DisplayPropers ( celebrations: [ votive_propers [ key ]! ] )
                        ) {
                            Text ( key )
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode ( .inline )
        }
    }
}

