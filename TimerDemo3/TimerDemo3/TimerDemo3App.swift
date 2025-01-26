//
//  TimerDemo3App.swift
//  TimerDemo3
//
//  Created by Seonghoon Lee on 1/24/25.
//

import SwiftUI

@main
struct TimerDemo3App: App {
    var body: some Scene {
        DocumentGroup(newDocument: TimerDemo3Document()) { file in
            ContentView(document: file.$document)
        }
    }
}
