//
//  ContentView.swift
//  TimerDemo4
//
//  Created by Seonghoon Lee on 1/24/25.
//

import SwiftUI
import AVFoundation
struct ContentView: View {
@State private var timeRemaining: Int = 60 // 초기 타이머 시간 (초 단위)
@State private var isTimerActive: Bool = false // 타이머 활성화 여부
@State private var timerDurationHour: Int = 0 // 시 단위 입력
@State private var timerDurationMinutes: Int = 1 // 분 단위 입력
@State private var timerDurationSeconds: Int = 0 // 초 단위 입력
@State private var soundPlayer: AVAudioPlayer? // 알람 소리 재생기
@State private var progress: CGFloat = 0 // 애니메이트 바의 진행 상태
@State private var birdPosition: CGFloat = -100 // 새의 초기 위치

let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

var body: some View {
    VStack(spacing: 40) {
        // 타이머 남은 시간 표시
        Text(convertSecondsToTime(timeInSeconds: timeRemaining))
            .font(.system(size: 50))
            .onReceive(timer) { _ in
                updateTimer()
            }
        
        // 애니메이트 바
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 20)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * progress, height: 20)
            }
            .cornerRadius(10)
        }
        .frame(height: 20)
        
        // 새 애니메이션
        Image(systemName: "bird")
            .resizable()
            .frame(width: 50, height: 50)
            .offset(x: birdPosition, y: 0)
            .animation(.linear(duration: 1), value: birdPosition)
        
        // 시간 설정 (시,분, 초)
        VStack(spacing: 10) {
            HStack {
                Text("시:")
                Stepper("\(timerDurationHour)", value: $timerDurationHour, in: 0...59)
                    .frame(width: 100)
            }
            HStack {
                Text("분:")
                Stepper("\(timerDurationMinutes)", value: $timerDurationMinutes, in: 0...59)
                    .frame(width: 100)
            }
            HStack {
                Text("초:")
                Stepper("\(timerDurationSeconds)", value: $timerDurationSeconds, in: 0...59)
                    .frame(width: 100)
            }
        }
        
        // 버튼들
        HStack(spacing: 20) {
            Button(action: startTimer) {
                Text("시작")
                    .font(.title2)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(200)
            }
            
            Button(action: stopTimer) {
                Text("정지")
                    .font(.title2)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(200)
            }
            
            Button(action: resetTimer) {
                Text("리셋")
                    .font(.title2)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(200)
            }
        }
    }
    .padding()
    .onAppear {
        prepareSound()
    }
}

// 타이머 업데이트
private func updateTimer() {
    guard isTimerActive else { return }
    
    if timeRemaining > 0 {
        timeRemaining -= 1
        
        let totalDuration = timerDurationHour * 3600 + timerDurationMinutes * 60 + timerDurationSeconds
        progress = CGFloat(1 - (Double(timeRemaining) / Double(totalDuration)))
        birdPosition = CGFloat(-100 + (1 - (Double(timeRemaining) / Double(totalDuration))) * 300) // 새의 위치 업데이트
        
        if timeRemaining == 0 {
            playSound()
            isTimerActive = false
        }
    }
}

// 초를 시간 문자열로 변환
func convertSecondsToTime(timeInSeconds: Int) -> String {
    let hours = timeInSeconds / 3600
    let minutes = (timeInSeconds % 3600) / 60
    let seconds = timeInSeconds % 60
    return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
}

// 타이머 시작
func startTimer() {
    timeRemaining = timerDurationHour * 3600 + timerDurationMinutes * 60 + timerDurationSeconds
    isTimerActive = true
    progress = 0 // 진행 상태 초기화
    birdPosition = -100 // 새 위치 초기화
}

// 타이머 정지
func stopTimer() {
    isTimerActive = false
}

// 타이머 리셋
func resetTimer() {
    stopTimer()
    timeRemaining = 60 // 초기값으로 리셋
    timerDurationHour = 0
    timerDurationMinutes = 1
    timerDurationSeconds = 0
    progress = 0
    birdPosition = -100
}

// 알람 소리 준비
func prepareSound() {
    guard let url = Bundle.main.url(forResource: "alarm", withExtension:"mp3") else {
        print("알람 소리 파일을 찾을 수 없습니다.")
        return
    }
    do {
        soundPlayer = try AVAudioPlayer(contentsOf: url)
        soundPlayer?.prepareToPlay()
    } catch {
        print("알람 소리 준비 중 오류 발생: \(error.localizedDescription)")
    }
}

// 알람 소리 재생
func playSound() {
    soundPlayer?.play()
}
}
#Preview {
ContentView()
}
