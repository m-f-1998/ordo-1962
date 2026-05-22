//
//  GoToDateSheet.swift
//  ordo-1962
//

import SwiftUI

struct GoToDateSheet: View {
    let year: Int
    let onSelect: ( Date ) -> Void

    @State private var selectedDate: Date = .now
    @Environment ( \.dismiss ) private var dismiss

    private var minDate: Date {
        Calendar.current.date ( from: DateComponents ( year: year, month: 1, day: 1 ) ) ?? .now
    }
    private var maxDate: Date {
        Calendar.current.date ( from: DateComponents ( year: year, month: 12, day: 31 ) ) ?? .now
    }

    var body: some View {
        NavigationStack {
            VStack ( spacing: 24 ) {
                DatePicker (
                    "Select a date",
                    selection: $selectedDate,
                    in: minDate...maxDate,
                    displayedComponents: .date
                )
                .datePickerStyle ( .graphical )
                .padding ( .horizontal )

                Button {
                    onSelect ( selectedDate )
                } label: {
                    Text ( "Go To Date" )
                        .font ( .system ( size: 16, weight: .semibold ) )
                        .frame ( maxWidth: .infinity )
                        .padding ( .vertical, 14 )
                        .background ( .tint )
                        .foregroundStyle ( .white )
                        .clipShape ( RoundedRectangle ( cornerRadius: 14 ) )
                }
                .padding ( .horizontal )

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
            // Clamp today into the displayed year's bounds
            let cal = Calendar.current
            let todayYear = cal.component ( .year, from: .now )
            if todayYear == year {
                selectedDate = .now
            } else {
                selectedDate = minDate
            }
        }
    }
}
