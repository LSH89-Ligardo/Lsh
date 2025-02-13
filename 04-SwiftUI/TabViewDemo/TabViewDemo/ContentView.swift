//
//  ContentView.swift
//  TabViewDemo
//
//  Created by Jungman Bae on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection) {
            Text("First Content View")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Screen One")
                }
                .tag(0)
            Text("Second Content View")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Screen Two")
                }
                .tag(1)
            Text("Third Content View")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Screen Three")
                }
                .tag(2)
        }
        .font(.largeTitle)
        // 페이지 뷰 형태의 탭을 구성하는 예시
        .tabViewStyle(PageTabViewStyle())
        // 별도의 버튼을 이용해 탭을 이동
        HStack {
            Spacer()
            Button("1") {
                selection = 0
            }
            .disabled(selection == 0)
            Spacer()
            Button("2") {
                selection = 1
            }
            .disabled(selection == 1)
            Spacer()
            Button("3") {
                selection = 2
            }
            .disabled(selection == 2)
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
