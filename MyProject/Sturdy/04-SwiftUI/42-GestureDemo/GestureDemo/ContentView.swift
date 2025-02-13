//
//  ContentView.swift
//  GestureDemo
//
//  Created by Jungman Bae on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    let tap = TapGesture(count: 2)
        .onEnded({ _ in
            print("Double Tap")
        })
    
    let longPress = LongPressGesture()
        .onEnded({ _ in
            print("Long Press")
        })
        
    // @GestureState: 제스처가 진행되는 동안 값이 유지되고, 제스처가 끝나면 초기값으로 돌아감
    @GestureState var magnificationScale: CGFloat = 1
    
    var body: some View {
        let magnification = MagnificationGesture(minimumScaleDelta: 1)
        // updating
        // value: 현재 제스처의 값 (확대, 축소 비율)
        // state: 제스처의 상태를 저장하는 변수 ( $magnificationScale)
        // transaction: 애니메이션 트랜잭션 정보
            .updating($magnificationScale) {
                value, state, transaction in
                state = value
                print("Magnifying")
            }
            .onEnded { _ in
                print("Magnifying End")
            }

        Image(systemName: "hand.point.right.fill")
            .gesture(tap)
            .gesture(longPress)
            .gesture(magnification)
            .scaleEffect(magnificationScale)
            .frame(width: 100, height: 90)
    }
}

#Preview {
    ContentView()
}
