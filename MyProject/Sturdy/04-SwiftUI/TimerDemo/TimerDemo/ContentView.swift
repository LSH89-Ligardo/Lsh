//
//  ContentView.swift
//  TimerDemo
//
//  Created by Jungman Bae on 1/24/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    // 타이머 설정 값 (초 단위)
    @State private var timeRemaining: Int = 60
    @State private var isRunning: Bool = false
    @State private var timer: AnyCancellable?
    
    var body: some View {
        VStack {
            // 시간을 MM:SS 형식으로 표시
            Text("\(String(format: "%02d", timeRemaining / 60)):\(String(format: "%02d", timeRemaining % 60))")
                .font(.system(size: 50, weight: .bold))
                .onTapGesture {
                    // 타이머 설정 순환: 1분 -> 5분 -> 10분 -> 1분
                    if !isRunning { // 타이머가 실행중이 아닐 때만 변경 가능
                        if timeRemaining < 300 {
                            timeRemaining = 300 // 5분
                        } else if timeRemaining < 600 {
                            timeRemaining = 600 // 10분
                        } else {
                            timeRemaining = 60 // 1분
                        }
                    }
                }
            
            HStack {
                // 시작/정지 버튼
                Button(action: {
                    if !isRunning {
                        startTimer()
                    } else {
                        stopTimer()
                    }
                }) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding()
                }
                
                // 리셋 버튼
                Button(action: {
                    stopTimer()
                    timeRemaining = 60
                }) {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding()
                }
            }
        }
        .padding()
    }
    
    private func startTimer() {
        guard !isRunning, timeRemaining > 0 else { return }
        
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common) // 1초 간격으로 수정
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                if timeRemaining == 0 {
                    stopTimer()
                }
            }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.cancel()
        timer = nil
    }
}

#Preview {
    ContentView()
}
