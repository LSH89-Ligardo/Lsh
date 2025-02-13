//
//  ContentView.swift
//  ObservableDemo
//
//  Created by Jungman Bae on 1/13/25.
//

import SwiftUI

struct ContentView: View {
    // @Observable 지정 객체는 @State 로 상태 관리가 가능해짐 (2024 이후)
    @State var timerData: TimerData = TimerData()
    
    var body: some View {
        // NavigationView 는 NavigationStack 으로 이름 변경됨
        NavigationStack {
            VStack {
                Text("Timer count = \(timerData.timeCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Button(action: resetCount) {
                    Text("Reset Counter")
                }
                
                NavigationLink("Next Screen", destination: {
                    SecondView()
                })
            }
        }
        .environment(timerData)
    }
    
    func resetCount() {
        timerData.resetCount()
    }
}

#Preview {
    ContentView()
}
