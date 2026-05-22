//
//  GoToDateSheet.swift
//  ordo-1962
//

import SwiftUI

struct GoToDateSheet: View {
    /// Called with the chosen year and date when the user confirms.
    let onSelect: ( Int, Date ) -> Void

    @State private var selectedYear: Int = CurrentYear ( )
    @State private var selectedDate: Date = .now
    @Environment ( \.dismiss ) private var dismiss

    private let years: [ Int ] = Array ( CurrentYear ( )...CurrentYear ( ) + 5 )

    private var minDate: Date {
        Calendar.current.date ( from: DateComponents ( year: selectedYear, month: 1, day: 1 ) ) ?? .now
    }
    private var maxDate: Date {
        Calendar.current.date ( from: DateComponents ( year: selectedYear, month: 12, day: 31 ) ) ?? .now
    }

    var body: some View {
        NavigationStack {
            VStack ( spacing: 0 ) {
                Picker ( "Year", selection: $selectedYear ) {
                    ForEach ( years, id: \.self ) { year in
                        Text ( String ( year ) ).tag ( year )
                    }
                }
                .pickerStyle ( .segmented )
                .padding ( [ .horizontal, .top ] )

                DatePicker (
                    "Select a date",
                    selection: $selectedDate,
                    in: minDate...maxDate,
                    displayedComponents: .date
                )
                .datePickerStyle ( .graphical )
                .padding ( .horizontal )
                .onChange ( of: selectedYear ) { _, _ in
                    if selectedDate < minDate { selectedDate = minDate }
                    if selectedDate > maxDate { selectedDate = maxDate }
                }

                Button {
                    onSelect ( selectedYear, selectedDate )
                } label: {
                    Text ( "Go To Date" )
                        .font ( .system ( size: 16, weight: .semibold ) )
                        .frame ( maxWidth: .infinity )
                        .padding ( .vertical, 14 )
                        .background ( .tint )
                        .foregroundStyle ( .white )
                        .clipShape ( RoundedRectangle ( cornerRadius: 14 ) )
                }
                .padding ( [ .horizontal, .bottom ] )

                Spacer ( )
            }
            .padding ( .top, 8 )
            .navigationTitle ( "Go To Date" )
            .navigationBarTitleDisplayMode ( .inline )
            .toolbar {
                ToolbarItem ( placement: .cancellationAction ) {
                    Button ( "Cancel" ) { dismiss ( ) }
                }
            }
        }
        .presentationDetents ( [ .medium ] )
        .presentationDragIndicator ( .visible )
        .onAppear {
            selectedYear = CurrentYear ( )
            selectedDate = .now
        }
    }
}
