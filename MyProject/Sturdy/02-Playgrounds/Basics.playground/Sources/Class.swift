//
//  Class.swift
//  
//
//  Created by Jungman Bae on 12/31/24.
//

/// 클래스를 사용하는 경우:
/// - 참조가 필요
/// - 상속이 필요할 때
/// - 인스턴스의 identity를 제어해야할 때
fileprivate class Person {
    public var givenName: String
    let middleName: String?
    let familyName: String
    var country: String = "KR"
    
    public init(givenName: String, middleName: String? = nil, familyName: String) {
        self.givenName = givenName
        self.middleName = middleName
        self.familyName = familyName
    }
    
    var displayName: String {
        return "\(fullName()) - Location: \(country)"
    }
    
    func fullName() -> String {
        var fullName: String = ""
        if let middleName { fullName += middleName + " " }
        fullName += self.givenName + " " + self.familyName
        return fullName
    }
    
    static func createDummyPerson() -> Person {
        return Person(givenName: "John", familyName: "Doe")
    }
}

fileprivate final class Friend: Person {
    var whereWeMet: String?
    
    override var displayName: String {
        return super.displayName + " - Where we met: \(self.whereWeMet ?? "Unknown")"
    }
}
//class BusinessRelation: Friend {} // final 로 인해 더이상 상속 불가

fileprivate final class Family: Person {
    let relationship: String
    
    init(givenName: String, middleName: String? = nil, familyName: String = "Barker", relationship: String) {
        self.relationship = relationship
        super.init(givenName: givenName, middleName: middleName, familyName: familyName)
    }
    
    override var displayName: String {
        return super.displayName + " - Relationship: \(self.relationship)"
    }
}


public func runClass() {
    let person = Person.createDummyPerson()
    print(person.fullName())

    let person2 = Person(givenName: "Jane", familyName: "Doe")
    print(person2.fullName())

    let person3 = Person.createDummyPerson()
    person3.country = "US"
    print(person3.displayName)
    print(person.displayName)

    let friend = Friend(givenName: "길동", familyName: "홍")
    friend.whereWeMet = "London"
    print(friend.displayName)

    print("------------------------------")

    let steve = Person(givenName: "Steve", middleName: "Paul", familyName: "Jobs")
    let sam = Friend(givenName: "Sam", middleName: "Now", familyName: "Rowley")
    sam.whereWeMet = "Work together at Jaguar Land Rover"
    let maddie = Family(givenName: "Maddie", middleName: "Rose", relationship: "Daughter")
    let mark = Family(givenName: "Mark", middleName: "David", familyName: "Pendlebury", relationship: "Brother-In-Law")
    mark.country = "USA"

    print(steve.displayName)
    print(sam.displayName)
    print(maddie.displayName)
    print(mark.displayName)
    
    let person1 = Person(givenName: "Jungman", familyName: "Bae")

    // 클래스의 복사는 주소의 복사, 같은 주소를 바라보게 됨. 변경시 같이 변경
    let person4 = person1
    person4.givenName = "Jungman2"
    print(person1.givenName)
    print(person4.givenName)
    // ObjectIdentifier 비교
    print(person1 === person4)
}
