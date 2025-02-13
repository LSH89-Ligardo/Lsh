// 오래걸리는 작업, 비동기 호출을 위해, 플레이그라운드 페이지의 무기한 실행을 허용하는 설정
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// 각종 기능 집합, 네트워킹, 날짜, 시간 등 자주 사용되는 기능을 미리 정의해둔 기본 라이브러리
import Foundation
// iOS 운영체제에서 사용되는 UI 구성을 위한 라이브러리
import UIKit

// Foundation 라이브러리 > 네트워킹
let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

let urlString = "https://imgs.xkcd.com/comics/api.png"
let url = URL(string: urlString)!
let request = URLRequest(url: url)

print("1")
let task = session.dataTask(with: request) { data, response, error in
    // 요청에 대한 결과 처리
    print("3")
    guard let imageData = data else { return }
    _ = UIImage(data: imageData)
}
print("2")

task.resume()
