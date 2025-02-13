//
//  ContentView.swift
//  StackDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import SwiftUI

// 새로운 커스텀 세로 정렬값을 추가
extension VerticalAlignment {
    private enum OneThird: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d.height / 3
        }
    }
    static let oneThird = VerticalAlignment(OneThird.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .oneThird) {
            Rectangle()
                .fill(Color.green)
                .frame(width: 50, height: 200)
            Rectangle()
                .fill(Color.red)
                .alignmentGuide(.oneThird) { d in d[VerticalAlignment.top] }
                .frame(width: 50, height: 200)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 50, height: 200)
            Rectangle()
                .fill(Color.orange)
                .alignmentGuide(.oneThird) { d in d[VerticalAlignment.top] }
                .frame(width: 50, height: 200)
        }
        
        // VStack에서 trailing(오른쪽) 정렬 지정
        // 모든 하위 뷰들이 오른쪽으로 정렬됨
        VStack(alignment: .trailing) {
            Text("This is some text")
            Text("This is some longer text")
            Text("This is short")
        }
        
        // HStack에서 .lastTextBaseline 정렬 사용
        // 텍스트의 마지막 기준선을 기준으로 정렬되어 시각적으로 일관된 모습을 보여줌
        // spacing: 20으로 각 텍스트 사이 간격을 20포인트로 지정
        HStack(alignment: .lastTextBaseline, spacing: 20) {
            Text("This is some text")
                .font(.largeTitle)    // 가장 큰 폰트 사이즈
            Text("This is some much longer text")
                .font(.body)          // 기본 폰트 사이즈
            Text("This is short")
                .font(.headline)      // 중간 크기 강조 폰트
        }
        
        // VStack에서 leading(왼쪽) 정렬 지정
        VStack(alignment: .leading) {
            // 기본 녹색 사각형 - 기본 leading 정렬 사용
            Rectangle()
                .fill(Color.green)
                .frame(width: 120, height: 50)
            
            // 빨간색 사각형 - alignmentGuide로 커스텀 정렬 위치 지정
            // dimensions: 뷰의 크기와 위치 정보를 담고 있는 ViewDimensions 객체
            // dimensions.width: 뷰의 전체 너비
            // width/3: 뷰 너비의 1/3 지점에 leading 포인트를 위치시킴
            Rectangle()
                .fill(Color.red)
                .alignmentGuide(.leading, computeValue: { dimensions in
                    dimensions.width / 3
                })
                .frame(width: 200, height: 50)
            
            // 파란색 사각형 - trailing 기준 커스텀 정렬
            // dimensions[.trailing]: 뷰의 오른쪽 끝 위치값
            // trailing + 20: 오른쪽 끝에서 20포인트 더한 지점을 leading 포인트로 지정
            // 결과적으로 이전 뷰보다 오른쪽으로 20포인트 이동한 위치에서 시작
            Rectangle()
                .fill(Color.blue)
                .alignmentGuide(.leading, computeValue: { dimensions in
                    dimensions[.trailing] + 20
                })
                .frame(width: 180, height: 50)
        }
    }
}

#Preview {
    ContentView()
}
