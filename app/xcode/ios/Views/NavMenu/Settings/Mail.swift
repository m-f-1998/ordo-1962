//
//  Contact.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI

struct Mail: View {
    @Binding var settings_open: Bool

    var body: some View {
        Section ( "Contact Us" ) {
            Button {
                self.settings_open = false
                self.mail ( )
            } label: {
                Text ( "Report an Error or Make a Comment" )
            }
        }
    }
    
    // Send An Email In Default Mail Application
    func mail ( ) {
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
