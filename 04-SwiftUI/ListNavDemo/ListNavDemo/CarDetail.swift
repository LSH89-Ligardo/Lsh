//
//  CarDetail.swift
//  ListNavDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import SwiftUI

// 차량 상세 정보를 보여주는 뷰
struct CarDetail: View {
   // 선택된 차량 정보를 저장하는 상수
   let selectedCar: Car
   
   var body: some View {
       Form {
           // 차량 상세 정보 섹션
           Section(header: Text("Car Details")) {
               // 차량 이미지
               Image(selectedCar.imageName)
                   .resizable()
                   // iOS 17부터 지원하는 새로운 cornerRadius 적용 방식
                   .clipShape(.rect(cornerRadius: 12))
                   .aspectRatio(contentMode: .fit)
                   .padding()
               
               // 차량 이름
               Text(selectedCar.name)
                   .font(.headline)
               
               // 차량 설명
               Text(selectedCar.description)
                   .font(.body)
               
               // 하이브리드 여부를 아이콘으로 표시
               HStack {
                   Text("Hybrid").font(.headline)
                   Spacer()
                   // isHybrid 값에 따라 다른 SF Symbols 아이콘 표시
                   Image(systemName: selectedCar.isHybrid ? "checkmark.circle" : "xmark.circle")
               }
           }
       }
   }
}

// 프리뷰에서 첫 번째 차량 데이터로 미리보기 생성
#Preview {
   CarDetail(selectedCar: carData[0])
}
