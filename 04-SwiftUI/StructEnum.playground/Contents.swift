
struct SampleStruct {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func buildHelloMsg() -> String {
        // 함수의 한줄 실행구문(줄)의 결과가 함수의 반환타입과 일치하는 경우 return 생략이 가능
        /* return */ "Hello, \(name)"
    }
}

class SampleClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func buildHelloMsg() -> String {
        return "Hello " + name
    }
    
    // 클래스의 값을 복사해서 사용하는 예시 코드
    func clone() -> SampleClass {
        return SampleClass(name: name)
    }
}

// 값 타입
let myStruct1 = SampleStruct(name: "Mark")
var myStruct2 = myStruct1
myStruct2.name = "David"

print(myStruct1.name)  // 출력: Mark
print(myStruct2.name)  // 출력: David

// 참조 타입
let myClass1 = SampleClass(name: "Mark")
var myClass2 = myClass1.clone() // 값을 복사했기 때문에, 달라진다.
myClass2.name = "David"

print(myClass1.name)  // 출력: Mark
print(myClass2.name)  // 출력: David


enum Temperature {
    case hot
    case warm
    case cold(centigrade: Int)
}

func displayTempInfo(temp: Temperature) {
    switch temp {
    case .hot:
        print("Hot")
    case .warm:
        print("Warm")
    case .cold(let centigrade) where centigrade <= 0:
        print("Ice warning: \(centigrade) degrees.")
    case .cold:
        print("It is cold but not freezing.")
    }
}

displayTempInfo(temp: Temperature.cold(centigrade: -10))

