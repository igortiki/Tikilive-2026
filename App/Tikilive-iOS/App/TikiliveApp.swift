//
//  TikiliveApp.swift
//  Tikilive
//
//  Created by Igor Malasevschi on 10/30/26
//

import SwiftUI
import TikiliveCore

@main
struct TikiliveApp: App {
    private let dependencies = AppDependencies(configuration: .tiki6)
    
    
    var body: some Scene {
        WindowGroup {
            RootView(dependencies: dependencies)
        }
    }
}
