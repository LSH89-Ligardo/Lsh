import UIKit

var index: Int?
index = 3

var treeArray = ["Oak", "Apple", "Banana", "Birch"]

if index != nil {
    print(treeArray[index!]) // 강제 언래핑
} else {
    print("값이 할당되지 않았을때")
}

// 조건부 언래핑
// if let index = index => 축약해서 사용 가능
if let index {
    // 이 중괄호 안에서는 옵셔널이 아닌 Int 타입으로 사용 가능
    print(treeArray[index])
}

var optionalName1: String?
var optionalName2: String?
var optionalName3: String?

optionalName1 = "Swift"
optionalName2 = "Programming"
optionalName3 = "Language"

if let name1 = optionalName1,
   let name2 = optionalName2,
   let name3 = optionalName3 {
    print("\(name1) \(name2) \(name3)")
}


var myDictionary = Dictionary<String, Int>()
myDictionary["Swift"] = 100
myDictionary["Programming"] = 200
myDictionary["Language"] = 300

// 딕셔너리의 값 엑세스는 값이 없을 수 있기 때문에, 옵셔널타입으로 값을 전달
print(myDictionary["C++"] ?? 0) // 기본값
if let value = myDictionary["C++"] {
    print(value)
} else {
    print(0)
}

// 타입 캐스팅
let value = myDictionary["Swift"] as! Int
print(value)

// UIView -> UIControl -> UIButton 순으로 상속 관계
let myButton: UIButton = UIButton()
let myControl = myButton as UIControl // 타입 캐스팅 ( 업 캐스팅 )

// UIScrollView ->  UITextView
let myScrollView: UIScrollView = UIScrollView()
//let myTextView = myScrollView as! UITextView // 강제 타입 캐스팅 ( 다운 캐스팅 )

// 조건부 타입 캐스팅
if let myTextView = myScrollView as? UITextView {
    print(myTextView.text ?? "")
} else {
    print("UITextView 로 타입 캐스팅 하지 못했습니다.")
}

// ClosedRange
let closedRange = 1...5

// Range
let range = 0..<5

// PartialRangeFrom
let range2 = 0...

// PartialRangeThrough
let range3 = ...5

// PartialRangeUpTo
let range4 = ..<5
