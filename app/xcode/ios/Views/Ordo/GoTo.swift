//
//  GoTo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/07/2023.
//

import SwiftUI

struct GoTo: View {
    private let year: String = UserDefaults.standard.string ( forKey: "year" )!
    var date_range: ClosedRange <Date> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date ( from: self.year + "/01/01" )!...formatter.date ( from: self.year + "/12/31" )!
    }
    var data: OrdoData
    var proxy: ScrollViewProxy
    
    @State private var date: Date = .now
    @Binding var view_open: Bool

    var body: some View {
        NavigationStack {
            VStack {
                DatePicker ( "Select Date", selection: $date, in: date_range, displayedComponents: [ .date ] )
                    .datePickerStyle ( .graphical )
                    .frame ( width: 320 )
                VStack ( spacing: 20 ) {
                    Button ( action: {
                        self.GoToDate ( date: self.date )
                    }, label: {
                        Text ( "Select Date" ).bold ( )
                    } )
                        .padding ( )
                        .background ( LinearGradient ( ) )
                        .clipShape ( Rectangle ( ) )
                        .cornerRadius ( 10 )
                    if year == CurrentYear ( ) {
                        Button ( action: {
                            self.GoToDate ( date: .now )
                        }, label: {
                            Text ( "Go To Today" ).bold ( )
                        } )
                    }
                }
            }
            .navigationTitle ( "Go To..." )
        }
    }

    func GoToDate ( date: Date ) {
        if self.data != DUMMY_ORDO {
            if self.view_open {
                self.view_open = false
            }
            let components = Calendar.current.dateComponents ( [ .day, .month ], from: date ),
                id = self.data [ Calendar.current.monthSymbols [ components.month! - 1 ] ]! [ components.day! - 1 ].id

            DispatchQueue.main.async {
                self.proxy.scrollTo ( id, anchor: .top )
            }
        }
    }
}
