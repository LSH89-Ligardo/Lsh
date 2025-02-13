import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

enum ResponsError: Error {
    case requestFailed
    case unexpectedResponseStructure
}

func fetchRepos(forUsername username: String,
                completionHandler: @escaping ([[String: Any]]?, ResponsError?) -> Void) {
    let urlString = "https://api.github.com/users/\(username)/repos"
    let url = URL(string: urlString)!
    
    var request = URLRequest(url: url)
    request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
//    request.setValue("SwiftPlayground", forHTTPHeaderField: "User-Agent")
    
    Task {
        do {
            // 비동기 실행 이전
            let (data, response) = try await URLSession.shared.data(for: request)
//            print(response)
            // 비동기 실행 이후
            let deserialized = try JSONSerialization.jsonObject(with: data, options: [])
            guard let repos = deserialized as? [[String: Any]] else {
                completionHandler(nil, .unexpectedResponseStructure)
                return
            }
            completionHandler(repos, nil)
        } catch {
            print(error)
            completionHandler(nil, .requestFailed)
        }
    }
}

print("1")
fetchRepos(forUsername: "apple") { repos, error in
    print("3")
    if let error {
        print("Error: \(error)")
        return
    }
    print("Repos: \(repos!.count)")
}
print("2")

