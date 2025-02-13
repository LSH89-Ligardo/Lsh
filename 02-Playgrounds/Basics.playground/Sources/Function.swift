//
//  Function.swift
//  
//
//  Created by Jungman Bae on 12/31/24.
//

func fullName(이름 givenName: String = "길동",
              중간이름 middleName: String? = nil,
              성 familyName: String = "홍") -> String {
    var fullName = familyName
    if let middleName { fullName += " \(middleName)" }
    fullName += " \(givenName)"
    return fullName
}


/// 함수이름
/// - Parameters:
///   - string1: 1
///   - string2: 2
/// - Returns: 1 " " 2
func combine(_ string1: String, _ string2: String) -> String {
    return "\(string1) \(string2)"
}

func combine(_ int1: Int, _ int2: Int) -> Int {
    return int1 + int2
}

func combine(_ int1: Int, _ string1: String) -> String {
    return "\(int1) \(string1)"
}


public func runFunction() {
    let myFullName = fullName(이름: "정만", 성: "배")
    print(myFullName)

    let myFullName2 = fullName()
    print(myFullName2)

    let combineString = combine("Hello", "World")
    print(combineString)

    let combineInt = combine(1, 2)
    print(combineInt)

    let combineMix = combine(1, "world")
    print(combineMix)

}
