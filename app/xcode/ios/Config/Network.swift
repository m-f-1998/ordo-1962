//
//  Network.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 14/06/2023.
//

import Network
import SwiftUI

// Monitor If Network Connected
class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor ( )
    private let worker = DispatchQueue ( label: "NetMonitor" )
    @Published var connected: Bool = true

    init ( ) {
        self.monitor.pathUpdateHandler = { path in // Monitor the network status, banner if not connected
            DispatchQueue.main.async {
                self.connected = path.status == .satisfied
            }
        }
        self.monitor.start ( queue: self.worker )
    }
}
