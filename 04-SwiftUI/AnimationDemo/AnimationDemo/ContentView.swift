//
//  ContentView.swift
//  AnimationDemo
//
//  Created by Jungman Bae on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isTextVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                withAnimation(.easeInOut(duration: 1)) {
                    isTextVisible.toggle()
                }
            }, label: {
                Text("Toggle Text")
                    .font(.title2)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
            })
            
            if isTextVisible {
                Text("Hello SwiftUI Animation!")
                    .font(.largeTitle)
                    .padding()
                    .transition(.opacity)
//                    .transition(.scale)
//                    .transition(.slide)
//                    .transition(.move(edge: .leading))
            }
        }
    }
}

#Preview {
    ContentView()
}
