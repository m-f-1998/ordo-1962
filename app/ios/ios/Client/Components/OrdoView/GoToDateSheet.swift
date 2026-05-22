//
//  GoToDateSheet.swift
//  ordo-1962
//

import SwiftUI

struct GoToDateSheet: View {
    let onSelect: ( Int, Date ) -> Void

    @State private var selectedDate: Date = .now
    @Environment ( \.dismiss ) private var dismiss

    private var minDate: Date {
        Calendar.current.date ( from: DateComponents ( year: CurrentYear ( ), month: 1, day: 1 ) ) ?? .now
    }
    private var maxDate: Date {
        Calendar.current.date ( from: DateComponents ( year: CurrentYear ( ) + 5, month: 12, day: 31 ) ) ?? .now
    }

    var body: some View {
        DatePicker (
            "",
            selection: $selectedDate,
            in: minDate...maxDate,
            displayedComponents: .date
        )
        .datePickerStyle ( .graphical )
        .labelsHidden ( )
        .padding ( )
        .presentationDetents ( [ .medium ] )
        .presentationDragIndicator ( .visible )
        .onChange ( of: selectedDate ) { _, date in
            let year = Calendar.current.component ( .year, from: date )
            dismiss ( )
            onSelect ( year, date )
        }
    }
}
