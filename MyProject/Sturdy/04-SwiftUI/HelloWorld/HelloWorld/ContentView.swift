//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // 18 버전이후 새로운 탭 구현 방법
            Tab("First", systemImage: "01.circle") {
                FirstTabView()
            }
            Tab("Second", systemImage: "02.circle") {
                SecondTabView()
            }
//                .tabItem {
//                    Image(systemName: "01.circle")
//                    Text("First")
//                }
//                .tabItem {
//                    Image(systemName: "02.circle")
//                    Text("Second")
//                }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
