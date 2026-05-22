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

            let cal = Calendar.current
            let oldDay   = cal.component ( .day,   from: oldDate )
            let oldMonth = cal.component ( .month, from: oldDate )
            let newDay   = cal.component ( .day,   from: newDate )
            let newMonth = cal.component ( .month, from: newDate )
            let newYear  = cal.component ( .year,  from: newDate )

            // Ignore year-wheel scrolling (only year changed, day+month stayed the same)
            guard newDay != oldDay || newMonth != oldMonth else { return }

            guard newYear >= minYear && newYear <= maxYear else {
                isReverting = true
                selectedDate = oldDate
                return
            }

            dismiss ( )
            onSelect ( newYear, newDate )
        }
    }
}
