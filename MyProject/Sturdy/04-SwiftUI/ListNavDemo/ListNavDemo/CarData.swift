//
//  CarData.swift
//  ListNavDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import Foundation

// JSON 파일에서 로드한 Car 배열을 저장하는 전역 변수
var defaultCarData: [Car] = loadJsonFromBundle("carData.json")

// 내 문서의 파일에서 가져오기 한 후, nil 이면 기본 번들 데이터 사용
var carData: [Car] = loadJsonFromDocuments() ?? defaultCarData

// 내 문서의 파일로부터 Car 배열을 가져오는 함수 ( 파일이 없거나, 디코드 되지 않으면 nil )
func loadJsonFromDocuments() -> [Car]? {
    let documentURL = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask).first!
    let fileURL = documentURL.appendingPathComponent("carData.json")
    guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
    
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let result = try decoder.decode([Car].self, from: data)
        return result
    } catch {
        print("Unable to decode \(fileURL): \(error)")
        return nil
    }
}


// 제네릭을 사용한 JSON 파일 로드 함수
// T는 Decodable 프로토콜을 준수해야 함
func loadJsonFromBundle<T: Decodable>(_ filename: String) -> T {
   let data: Data
   
   // 번들에서 파일 URL을 가져옴
   // 실패 시 fatalError 발생
   guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
           else { fatalError("Couldn't find \(filename)") }
   
   do {
       // URL에서 데이터를 로드
       data = try Data(contentsOf: file)
   } catch {
       fatalError("Couldn't load \(filename): \(error)")
   }
   
   do {
       // JSONDecoder를 사용하여 데이터를 지정된 타입 T로 디코딩
       let decoder = JSONDecoder()
       let result = try decoder.decode(T.self, from: data)
       return result
   } catch {
       // 파싱 실패 시 fatalError 발생
       fatalError("Unable to parse \(filename): \(error)")
   }
}

func saveJsonToDocuments(_ data: [Car]) {
    let documentURL = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask).first!
    let fileURL = documentURL.appendingPathComponent("carData.json")
    
    do {
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(data)
        try encodedData.write(to: fileURL, options: [.atomic])
        print("Save Success")
    } catch {
        print("Failed to save \(fileURL): \(error)")
    }
}
