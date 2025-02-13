
// 1 0 0 0 0 0 0 0 = -128
// 0 1 1 1 1 1 1 1 = 127

let minInt8 = Int8.min
let maxInt8 = Int8.max

print("Int8 min: \(minInt8), max: \(maxInt8)")

// 0 0 0 0 0 0 0 0 = 0
// 1 1 1 1 1 1 1 1 = 255
let minUInt8 = UInt8.min
let maxUInt8 = UInt8.max

print("UInt8 min: \(minUInt8), max: \(maxUInt8)")

// 정수 리터럴
let decimalInteger = 17
let binaryInteger = 0b10111 // 2진수
let octalInteger = 0o777 // 8진수 (2의 세제곱) => 0 또는 1 자리수가 세개 0b000 / 0b111
let hexInteger = 0xFF // 16진수 >> 2진수 4개 1111 1111 1111 111

print("decimalInteger: \(decimalInteger), binaryInteger: \(binaryInteger), octalInteger: \(octalInteger), hexInteger: \(hexInteger)")

// 숫자 구분자 (Swift 5.1 이후)
let largeNumber = 1_000_000_000
print(largeNumber)


