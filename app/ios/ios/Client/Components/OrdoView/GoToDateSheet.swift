//
//  GoToDateSheet.swift
//  ordo-1962
//

import SwiftUI

struct GoToDateSheet: View {
    let onSelect: ( Int, Date ) -> Void

    @State private var selectedDate: Date
    @Environment( \.dismiss ) private var dismiss

    private let minYear = 2023
    private let maxYear = 2123

    init ( initialDate: Date, onSelect: @escaping ( Int, Date ) -> Void ) {
        self.onSelect = onSelect
        _selectedDate = State ( initialValue: initialDate )
    }

    private var selectedYear: Int {
        Calendar.current.component ( .year, from: selectedDate )
    }

    private var isInRange: Bool {
        selectedYear >= minYear && selectedYear <= maxYear
    }

    private var minDate: Date {
        Calendar.current.date ( from: DateComponents ( year: minYear, month: 1, day: 1 ) ) ?? .now
    }

    private var maxDate: Date {
        Calendar.current.date ( from: DateComponents ( year: maxYear, month: 12, day: 31 ) ) ?? .now
    }

    var body: some View {
        VStack ( spacing: 0 ) {
            HStack {
                Button ( "Cancel" ) { dismiss ( ) }
                    .foregroundStyle ( .secondary )
                Spacer ( )
                Text ( "Go To Date" )
                    .fontWeight ( .semibold )
                Spacer ( )
                Button ( "Select" ) {
                    let cal = Calendar.current
                    let year = cal.component ( .year, from: selectedDate )
                    dismiss ( )
                    onSelect ( year, selectedDate )
                }
                .bold ( )
                .foregroundStyle ( .red )
            }
            .padding ( .horizontal )
            .padding ( .vertical, 10 )

            Divider ( )

            DatePicker (
                "",
                selection: $selectedDate,
                in: minDate...maxDate,
                displayedComponents: .date
            )
            .datePickerStyle ( .graphical )
            .labelsHidden ( )
            .tint ( .red )
            .padding ( .horizontal )
        }
        .presentationDetents ( [ .medium ] )
        .presentationDragIndicator ( .hidden )
        .interactiveDismissDisabled ( )
    }
}
