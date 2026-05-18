//
//  Network.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 14/06/2023.
//

import Network
import SwiftUI

@Observable
class NetworkMonitor {
    private let monitor = NWPathMonitor ( )
    private let worker = DispatchQueue ( label: "NetMonitor" )
    var connected: Bool = true

    init ( ) {
        self.monitor.start ( queue: self.worker )

        self.monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor [weak self] in
                self?.connected = path.status == .satisfied
            }
        }
    }
}
