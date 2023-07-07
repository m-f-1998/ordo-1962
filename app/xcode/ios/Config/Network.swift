//
//  Network.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 14/06/2023.
//

import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor ( )
    private let worker = DispatchQueue ( label: "NetMonitor" )
    @Published var connected: Bool = true

    init ( ) {
        monitor.pathUpdateHandler = { path in // Monitor the network status and present a banner if not available
            DispatchQueue.main.async {
                self.connected = path.status == .satisfied
            }
        }
        monitor.start ( queue: worker )
    }
}
