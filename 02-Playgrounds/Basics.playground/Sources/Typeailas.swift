//
//  Typeailas.swift
//  
//
//  Created by Jungman Bae on 1/2/25.
//

public func runTypealias() {
    var pugs = [Pug]() // let pugs = Array<Pug>()
    var grumble = Grumble()

    let marty = Pug(name: "Marty")
    let wolfie = Pug(name: "Wolfie")
    let buddy = Pug(name: "Buddy")

    pugs.append(contentsOf: [marty, wolfie, buddy])
    grumble.append(contentsOf: [marty, wolfie, buddy])

    let fetcher = ProgrammeFetcher()

    // 타입별칭의 풀네임
    let resultHandler: ProgrammeFetcher.FetchResultHandler = { programName, error in
        guard let programName else {
            print("No programme found")
            return
        }
        guard error == nil else {
            print("Error fetching programme: \(error!)")
            return
        }
        print(programName)
    }
    print("==============================")
    fetcher.fetchCurrentProgrammeName(forChannel: .BBC1,
                                      resultHandler: resultHandler)

}

struct Pug {
    let name: String
}

typealias Grumble = [Pug] // == Array<Pug>

enum Channel {
    case BBC1
    case BBC2
    case BBCNews
    //...
}

class ProgrammeFetcher {
    typealias FetchResultHandler = (String?, Error?) -> Void
    
    func fetchCurrentProgrammeName(forChannel channel: Channel,
                                   resultHandler: FetchResultHandler) {
        // 현재 프로그램을 가져오는 작업 수행
        let exampleProgramName = "Sherlock"
        resultHandler(exampleProgramName, nil)
        // 프로그램 정보가 없을때 예시
        // resultHandler(nil, nil)
    }
    
    func fetchNextProgrammeName(forChannel channel: Channel,
                                resultHandler: FetchResultHandler) {
        // 다음 프로그램을 가져오는 작업 수행
        let exampleProgramName = "Luther"
        resultHandler(exampleProgramName, nil)
    }
}
