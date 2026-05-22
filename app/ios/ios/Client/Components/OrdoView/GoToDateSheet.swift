//
//  GoToDateSheet.swift
//  ordo-1962
//

import SwiftUI

struct GoToDateSheet: View {
    let onSelect: ( Int, Date ) -> Void

    @State private var selectedDate: Date
    @Environment ( \.dismiss ) private var dismiss

    private let minYear = CurrentYear ( )
    private let maxYear = CurrentYear ( ) + 5

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

    var body: some View {
        VStack ( spacing: 0 ) {
            // Minimal header — no title, just dismiss controls
            HStack {
                Button ( "Cancel" ) { dismiss ( ) }
                    .foregroundStyle ( .secondary )
                Spacer ( )
                Button ( "Go" ) {
                    dismiss ( )
                    onSelect ( selectedYear, selectedDate )
                }
                .fontWeight ( .semibold )
                .disabled ( !isInRange )
            }
            .padding ( .horizontal )
            .padding ( .vertical, 10 )

            Divider ( )

            DatePicker (
                "",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle ( .graphical )
            .labelsHidden ( )
            .tint ( .red )
            .padding ( .horizontal )
        }
        .presentationDetents ( [ .medium ] )
        .presentationDragIndicator ( .hidden )
    }
}
