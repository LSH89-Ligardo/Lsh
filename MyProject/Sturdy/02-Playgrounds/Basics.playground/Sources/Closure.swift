//
//  Closure.swift
//  
//
//  Created by Jungman Bae on 12/31/24.
//


/// 클로저
/// - {} 중괄호로 감싸져있는 코드 블럭
/// - 변수에 할당할 수 있다
/// - 함수 파라미터로 사용할 수 있다
/// - 클로저 타입을 추론할 수 있어, 종종 생략할 수 있다.
/// - 함수의 마지막 인자가 클로저일때, 후행 클로저로 더 읽기 쉽게 만든다.
/// - $(달러사인) 과 순번(1,2,3,...) 으로 파라미터의 이름(변수명)도 생략할 수 있다.
/// - 자신이 정의된 컨택스트(중괄호 스코프)에서 상수와 변수를 캡처할 수 있다.
public func runClosure() {
    let simpleClosure = { print("Hello World") }

    simpleClosure()

    //let multiply: (Int, Int) -> Int = { (x: Int, y: Int) -> Int in
    //    return x * y
    //} => 아래와 같이 한 줄로 표현 가능
    let multiply: (Int, Int) -> Int = { x, y in x * y }
//    let multiply2: (Int, Int) -> Int = { $0 * $1 }

    print(multiply(5, 6))

    func performOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
        return operation(a, b)
    }

    let addition: (Int, Int) -> Int = { x, y in x + y }

    let result = performOperation(5, 6, operation: multiply)
    print(result)

    let result2 = performOperation(5, 6, operation: addition)
    print(result2)

    // 인라인 함수 정의
    let result3 = performOperation(5, 6, operation: { x, y in x - y })
    print(result3)

    // 후행 클로저
    let numbers = [1, 2, 3, 4, 5]
    //let squaredNumbers = numbers.map { element in element * element }
    let squaredNumbers = numbers.map { $0 * $0 }
    print(squaredNumbers)

    func makeIncrementer(incrementAmount: Int) -> () -> Int {
        var total = 0
        let incrementer: () -> Int = {
            total += incrementAmount
            return total
        }
        return incrementer
    }

    let incrementer = makeIncrementer(incrementAmount: 5)
    print(incrementer()) // 5씩 증가
    print(incrementer()) // 5씩 증가

    let incrementer2 = makeIncrementer(incrementAmount: 10)
    print(incrementer2()) // 10씩 증가
    print(incrementer2()) // 10씩 증가

}
