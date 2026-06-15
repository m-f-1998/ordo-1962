//
//  App.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 18/04/2023.
//

import SwiftUI
import UIKit

@main
struct OrdoiOS: App {
    @State private var activeData: ActiveData
    @State private var api: API
    @State private var tabStateHandler = TabStateHandler ( )
    let net = NetworkMonitor ( )

    init ( ) {
        let activeData = ActiveData ( )
        _activeData = State ( initialValue: activeData )
        _api = State ( initialValue: API ( activeData: activeData ) )
        preWarmKeyboard ( )
        FastingNotificationManager.shared.register ( )
    }

    var body: some Scene {
        WindowGroup {
            ContentView ( api: api )
        }
        .environment ( activeData )
        .environment ( tabStateHandler )
        .environment ( net )
        .modelContainer ( api.cache.GetContainer ( ) )
    }
}

private func preWarmKeyboard ( ) {
    DispatchQueue.main.asyncAfter ( deadline: .now ( ) + 0.5 ) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap ( { $0 as? UIWindowScene } )
            .flatMap ( { $0.windows } )
            .first ( where: { $0.isKeyWindow } ) else { return }
        let field = UITextField ( frame: .zero )
        window.addSubview ( field )
        field.becomeFirstResponder ( )
        field.resignFirstResponder ( )
        field.removeFromSuperview ( )
    }
}
