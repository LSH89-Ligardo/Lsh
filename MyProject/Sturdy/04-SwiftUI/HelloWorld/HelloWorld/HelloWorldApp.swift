//
//  HelloWorldApp.swift
//  HelloWorld
//
//  Created by Jungman Bae on 1/8/25.
//

import SwiftUI

@main
struct HelloWorldApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase, initial: true) {
            switch scenePhase {
            case .active:
                print("Active")
            case .inactive:
                print("Inactive")
            case .background:
                print( "Background")
            default :
                print("Unknown")
                
            }
        }
    }
}
