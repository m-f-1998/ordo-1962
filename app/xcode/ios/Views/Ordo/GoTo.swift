//
//  GoTo.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/07/2023.
//

import SwiftUI

struct GoTo: View {
    var date_range: ClosedRange <Date> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date ( from: CurrentYear ( ) + "/01/01" )!...formatter.date ( from: String ( Int ( CurrentYear ( ) )! + 10 ) + "/12/31" )!
    }
    var data: OrdoMonth
    var proxy: ScrollViewProxy
    
    @Binding var view_open: Bool
    @Binding var year: String
    @Binding var date: Date

    var body: some View {
        NavigationStack {
            VStack {
                DatePicker ( "Select Date", selection: $date, in: date_range, displayedComponents: [ .date ] )
                    .datePickerStyle ( .graphical )
                    .frame ( width: 320 )
                HStack {
                    Button ( action: {
                        let components = Calendar.current.dateComponents ( [ .day, .month, .year ], from: self.date )
                        self.year = String ( components.year! )
                        self.GoToDate ( month: Calendar.current.monthSymbols [ components.month! - 1 ], day: components.day! )
                    }, label: {
                        Text ( "Select Date" ).bold ( )
                    } )
                    Divider ( ).frame ( height: 30 )
                    Button ( action: {
                        self.year = CurrentYear ( )
                        self.GoToDate ( month: CurrentMonth ( ), day: CurrentDay ( ) )
                    }, label: {
                        Text ( "Go To Today" ).bold ( )
                    } )
                }
            }
            .navigationTitle ( "Go To..." )
        }
    }

    func GoToDate ( month: String, day: Int ) {
        let id = self.data [ month ]! [ day - 1 ].id

        DispatchQueue.global ( qos: .background ).asyncAfter ( deadline: .now ( ) + 0.1 ) {
            self.proxy.scrollTo ( id, anchor: .top )
        }
        
        if self.view_open {
            self.view_open = false
        }
    }
}
