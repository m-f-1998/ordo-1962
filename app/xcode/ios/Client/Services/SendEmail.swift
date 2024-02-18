//
//  Contact.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct SendEmail: View {
    var body: some View {
        Button {
            self.send_email ( )
        } label: {
            Text ( "Report an Error or Make a Comment" )
        }
    }

    private func send_email ( ) {
        let to = "ordo62@matthewfrankland.co.uk", subject = "Customer Feedback - 1962 Liturgical Ordo".addingPercentEncoding ( withAllowedCharacters: .urlQueryAllowed )
        guard let url = URL ( string: "mailto:\(to)?subject=\(subject ?? "")" ) else {
            fatalError ( "URL Invalid" )
        }

        if UIApplication.shared.canOpenURL ( url ) {
            UIApplication.shared.open ( url )  { success in
                if success {
                    print ( "Successfuly Opened Default Mail Application" )
                }
            }
        }
    }
}
