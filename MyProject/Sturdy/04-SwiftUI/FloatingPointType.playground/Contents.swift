
let pi = 3.14159265358979323846
print(pi)

let anotherPi: Double = 3 + 0.14159265358979323846
print(anotherPi)

// 지수 표기법
let exponentTen = 1.25e2
print("1.25e2 = \(exponentTen)")

let exponentSixteen = 0xFp2
print("0xFp2 = \(exponentSixteen)") // 15 * 2^2 = 60

// Float와 Double 의 정밀도 비교
let f1: Float = 1.0
let f2: Float = 0.3
let f3: Float = 0.7
let f4: Float = f2 + f3

let d1: Double = 1.0
let d2: Double = 0.3
let d3: Double = 0.7
let d4: Double = d2 + d3

print("Float: \(f1) - \(f2) = \(f1 - f4)")
print("Double: \(d1) - \(d2) = \(d1 - d4)")

