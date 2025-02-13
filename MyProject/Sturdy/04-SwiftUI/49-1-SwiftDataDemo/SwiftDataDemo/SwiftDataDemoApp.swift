//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Jungman Bae on 1/16/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Product.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
