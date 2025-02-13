//
//  ContentView.swift
//  OXQuiz
//
//  Created by Jungman Bae on 1/10/25.
//

import SwiftUI

struct ContentView: View {
    @State var number1: Int = 4
    @State var number2: Int = 2
    @State var resultNumber: Int = 9
    @State var countCorrect: Int = 0
    @State var countWrong: Int = 0
    
    var body: some View {
        VStack {
            Text("다음 수식은 맞을까요?")
                .font(.largeTitle)
                .padding(.top, 20)
            Spacer()
            Text("\(number1) x \(number2) = \(resultNumber)")
                .font(.largeTitle)
                .padding()
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    selectCorrect()
                },
                       label: {
                    Label("맞음", systemImage: "checkmark.diamond.fill")
                        .foregroundStyle(.green)
                })
                Spacer()
                Button(action: {
                    selectWrong()
                },
                       label: {
                    Label("틀림", systemImage: "xmark.diamond")
                        .foregroundStyle(.red)
                })
                Spacer()
            }
            .font(.system(size: 35, weight: .bold))
            Spacer()
            HStack {
                Spacer()
                Text("\(countCorrect)개 맞춤")
                Spacer()
                Text("\(countWrong)개 틀림")
                Spacer()
            }
            .font(.system(size: 30))
            Spacer()
            Button("카운트 초기화", action: {
                reloadGame()
            })
                .font(.system(size: 30))
                .padding(.bottom, 20)
        }
        .onAppear {
            reloadGame()
        }
    }
    
    
    func reloadGame() {
        // 게임 재시작 로직
        countCorrect = 0
        countWrong = 0
        makeQuestion()
    }
    
    func selectCorrect() {
        // 정답 선택 시 로직
        if resultNumber == number1 * number2 {
            countCorrect += 1
        } else {
            countWrong += 1
        }
        makeQuestion()
    }
    
    func selectWrong() {
        // 오답 선택 시 로직
        if resultNumber != number1 * number2 {
            countCorrect += 1
        } else {
            countWrong += 1
        }
        makeQuestion()
    }
    
    func makeQuestion() {
        number1 = Int.random(in: 1...10)
        number2 = Int.random(in: 1...10)
        
        if Int.random(in: 0...1) == 0 {
            resultNumber = number2 * number1
        } else {
            resultNumber = number1 * number2 + Int.random(in: -2...2)
        }
    }
}

#Preview {
    ContentView()
}
