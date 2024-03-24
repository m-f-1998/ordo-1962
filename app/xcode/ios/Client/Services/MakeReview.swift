//
//  MakeReview.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 24/03/2024.
//

import SwiftUI
import StoreKit

struct MakeReview: View {
    @Environment(\.requestReview) var requestReview

    var body: some View {
        Button {
            self.requestReview ( )
        } label: {
            Text ( "Leave a Review" )
        }
    }
}
