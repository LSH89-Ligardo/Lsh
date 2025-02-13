import Foundation

public func runOptional() {
    var dayOfTheWeek: String = "Monday"
    dayOfTheWeek = "Tuesday"
    print(dayOfTheWeek)
    dayOfTheWeek = "Wednesday"
    print(dayOfTheWeek)
    //dayOfTheWeek = nil 컴파일 시 오류 발생
    dayOfTheWeek = "" // 빈 문자열이 최선

    var numberOfFingersHeldUpByFinn: Int?
    numberOfFingersHeldUpByFinn = nil
    print(numberOfFingersHeldUpByFinn ?? "모름")

    numberOfFingersHeldUpByFinn = 3

    //print(numberOfFingersHeldUpByFinn != nil ? numberOfFingersHeldUpByFinn : "모름")
    print(numberOfFingersHeldUpByFinn ?? "모름")
    //print(numberOfFingersHeldUpByFinn)

    // 강제 언래핑
    //let lastNumberOfFingersHeldUpByFinn: Int = numberOfFingersHeldUpByFinn!

    // 조건부 언래핑
    // Swift 5.7 부터 옵셔널 변수명에 if let 사용 가능
    if let numberOfFingersHeldUpByFinn {
        // 값이 nil 이 아니면 실행
        print(numberOfFingersHeldUpByFinn)
    } else {
        print("모름")
    }
    // if let numberOfFingerHeld  if 구문 안에서만 사용가능
    // guard
    guard let numberOfFingersHeldUpByFinn else {
        // 값이 없으면 실행
        print("모름")
        return
    }
    print(numberOfFingersHeldUpByFinn)
    // guard 구문 이후의 함수 내부에서 계속 사용가능
//    print(numberOfFingerHeld)
}

