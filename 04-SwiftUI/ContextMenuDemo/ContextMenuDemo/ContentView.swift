//
//  ContentView.swift
//  ContextMenuDemo
//
//  Created by Jungman Bae on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var foregroundColor: Color = .yellow
    @State private var backgroundColor: Color = .black
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .padding()
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
//        앱을 실행하고 "Hello, world!" 텍스트를 길게 누르면 컨텍스트 메뉴가 나타납니다. "Inverted Colors" 옵션을 선택하면 텍스트의 색상이 반전됩니다.
            .contextMenu {
                Button(action: {
                    self.foregroundColor = .black
                    self.backgroundColor = .white
                }, label: {
                    Text("Normal Colors")
                    Image(systemName: "paintbrush")
                })
                Button(action: {
                    self.foregroundColor = .white
                    self.backgroundColor = .black
                }, label: {
                    Text("Inverted Colors")
                    Image(systemName: "paintbrush.fill")
                })
            }
        
    }
}

#Preview {
    ContentView()
}
