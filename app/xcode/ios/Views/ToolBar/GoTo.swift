//
//  GoTo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/07/2023.
//

import SwiftUI

struct GoTo: View {
    @Binding var showDatePicker: Bool
    @State private var date: Date = .now
    
    private let year: String = UserDefaults.standard.string ( forKey: "year" )!
    var data: OrdoData
    var proxy: ScrollViewProxy
    var dateClosedRange: ClosedRange <Date> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date ( from: self.year + "/01/01" )!...formatter.date ( from: self.year + "/12/31" )!
    }

    var body: some View {
        NavigationStack {
            VStack {
                DatePicker ( "Select Date", selection: $date, in: dateClosedRange, displayedComponents: [ .date ] )
                    .datePickerStyle ( .graphical )
                    .frame ( width: 320 )
                VStack ( spacing: 10 ) {
                    if year == CurrentYear ( ) {
                        Button ( action: {
                            self.showDatePicker = false
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.proxy.scrollTo ( self.data [ CurrentMonth ( ) ]! [ CurrentDay ( ) - 1 ].id, anchor: .top )
                                }
                            }
                        }, label: {
                            Text ( "Go To Today" ).bold ( )
                        } )
                    }
                    Button ( action: {
                        self.showDatePicker = false
                        DispatchQueue.main.async {
                            withAnimation {
                                let calendarDate = Calendar.current.dateComponents ( [ .day, .year, .month ], from: self.date )
                                self.proxy.scrollTo ( self.data [ Calendar.current.monthSymbols [ calendarDate.month! - 1 ] ]! [ calendarDate.day! - 1 ].id, anchor: .top )
                            }
                        }
                    }, label: {
                        Text ( "Select Date" )
                    } )
                        .padding ( )
                        .background ( LinearGradient ( ) )
                        .clipShape ( Rectangle ( ) )
                        .cornerRadius ( 10 )
                        .buttonStyle ( PlainButtonStyle ( ) )
                }
            }
            .navigationTitle ( "Go To..." )
        }
    }
}
