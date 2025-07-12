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
        self.monitor.start ( queue: self.worker )

        self.monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.connected = path.status == .satisfied
            }
        }
    }
}
