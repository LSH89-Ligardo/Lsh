//
//  ContentView.swift
//  ListNavDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import SwiftUI

struct ContentView: View {
   // CarStore 인스턴스를 상태로 관리
   @State var carStore = CarStore(cars: carData)
   // 네비게이션 스택의 경로를 관리하는 상태 변수
   @State var stackPath = NavigationPath()
   
   var body: some View {
       // 프로그래매틱 네비게이션을 위한 NavigationStack
       NavigationStack(path: $stackPath) {
           List {
               // 각 차량에 대한 네비게이션 링크 생성
               ForEach(carStore.cars) { car in
                   NavigationLink(value: car) {
                       ListCell(car: car)
                   }
               }
               // 스와이프로 삭제 기능 추가
               .onDelete(perform: deleteItems)
               // 드래그로 순서 변경 기능 추가
               .onMove(perform: moveItems)
           }
           .navigationTitle(Text("EV Cars"))
           .toolbar {
               // 왼쪽 상단에 새 차량 추가 버튼
               ToolbarItem(placement: .topBarLeading) {
                   NavigationLink(value: "Add Car") {
                       Text("Add")
                           .foregroundStyle(.blue)
                   }
               }
               // 오른쪽 상단에 편집 버튼
               ToolbarItem(placement: .topBarTrailing) {
                   EditButton()
               }
           }
           // "Add Car" 문자열에 대한 네비게이션 목적지 정의
           .navigationDestination(for: String.self) { menuString in
               if menuString == "Add Car" {
                   AddNewCar(carStore: carStore, path: $stackPath)
               }
           }
           // Car 타입에 대한 네비게이션 목적지 정의
           .navigationDestination(for: Car.self) { car in
               CarDetail(selectedCar: car)
           }
       }
   }
   
   // 선택된 항목 삭제 함수
   func deleteItems(offsets: IndexSet) {
       carStore.cars.remove(atOffsets: offsets)
   }
   
   // 항목 위치 이동 함수
   func moveItems(from source: IndexSet, to destination: Int) {
       carStore.cars.move(fromOffsets: source, toOffset: destination)
   }
}

// 프리뷰 제공
#Preview {
   ContentView()
}

// 리스트 셀을 위한 커스텀 뷰
struct ListCell: View {
   var car: Car
   
   var body: some View {
       HStack {
           // 차량 이미지
           Image(car.imageName)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 100, height: 60)
           // 차량 이름
           Text(car.name)
       }
   }
}
