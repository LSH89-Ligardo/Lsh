//
//  SecondTabView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 1/13/25.
//

import SwiftUI

struct SecondTabView: View {
    @State private var text: String = ""

    var body: some View {
        TextEditor(text: $text)
            .padding()
            // text 변수의 변경시 실행되는 수정자
            // 최신 수정 버전 (onAppear 시 실행 여부 확인 파라미터 추가)
            .onChange(of: text, initial: false) {
                print("onChange triggered")
            }
    }
}

#Preview {
    SecondTabView()
}
