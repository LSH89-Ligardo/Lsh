//
//  SecondView.swift
//  ObservableDemo
//
//  Created by Jungman Bae on 1/13/25.
//

import SwiftUI

struct SecondView: View {
    @Environment(TimerData.self) var timerData
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            Text("Timer Count = \(timerData.timeCount)")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    SecondView()
        // 느슨한 결합인 만큼 초기화를 위한 환경변수 세팅이 필요함
        .environment(TimerData())
}
