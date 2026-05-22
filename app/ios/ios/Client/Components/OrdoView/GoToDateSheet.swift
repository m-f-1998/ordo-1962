//
//  GoToDateSheet.swift
//  ordo-1962
//

import SwiftUI

struct GoToDateSheet: View {
    let onSelect: ( Int, Date ) -> Void

    @State private var selectedDate: Date
    @State private var isReverting = false
    @Environment ( \.dismiss ) private var dismiss

    private let minYear = CurrentYear ( )
    private let maxYear = CurrentYear ( ) + 5

    init ( initialDate: Date, onSelect: @escaping ( Int, Date ) -> Void ) {
        self.onSelect = onSelect
        _selectedDate = State ( initialValue: initialDate )
    }

    var body: some View {
        DatePicker (
            "",
            selection: $selectedDate,
            displayedComponents: .date
        )
        .datePickerStyle ( .graphical )
        .labelsHidden ( )
        .tint ( .red )
        .padding ( )
        .presentationDetents ( [ .medium ] )
        .presentationDragIndicator ( .visible )
        .onChange ( of: selectedDate ) { oldDate, newDate in
            if isReverting {
                isReverting = false
                return
            }
            let year = Calendar.current.component ( .year, from: newDate )
            guard year >= minYear && year <= maxYear else {
                isReverting = true
                selectedDate = oldDate
                return
            }
            dismiss ( )
            onSelect ( year, newDate )
        }
    }
}
