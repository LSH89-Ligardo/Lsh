//
//  ContentView.swift
//  WidgetDemo
//
//  Created by Jungman Bae on 1/22/25.
//

import SwiftUI

struct WeatherType: Hashable {
    var name: String
    var icon: String
}
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
