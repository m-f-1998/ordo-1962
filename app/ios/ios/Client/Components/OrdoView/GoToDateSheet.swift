//
//  GoToDateSheet.swift
//  ordo-1962
//

import SwiftUI

struct GoToDateSheet: View {
    let initialDate: Date
    let onSelect: ( Int, Date ) -> Void

    @State private var selectedDate: Date = .now
    @State private var isReverting = false
    @Environment ( \.dismiss ) private var dismiss

    private let minYear = CurrentYear ( )
    private let maxYear = CurrentYear ( ) + 5

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
        .onAppear {
            selectedDate = initialDate
        }
        .onChange ( of: selectedDate ) { oldDate, newDate in
            if isReverting {
                isReverting = false
                return
            }
            let year = Calendar.current.component ( .year, from: newDate )
            guard year >= minYear && year <= maxYear else {
                // Out of range — snap back silently, don't navigate
                isReverting = true
                selectedDate = oldDate
                return
            }
            dismiss ( )
            onSelect ( year, newDate )
        }
    }
}
